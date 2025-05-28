using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.IO;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Linq;

namespace WebRedaTest
{
    public partial class Process : System.Web.UI.Page
    {
        //string role = "Direction commercial"; // récupéré dynamiquement
        string role = "";

        static string currentUserId = "";
        static string defaultUserId = "1";
        // string currentUserId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? defaultUserId;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["role"] != null)
                // {
                currentUserId = HttpContext.Current.Session["ID_USER"] as string;
                role = HttpContext.Current.Session["ROLE_"] as string;
                //role = Session["ROLE_"] as string;
                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }


                // }
                // else
                // {
                //role = "Administrateur";
                //role = "Chargé d'affaires";
                //      role = "Directeur d'agence";
                //       role = "Direction commercial";
                //    role = "Comité crédit";
                //role = "Auccun Role";
                //   }

                AfficherMessageParRole();
                ChargerTableauAvecBoutons();
                AfficherNaveBare();
            }
        }

        private void AfficherNaveBare()
        {
            // Par défaut, tout est masqué sauf Dashboard
            linkDashboard.Visible = true;

            linkManageUsers.Visible = false;
            linkAddUser.Visible = false;
            linkRolesPermissions.Visible = false;
            linkHistory.Visible = false;
            linkSettings.Visible = false;
            linkAddProspect.Visible = false;
            linkViewProspect.Visible = false;
            linkVote.Visible = false;
            linkViewVote.Visible = false;
            linkDecision.Visible = false;

            switch (role)
            {
                case "Administrateur":
                    linkManageUsers.Visible = true;
                    linkAddUser.Visible = true;
                    linkRolesPermissions.Visible = true;
                    linkHistory.Visible = true;
                    linkSettings.Visible = true;
                    break;

                case "Chargé d'affaires":
                    linkAddProspect.Visible = true;
                    linkViewProspect.Visible = true;
                    break;

                case "Directeur d'agence":
                    linkViewProspect.Visible = true;
                    break;

                case "Direction commercial":
                    linkViewProspect.Visible = true;
                    linkViewVote.Visible = false;
                    linkDecision.Visible = false;
                    break;

                case "Comité crédit":
                    linkVote.Visible = false;
                    linkViewProspect.Visible = true;
                    break;

                default:
                    // Rôle inconnu, redirection par sécurité
                    Response.Redirect("Login.aspx");
                    break;
            }
        }

        protected void GridViewProspects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Details")
            {
                string id = e.CommandArgument.ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    try
                    {
                        conn.Open();
                        string query = @"
                  SELECT 
    cp.NOM, cp.BESOINS, cp.NBR_EMPLOYES, cp.TYPE_RENCONTRE, cp.CANAL_ACQUISITION, 
    cp.BLACK_LIST, cp.INTERDIT_CHEQUIER, cp.DATE_CREATION, cp.CAPITAL, 
    cp.FORME_JURIDIQUE, cp.COMMENTAIRE, cp.NUMTEL, cp.STATUS, cp.EMAIL, cp.ADRESSE,
    n1.DESCRIPTION AS SECTEUR_DESC,
    n2.DESCRIPTION AS SOUS_SECTEUR_DESC,
    n3.DESCRIPTION AS STATUS_DESC
FROM CLIENT_PROSPECT cp
LEFT JOIN NOMENCLATURE n1 ON n1.CODE = cp.SECTEUR AND n1.TYPE_CODE = '1'
LEFT JOIN NOMENCLATURE n2 ON n2.CODE = cp.SOUS_SECTEUR AND n2.TYPE_CODE = '2'
LEFT JOIN NOMENCLATURE n3 ON n3.CODE = cp.STATUS AND n3.TYPE_CODE='5'
WHERE cp.ID_PROSPECT = :ID";

                        using (OracleCommand cmd = new OracleCommand(query, conn))
                        {
                            cmd.Parameters.Add(new OracleParameter("ID", OracleDbType.Decimal, Convert.ToDecimal(id), ParameterDirection.Input));
                            using (OracleDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string details = $@"
<p><i class=""fas fa-user-circle text-primary me-2""></i><b>Nom :</b> &nbsp;{(reader["NOM"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NOM"].ToString()) : "N/A")}</p>

<p><i class=""fas fa-industry text-primary me-2""></i><b>Secteur :</b> &nbsp;{(reader["SECTEUR_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["SECTEUR_DESC"].ToString()) : "N/A")}</p>
           <p><i class=""fas fa-industry text-primary me-2""></i><b>Sous secteur :</b> &nbsp;{(reader["SOUS_SECTEUR_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["SOUS_SECTEUR_DESC"].ToString()) : "N/A")}</p>
          <p><i class=""fas fa-info-circle text-primary me-2""></i><b>Status :</b> &nbsp;{(reader["STATUS_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["STATUS_DESC"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-hand-holding-heart text-primary me-2""></i><b>Besoins :</b> &nbsp;{(reader["BESOINS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BESOINS"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-users text-primary me-2""></i><b>Nombre Employés :</b> &nbsp;{(reader["NBR_EMPLOYES"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NBR_EMPLOYES"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-handshake text-primary me-2""></i><b>Type Rencontre :</b> &nbsp;{(reader["TYPE_RENCONTRE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["TYPE_RENCONTRE"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-bullhorn text-primary me-2""></i><b>Canal Acquisition :</b> &nbsp;{(reader["CANAL_ACQUISITION"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["CANAL_ACQUISITION"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-ban text-danger me-2""></i><b>Black List :</b> &nbsp;{(reader["BLACK_LIST"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BLACK_LIST"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-ban text-danger me-2""></i><b>Interdit Chéquier :</b> &nbsp;{(reader["INTERDIT_CHEQUIER"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["INTERDIT_CHEQUIER"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-calendar-alt text-primary me-2""></i><b>Date Création :</b> &nbsp;{(reader["DATE_CREATION"] != DBNull.Value ? reader["DATE_CREATION"].ToString() : "N/A")}</p>
<p><i class=""fas fa-coins text-primary me-2""></i><b>Capital :</b> &nbsp;{(reader["CAPITAL"] != DBNull.Value ? reader["CAPITAL"].ToString() : "N/A")}</p>
<p><i class=""fas fa-gavel text-primary me-2""></i><b>Forme Juridique :</b> &nbsp;{(reader["FORME_JURIDIQUE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["FORME_JURIDIQUE"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-comment-alt text-primary me-2""></i><b>Commentaire :</b> &nbsp;{(reader["COMMENTAIRE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["COMMENTAIRE"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-phone text-primary me-2""></i><b>Téléphone :</b> &nbsp;{(reader["NUMTEL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NUMTEL"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-envelope text-primary me-2""></i><b>Email :</b> &nbsp;{(reader["EMAIL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["EMAIL"].ToString()) : "N/A")}</p>
<p><i class=""fas fa-map-marker-alt text-primary me-2""></i><b>Adresse :</b> &nbsp;{(reader["ADRESSE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["ADRESSE"].ToString()) : "N/A")}</p>";

                                    lblDetails.Text = details;
                                    int status = Convert.ToInt32(reader["STATUS"]);

                                    int stepNumber = 0;

                                    if (new[] { 0, 3, 6, 10, 12, 13 }.Contains(status))
                                        stepNumber = 1;
                                    else if (status == 1)
                                        stepNumber = 2;
                                    else if (new[] { 2, 9, 14, 15 }.Contains(status))
                                        stepNumber = 3;
                                    else if (new[] { 5, 7, 8 }.Contains(status))
                                        stepNumber = 4;

                                    string js = "<script>";

                                    if (stepNumber >= 1)
                                        js += "document.getElementById('step-CA').classList.add('active');";

                                    if (stepNumber >= 2)
                                        js += "document.getElementById('step-DA').classList.add('active');";

                                    if (stepNumber >= 3)
                                        js += "document.getElementById('step-DC').classList.add('active');";

                                    if (stepNumber >= 4)
                                        js += "document.getElementById('step-CC').classList.add('active');";

                                    js += "</script>";
                                    ClientScript.RegisterStartupScript(this.GetType(), "highlightSteps", js, false);

                                    ClientScript.RegisterHiddenField("shouldOpenModal", "true");
                                    UpdatePanel1.Update();
                                }
                                else
                                {
                                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Aucun prospect trouvé pour ID_PROSPECT = {id}');", true);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Erreur lors de la récupération des détails : {ex.Message}');", true);
                    }
                }
            }
            else if (e.CommandName == "ViewComment")
            {
                string prospectId = e.CommandArgument.ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

                System.Diagnostics.Debug.WriteLine($"ViewComment appelé - prospectId: {prospectId}");

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    try
                    {
                        conn.Open();
                        string query = @"
                    SELECT ACTIONS 
                    FROM HISTORIQUE_
                    WHERE ID_PROSPECT = :prospectId
                    ORDER BY DATE_ACT DESC
                    FETCH FIRST 1 ROW ONLY";

                        using (OracleCommand cmd = new OracleCommand(query, conn))
                        {
                            cmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                            object result = cmd.ExecuteScalar();
                            if (result != null && result != DBNull.Value)
                            {
                                string comment = HttpUtility.HtmlEncode(result.ToString());
                                System.Diagnostics.Debug.WriteLine($"Commentaire récupéré : {comment}");
                                ClientScript.RegisterStartupScript(this.GetType(), "ShowComment", $"Swal.fire({{ title: 'Dernier commentaire', text: '{comment}', icon: 'info', confirmButtonText: 'OK' }});", true);
                            }
                            else
                            {
                                System.Diagnostics.Debug.WriteLine("Aucun commentaire trouvé pour ce prospect.");
                                ClientScript.RegisterStartupScript(this.GetType(), "NoComment", $"Swal.fire({{ title: 'Information', text: 'Aucun commentaire trouvé pour ce prospect.', icon: 'info', confirmButtonText: 'OK' }});", true);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Erreur lors de la récupération du commentaire : {ex.Message}");
                        ClientScript.RegisterStartupScript(this.GetType(), "Error", $"Swal.fire({{ title: 'Erreur', text: 'Erreur lors de la récupération du commentaire : {ex.Message}', icon: 'error', confirmButtonText: 'OK' }});", true);
                    }
                }
            }
        }

        private void AfficherMessageParRole()
        {
            string message = "";
            switch (role)
            {
                case "Administrateur":
                    message = "<p>Validation Admin.</p>";
                    break;
                case "Chargé d'affaires":
                    message = "<p>Traitement chargé d'affaires.</p>";
                    break;
                case "Directeur d'agence":
                    message = "<p>Validation Directeur d'agence.</p>";
                    break;
                case "Direction commercial":
                    message = "<p>Validation directeur commercial.</p>";
                    break;
                case "Comité crédit":
                    message = "<p>Vote Comité crédit.</p>";
                    break;
                default:
                    message = "<p>Aucun rôle.</p>";
                    break;
            }
            LiteralMessage.Text = message;
        }

        private void ChargerTableauAvecBoutons()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
            //string currentUserId = Session["UserId"]?.ToString() ?? "1";

            // string currentUserId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? defaultUserId;

            //string currentUserId = "1";

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = @"
                    SELECT 
                        CP.NOM, 
                        CP.NUMTEL, 
                        CP.EMAIL, 
                        CP.ADRESSE, 
                        CP.ID_PROSPECT, 
                        CP.STATUS AS STATUS_ID, 
                        N.DESCRIPTION AS STATUS_NAME
                    FROM 
                        CLIENT_PROSPECT CP
                    LEFT JOIN 
                        NOMENCLATURE N 
                    ON 
                        CP.STATUS = N.CODE 
                        AND N.NOM = 'STATUS'";

                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            GridViewProspects.DataSource = dt;
                            GridViewProspects.DataBind();

                            foreach (GridViewRow row in GridViewProspects.Rows)
                            {
                                Literal literal = (Literal)row.FindControl("LiteralAction");
                                if (literal != null)
                                {
                                    // Utiliser STATUS_ID pour la logique
                                    string status = GridViewProspects.DataKeys[row.RowIndex]["STATUS_ID"]?.ToString() ?? "0";
                                    int statusValue;
                                    bool isNumericStatus = int.TryParse(status, out statusValue);
                                    if (!isNumericStatus) statusValue = 0;

                                    string prospectId = dt.Rows[row.RowIndex]["ID_PROSPECT"].ToString();

                                    Literal literalInfoSup = (Literal)row.FindControl("LiteralInfoSup");

                                    // Informations supplémentaires depuis table VISITE
                                    if (statusValue == 12 || statusValue == 13 || statusValue == 14 || statusValue == 15)
                                    {
                                        string visiteQuery = @"
                                         SELECT DATE_VISITE, CRV_TMP 
                                         FROM VISITE 
                                         WHERE ID_PROSPECT = :idProspect 
                                         ORDER BY ID_VISITE DESC";

                                        using (OracleCommand visiteCmd = new OracleCommand(visiteQuery, conn))
                                        {
                                            visiteCmd.Parameters.Add(new OracleParameter("idProspect", prospectId));

                                            using (OracleDataReader reader = visiteCmd.ExecuteReader())
                                            {
                                                if (reader.Read())
                                                {
                                                    string dateVisite = reader["DATE_VISITE"] != DBNull.Value
                                                        ? Convert.ToDateTime(reader["DATE_VISITE"]).ToString("yyyy-MM-dd")
                                                        : "Non définie";

                                                    string fichierPdf = reader["CRV_TMP"] != DBNull.Value
                                                        ? reader["CRV_TMP"].ToString()
                                                        : "Aucun fichier";

                                                    if (statusValue == 12)
                                                    {
                                                        literalInfoSup.Text = $"<span class='badge bg-info'>📅 Visite programme le : {dateVisite}</span>";
                                                    }
                                                    else if (statusValue == 13 || statusValue == 14 || statusValue == 15)
                                                    {
                                                        literalInfoSup.Text = $"<span class='badge bg-info'>📅 Visite realise le: {dateVisite}</span>";
                                                        literalInfoSup.Text += $"<span class='badge bg-info'>💾 le rapport de la visite :</span>";
                                                        literalInfoSup.Text += $"<a href='/pdfs/{fichierPdf}' target='_blank' class='badge bg-secondary'>📄 {fichierPdf}</a>";
                                                        // literalInfoSup.Text += $"<a href='/pdfs/1.pdf' target='_blank' class='badge bg-secondary'>📄 {fichierPdf}</a>";

                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else if (statusValue == 4)
                                    {
                                        literalInfoSup.Text = $"<span class='badge bg-danger'>⛔ Client rejeté par le directeur d'agence. </span>";
                                    }
                                    else if (statusValue == 11)
                                    {
                                        literalInfoSup.Text = $"<span class='badge bg-danger'>⛔ Decision défavorable de la direction commerciale. </span>";
                                    }
                                    else
                                    {
                                        literalInfoSup.Text = $"<span class='badge bg-danger'>💻 En traitement. </span>";
                                    }
                                    switch (role)
                                    {
                                        case "Administrateur":
                                            if (statusValue == 0 || statusValue == 3)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 14, 'Valider'); return false;\">Valider</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', {statusValue}, 'Modifier'); return false;\">Modifier</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 15, 'Supprimer'); return false;\">Supprimer</button>";
                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
                                            }
                                            else if (statusValue == 4)
                                            {
                                                literal.Text = "<span class='text-muted'>Client rejeté par le directeur d'agence </span>";
                                            }
                                            else if (statusValue == 11)
                                            {
                                                literal.Text = "<span class='text-muted'>Decision défavorable de la direction commerciale </span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Chargé d'affaires":
                                            if (statusValue == 0 || statusValue == 3)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', {statusValue}, 'Modifier'); return false;\">Modifier</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 1, 'Soumission'); return false;\">Soumission</button>";
                                            }
                                            else if (statusValue == 10)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"handleVisitAction('{prospectId}', 12, 'Planifier Visite', 'calendar'); return false;\">Planifier Visite</button>";
                                            }
                                            else if (statusValue == 12)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"handleVisitAction('{prospectId}', 12, 'Modifier Visite', 'calendar'); return false;\">Modifier la Visite</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"handleVisitAction('{prospectId}', 13, 'Visite Réalisée', 'pdf'); return false;\">Visite Réalisée</button>";
                                            }
                                            else if (statusValue == 13)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 14, 'Soumettre a la directino commercial'); return false;\">Soumettre a la directino commercial</button>";
                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
                                            }
                                            else if (statusValue == 4)
                                            {
                                                literal.Text = "<span class='text-muted'>Client rejeté par le directeur d'agence </span>";
                                            }
                                            else if (statusValue == 11)
                                            {
                                                literal.Text = "<span class='text-muted'>Decision défavorable de la direction commerciale </span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Directeur d'agence":
                                            if (statusValue == 1)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 2, 'Accepter'); return false;\">Accepter</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 3, 'PlusInfo'); return false;\">PlusInfo</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 4, 'Rejete'); return false;\">Rejeter</button>";
                                            }
                                            else if (statusValue == 6)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 3, 'PlusInfo'); return false;\">PlusInfo</button>";
                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
                                            }
                                            else if (statusValue == 4)
                                            {
                                                literal.Text = "<span class='text-muted'>Client rejeté par le directeur d'agence </span>";
                                            }
                                            else if (statusValue == 11)
                                            {
                                                literal.Text = "<span class='text-muted'>Decision défavorable de la direction commerciale </span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Direction commercial":
                                            if (statusValue == 2)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 5, 'Transmettre'); return false;\">Transmettre</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 6, 'PlusInfo'); return false;\">PlusInfo</button>";
                                            }
                                            else if (statusValue == 9)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Apres Vote Favorable'); return false;\">Decision Apres Vote Favorable</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 11, 'Decision Apres Vote Defavorable'); return false;\">Decision Apres Vote Defavorable</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 7 || statusValue == 8)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Apres Vote Favorable'); return false;\">Decision Apres Vote Favorable</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 11, 'Decision Apres Vote Defavorable'); return false;\">Decision Apres Vote Defavorable</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 14)
                                            {
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 16, 'Soummetre la décision finale'); return false;\">Decision Finale Défavorable</button>";

                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 15, 'Soummetre la décision finale'); return false;\">Decision Finale Favorable</button>";
                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
                                            }
                                            else if (statusValue == 4)
                                            {
                                                literal.Text = "<span class='text-muted'>Client rejeté par le directeur d'agence </span>";
                                            }
                                            else if (statusValue == 11)
                                            {
                                                literal.Text = "<span class='text-muted'>Decision défavorable de la direction commerciale </span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Comité crédit":

                                            bool hasVoted = false; // Variable pour stocker si l'utilisateur a déjà voté
                                            string checkVoteQueryUser = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId AND ID_USER = :userId";
                                            using (OracleCommand checkCmd = new OracleCommand(checkVoteQueryUser, conn))
                                            {
                                                checkCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                                checkCmd.Parameters.Add(new OracleParameter("userId", currentUserId));
                                                int voteCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                                                hasVoted = voteCount > 0; // true si l'utilisateur a déjà voté, false sinon
                                            }


                                            string checkVoteQuery = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId AND ID_USER = :userId";
                                            using (OracleCommand checkCmd = new OracleCommand(checkVoteQuery, conn))
                                            {
                                                checkCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                                checkCmd.Parameters.Add(new OracleParameter("userId", currentUserId));


                                                int voteCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                                            }

                                            if (statusValue == 5)
                                            {

                                                // if (voteCount == 0)
                                                if (!hasVoted)
                                                {
                                                    literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"submitVote('{prospectId}', 'Favorable', 5); return false;\">Vote Favorable</button>";
                                                    literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"submitVote('{prospectId}', 'Defavorable', 5); return false;\">Vote Defavorable</button>";
                                                    literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                                }
                                                else
                                                {
                                                    literal.Text = "<span class='text-muted'>Vote déjà soumis</span>";
                                                    literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                                }


                                            }
                                            //  else if (statusValue == 7 || statusValue == 8)
                                            //    {
                                            //       literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            //        literal.Text += "<span class='text-muted'>Vote déjà soumis</span>";
                                            //     }
                                            else if (hasVoted)
                                            {
                                                literal.Text += "<span class='text-muted'>Vote déjà soumis</span>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 4)
                                            {
                                                literal.Text = "<span class='text-muted'>Client rejeté par le directeur d'agence </span>";
                                            }
                                            else if (statusValue == 11)
                                            {
                                                literal.Text = "<span class='text-muted'>Decision défavorable de la direction commerciale </span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        default:
                                            literal.Text = "<span class='text-muted'>Aucun droit</span>";
                                            break;
                                    }
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Erreur lors de la lecture de la base de données : {ex.Message}');", true);
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string UpdateProspectStatus(string prospectId, int newStatus, string vote, string comment)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"UpdateProspectStatus appelé - prospectId: {prospectId}, newStatus: {newStatus}, vote: {vote}, comment: {comment ?? "null"}");

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                // string currentUserId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? defaultUserId;
                if (string.IsNullOrEmpty(currentUserId))
                {
                    System.Diagnostics.Debug.WriteLine("Erreur : Utilisateur non authentifié.");
                    return "Erreur : Utilisateur non authentifié.";
                }

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();

                    // Insérer le vote si fourni
                    if (!string.IsNullOrEmpty(vote))
                    {
                        System.Diagnostics.Debug.WriteLine($"Insertion vote - AVIS_: prospectId: {prospectId}, vote: {vote}, userId: {currentUserId}");
                        //string insertVoteQuery = "INSERT INTO AVIS_ (ID_AVIS, AVIS, ID_PROSPECT, ID_USER) VALUES (SEQ_AVIS.NEXTVAL, :avis, :prospectId, :userId)";

                        string insertVoteQuery = @"                           
                            INSERT INTO AVIS_(ID_AVIS, AVIS, ID_PROSPECT, ID_USER) VALUES(SEQ_AVIS.NEXTVAL, :avis, :prospectId, :userId)";


                        try
                        {
                            using (OracleCommand cmd = new OracleCommand(insertVoteQuery, conn))
                            {
                                cmd.Parameters.Add(new OracleParameter("avis", vote));
                                cmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                cmd.Parameters.Add(new OracleParameter("userId", currentUserId));
                                cmd.ExecuteNonQuery();
                            }
                        }
                        catch (OracleException ex) when (ex.Number == 2289)
                        {
                            System.Diagnostics.Debug.WriteLine("Erreur : La séquence SEQ_AVIS n'existe pas.");
                            return "Erreur : La séquence SEQ_AVIS n'existe pas. Veuillez contacter l'administrateur.";
                        }
                        catch (OracleException ex)
                        {
                            System.Diagnostics.Debug.WriteLine($"Erreur Oracle lors de l'insertion du vote : {ex.Message}, Code: {ex.Number}");
                            return $"Erreur Oracle lors de l'insertion du vote : {ex.Message} (Code: {ex.Number})";
                        }
                    }

                    // Mettre à jour le statut
                    System.Diagnostics.Debug.WriteLine($"Mise à jour statut - CLIENT_PROSPECT: prospectId: {prospectId}, newStatus: {newStatus}");
                    string updateQuery = "UPDATE CLIENT_PROSPECT SET STATUS = :status WHERE ID_PROSPECT = :id";
                    using (OracleCommand cmd = new OracleCommand(updateQuery, conn))
                    {
                        cmd.Parameters.Add(new OracleParameter("status", newStatus));
                        cmd.Parameters.Add(new OracleParameter("id", prospectId));
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected == 0)
                        {
                            System.Diagnostics.Debug.WriteLine($"Aucun prospect trouvé avec ID: {prospectId}");
                            return "Aucun prospect trouvé avec cet ID.";
                        }
                    }

                    // Enregistrer le commentaire dans HISTORIQUE_ si fourni
                    if (!string.IsNullOrEmpty(comment))
                    {
                        // System.Diagnostics.Debug.WriteLine($"Insertion commentaire - HISTORIQUE_: prospectId: {prospectId}, comment: {comment}, userId: {currentUserId}, status: {status}");
                        System.Diagnostics.Debug.WriteLine($"Insertion commentaire - HISTORIQUE_: prospectId: {prospectId}, comment: {comment}, userId: {currentUserId}");
                        string insertCommentQuery = @"
                            INSERT INTO HISTORIQUE_ (ID_ACTION, ACTIONS, ID_USER, DATE_ACT, ID_PROSPECT, STATUS)
                            VALUES (SEQ_HISTORIQUE.NEXTVAL, :actions, :userId, SYSDATE, :prospectId, :status_)";
                        int maxRetries = 3;
                        int attempt = 0;
                        bool success = false;

                        while (attempt < maxRetries && !success)
                        {
                            try
                            {
                                using (OracleCommand cmd = new OracleCommand(insertCommentQuery, conn))
                                {
                                    cmd.Parameters.Add(new OracleParameter("actions", OracleDbType.Varchar2, comment, ParameterDirection.Input));
                                    cmd.Parameters.Add(new OracleParameter("userId", OracleDbType.Varchar2, currentUserId, ParameterDirection.Input));
                                    cmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                                    //  cmd.Parameters.Add(new OracleParameter("status", OracleDbType.NUMBER, status, ParameterDirection.Input));
                                    cmd.Parameters.Add(new OracleParameter("status_", currentUserId));
                                    int rowsAffectedComment = cmd.ExecuteNonQuery();
                                    if (rowsAffectedComment == 0)
                                    {
                                        System.Diagnostics.Debug.WriteLine("Erreur : Le commentaire n'a pas été inséré dans HISTORIQUE_.");
                                        return "Erreur : Le commentaire n'a pas été inséré dans HISTORIQUE_.";
                                    }
                                    success = true;
                                }
                            }
                            catch (OracleException ex) when (ex.Number == 1)
                            {
                                attempt++;
                                System.Diagnostics.Debug.WriteLine($"Erreur ORA-00001 (tentative {attempt}/{maxRetries}) : Violation de la contrainte unique (ID_ACTION) dans HISTORIQUE_.");
                                if (attempt == maxRetries)
                                {
                                    System.Diagnostics.Debug.WriteLine("Échec après toutes les tentatives.");
                                    return "Erreur : Conflit d'identifiant dans l'historique après plusieurs tentatives. Veuillez contacter l'administrateur.";
                                }
                                // Obtenir une nouvelle valeur de la séquence
                                using (OracleCommand cmd = new OracleCommand("SELECT SEQ_HISTORIQUE.NEXTVAL FROM DUAL", conn))
                                {
                                    cmd.ExecuteScalar();
                                }
                            }
                            catch (OracleException ex) when (ex.Number == 2289)
                            {
                                System.Diagnostics.Debug.WriteLine("Erreur : La séquence SEQ_HISTORIQUE n'existe pas.");
                                return "Erreur : La séquence SEQ_HISTORIQUE n'existe pas. Veuillez contacter l'administrateur.";
                            }
                            catch (OracleException ex)
                            {
                                System.Diagnostics.Debug.WriteLine($"Erreur Oracle lors de l'insertion du commentaire : {ex.Message}, Code: {ex.Number}");
                                return $"Erreur Oracle lors de l'insertion du commentaire : {ex.Message} (Code: {ex.Number})";
                            }
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine($"Aucun commentaire fourni pour prospectId: {prospectId}, newStatus: {newStatus}");
                    }



                    // Vérifier si tous les membres du comité ont voté
                    string countVotesQuery = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId";
                    using (OracleCommand voteCmd = new OracleCommand(countVotesQuery, conn))
                    {
                        voteCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                        int voteCount = Convert.ToInt32(voteCmd.ExecuteScalar());

                        string countUsersQuery = "SELECT COUNT(*) FROM UTILISATEUR_ WHERE ROLE_ = 'Comité crédit'";
                        using (OracleCommand userCmd = new OracleCommand(countUsersQuery, conn))
                        {
                            int userCount = Convert.ToInt32(userCmd.ExecuteScalar());

                            System.Diagnostics.Debug.WriteLine($"Nombre de votes pour le prospect {prospectId} : {voteCount}");
                            System.Diagnostics.Debug.WriteLine($"Nombre d'utilisateurs 'Comité crédit' : {userCount}");


                            if (voteCount >= userCount && newStatus == 5)
                            {
                                newStatus = 9;
                                //  System.Diagnostics.Debug.WriteLine($"Tous les membres du comité ont voté. Statut défini à 9 pour le prospect {prospectId}.");


                                // Mettre à jour le statut
                                System.Diagnostics.Debug.WriteLine($"Mise à jour statut - CLIENT_PROSPECT: prospectId: {prospectId}, newStatus: {newStatus}");
                                string updateQueryVote = "UPDATE CLIENT_PROSPECT SET STATUS = :status WHERE ID_PROSPECT = :id";
                                using (OracleCommand cmd = new OracleCommand(updateQueryVote, conn))
                                {
                                    cmd.Parameters.Add(new OracleParameter("status", newStatus));
                                    cmd.Parameters.Add(new OracleParameter("id", prospectId));
                                    int rowsAffected = cmd.ExecuteNonQuery();
                                    if (rowsAffected == 0)
                                    {
                                        System.Diagnostics.Debug.WriteLine($"Aucun prospect trouvé avec ID: {prospectId}");
                                        return "Aucun prospect trouvé avec cet ID.";
                                    }
                                }
                            }
                        }
                    }


                    System.Diagnostics.Debug.WriteLine("Statut mis à jour avec succès.");
                    return "Statut mis à jour avec succès.";
                }
            }
            catch (OracleException ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erreur Oracle dans UpdateProspectStatus: {ex.Message}, Code: {ex.Number}");
                return $"Erreur Oracle : {ex.Message} (Code: {ex.Number})";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erreur générale dans UpdateProspectStatus: {ex.Message}");
                return $"Erreur : {ex.Message}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetVoteResults(string prospectId)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine($"GetVoteResults appelé avec prospectId: '{prospectId}'");

                if (string.IsNullOrEmpty(prospectId))
                {
                    System.Diagnostics.Debug.WriteLine("Erreur : prospectId est vide ou null.");
                    throw new ArgumentException("L'ID du prospect ne peut pas être vide.", nameof(prospectId));
                }

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                System.Diagnostics.Debug.WriteLine($"Chaîne de connexion : {connectionString}");

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    System.Diagnostics.Debug.WriteLine("Connexion à la base de données ouverte.");



                    string countVotesQuery = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId";
                    System.Diagnostics.Debug.WriteLine($"Exécution de la requête : {countVotesQuery} avec prospectId = {prospectId}");

                    using (OracleCommand voteCmd = new OracleCommand(countVotesQuery, conn))
                    {

                        string countUsersQuery = "SELECT COUNT(*) FROM UTILISATEUR_ WHERE ROLE_ = 'Comité crédit'";
                        using (OracleCommand userCmd = new OracleCommand(countUsersQuery, conn))
                        {
                            int userCount = Convert.ToInt32(userCmd.ExecuteScalar());


                            voteCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                            object result = voteCmd.ExecuteScalar();
                            System.Diagnostics.Debug.WriteLine($"Résultat brut : {result ?? "null"}");

                            int voteCount = Convert.ToInt32(result ?? 0);
                            System.Diagnostics.Debug.WriteLine($"Nombre de votes : {voteCount} ");



                            // Compter les votes favorables
                            string voteF = "Favorable";
                            string countVotesQueryFavorable = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId AND AVIS = :voteF";
                            int favorableCount;
                            using (OracleCommand userCmdFa = new OracleCommand(countVotesQueryFavorable, conn))
                            {
                                userCmdFa.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                userCmdFa.Parameters.Add(new OracleParameter("voteF", voteF));
                                System.Diagnostics.Debug.WriteLine($"Exécution de la requête favorable : {countVotesQueryFavorable} avec prospectId = {prospectId}, AVIS = {voteF}");
                                favorableCount = Convert.ToInt32(userCmdFa.ExecuteScalar() ?? 0);
                                System.Diagnostics.Debug.WriteLine($"Votes favorables : {favorableCount}");
                            }

                            // Compter les votes défavorables
                            string voteD = "Defavorable";
                            string countVotesQueryDefavorable = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId AND AVIS = :voteD";
                            int defavorableCount;
                            using (OracleCommand userCmdDe = new OracleCommand(countVotesQueryDefavorable, conn))
                            {
                                userCmdDe.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                userCmdDe.Parameters.Add(new OracleParameter("voteD", voteD));
                                System.Diagnostics.Debug.WriteLine($"Exécution de la requête défavorable : {countVotesQueryDefavorable} avec prospectId = {prospectId}, AVIS = {voteD}");
                                defavorableCount = Convert.ToInt32(userCmdDe.ExecuteScalar() ?? 0);
                                System.Diagnostics.Debug.WriteLine($"Votes défavorables : {defavorableCount}");
                            }

                            string resultMessage = favorableCount == 0 && defavorableCount == 0 && voteCount == 0
                             ? $"Aucun vote trouvé pour le prospect {prospectId}"
                             : $"Votes pour le prospect {prospectId} ({voteCount} votes sur {userCount} électeurs) :{favorableCount} Favorable(s), {defavorableCount} Défavorable(s)";

                            System.Diagnostics.Debug.WriteLine($"Résultat retourné : {resultMessage}");
                            return resultMessage;

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Erreur dans GetVoteResults : {ex.Message}\n{ex.StackTrace}");
                return $"Erreur lors de la récupération des votes : {ex.Message}";
            }
        }


        [System.Web.Services.WebMethod]
        public static string GetVoteResults2(string prospectId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    string query = "SELECT STATUS FROM CLIENT_PROSPECT WHERE ID_PROSPECT = :prospectId";
                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        cmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                        object result = cmd.ExecuteScalar();
                        int statusValue = result != null && result != DBNull.Value ? Convert.ToInt32(result) : 0;

                        int favorableCount = 0;
                        int defavorableCount = 0;

                        if (statusValue == 7)
                        {
                            favorableCount = 1;
                            defavorableCount = 0;
                        }
                        else if (statusValue == 8)
                        {
                            favorableCount = 0;
                            defavorableCount = 1;
                        }
                        else
                        {
                            favorableCount = 0;
                            defavorableCount = 0;
                        }

                        return $"Votes pour le prospect {prospectId} : {favorableCount} Favorable(s), {defavorableCount} Défavorable(s)";
                    }
                }
            }
            catch (Exception ex)
            {
                return $"Erreur lors de la récupération des votes : {ex.Message}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetLastComment(string prospectId)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    string query = @"
                        SELECT ACTIONS
                        FROM HISTORIQUE_
                        WHERE ID_PROSPECT = :prospectId
                        ORDER BY DATE_ACT DESC
                        FETCH FIRST 1 ROW ONLY";
                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        cmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                        object result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            return result.ToString();
                        }
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                return $"Erreur lors de la récupération du commentaire : {ex.Message}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveVisit(string prospectId, string visitDate)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                //   string currentUserId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? defaultUserId;
                if (string.IsNullOrEmpty(currentUserId))
                    return "Erreur : Utilisateur non authentifié.";

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();

                    // Vérifier si une visite existe déjà pour ce prospect
                    string checkQuery = "SELECT COUNT(*) FROM VISITE WHERE ID_PROSPECT = :prospectId";
                    using (OracleCommand checkCmd = new OracleCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                        int visitCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (visitCount > 0)
                        {
                            // Mettre à jour la date de visite existante
                            string updateQuery = "UPDATE VISITE SET DATE_VISITE = TO_DATE(:visitDate, 'YYYY-MM-DD'), ID_USER = :userId WHERE ID_PROSPECT = :prospectId";
                            using (OracleCommand cmd = new OracleCommand(updateQuery, conn))
                            {
                                cmd.Parameters.Add(new OracleParameter("visitDate", visitDate));
                                cmd.Parameters.Add(new OracleParameter("userId", currentUserId));
                                cmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                int rowsAffected = cmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                    return "Date de visite mise à jour avec succès.";
                                else
                                    return "Erreur lors de la mise à jour de la date de visite.";
                            }
                        }
                        else
                        {
                            // Insérer une nouvelle visite
                            string insertQuery = "INSERT INTO VISITE (ID_VISITE, ID_PROSPECT, ID_USER, DATE_VISITE, CRV_TMP, EXTENSION) VALUES (SEQ_VISITE.NEXTVAL, :prospectId, :userId, TO_DATE(:visitDate, 'YYYY-MM-DD'), NULL, NULL)";
                            using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                            {
                                cmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                cmd.Parameters.Add(new OracleParameter("userId", currentUserId));
                                cmd.Parameters.Add(new OracleParameter("visitDate", visitDate));
                                cmd.ExecuteNonQuery();
                                return "Date de visite enregistrée avec succès.";
                            }
                        }
                    }
                }
            }
            catch (OracleException ex) when (ex.Number == 2289)
            {
                return "Erreur : La séquence SEQ_VISITE n'existe pas. Veuillez contacter l'administrateur.";
            }
            catch (Exception ex)
            {
                return $"Erreur : {ex.Message}";
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveVisitReport(string prospectId, string fileName, string fileData)
        {
            try
            {
                // Vérifier que fileName et fileData sont valides
                if (string.IsNullOrEmpty(fileName))
                    return "Erreur : Le nom du fichier PDF est vide.";
                if (string.IsNullOrEmpty(fileData))
                    return "Erreur : Les données du fichier PDF sont vides.";

                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                //    string currentUserId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? defaultUserId;
                if (string.IsNullOrEmpty(currentUserId))
                    return "Erreur : Utilisateur non authentifié.";

                // Décode le contenu base64 du fichier
                byte[] fileBytes;
                try
                {
                    fileData = fileData.Substring(fileData.IndexOf(",") + 1); // Supprime le préfixe data:application/pdf;base64,
                    fileBytes = Convert.FromBase64String(fileData);
                }
                catch (FormatException ex)
                {
                    return $"Erreur : Format de données de fichier invalide. {ex.Message}";
                }

                // Définir le chemin du dossier pdfs sur le serveur
                string pdfsFolder = HttpContext.Current.Server.MapPath("~/pdfs/");
                if (!Directory.Exists(pdfsFolder))
                {
                    Directory.CreateDirectory(pdfsFolder);
                }

                // Générer un nom de fichier unique pour éviter les conflits
                //string uniqueFileName = $"{Guid.NewGuid()}_{fileName}";
                // string filePath = Path.Combine(pdfsFolder, uniqueFileName);


                string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string uniqueFileName = $"{timestamp}.pdf";
                string filePath = Path.Combine(pdfsFolder, uniqueFileName);


                // Sauvegarder le fichier sur le serveur
                File.WriteAllBytes(filePath, fileBytes);

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();

                    // Vérifier si une visite existe pour ce prospect
                    string checkQuery = "SELECT COUNT(*) FROM VISITE WHERE ID_PROSPECT = :prospectId";
                    using (OracleCommand checkCmd = new OracleCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                        int visitCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                        if (visitCount > 0)
                        {
                            // Mettre à jour le rapport de visite
                            string updateQuery = "UPDATE VISITE SET CRV_TMP = :fileName, EXTENSION = :extension, ID_USER = :userId WHERE ID_PROSPECT = :prospectId";
                            using (OracleCommand cmd = new OracleCommand(updateQuery, conn))
                            {
                                cmd.Parameters.Add(new OracleParameter("fileName", OracleDbType.Varchar2, uniqueFileName, ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("extension", OracleDbType.Varchar2, "pdf", ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("userId", OracleDbType.Varchar2, currentUserId, ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                                int rowsAffected = cmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                    return $"Rapport de visite enregistré avec succès pour le fichier : {uniqueFileName}.";
                                else
                                    return "Erreur lors de la mise à jour du rapport de visite.";
                            }
                        }
                        else
                        {
                            // Insérer une nouvelle visite avec le rapport
                            string insertQuery = "INSERT INTO VISITE (ID_VISITE, ID_PROSPECT, ID_USER, DATE_VISITE, CRV_TMP, EXTENSION) VALUES (SEQ_VISITE.NEXTVAL, :prospectId, :userId, NULL, :fileName, :extension)";
                            using (OracleCommand cmd = new OracleCommand(insertQuery, conn))
                            {
                                cmd.Parameters.Add(new OracleParameter("prospectId", OracleDbType.Varchar2, prospectId, ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("userId", OracleDbType.Varchar2, currentUserId, ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("fileName", OracleDbType.Varchar2, uniqueFileName, ParameterDirection.Input));
                                cmd.Parameters.Add(new OracleParameter("extension", OracleDbType.Varchar2, "pdf", ParameterDirection.Input));
                                cmd.ExecuteNonQuery();
                                return $"Rapport de visite enregistré avec succès pour le fichier : {uniqueFileName}.";
                            }
                        }
                    }
                }
            }
            catch (OracleException ex)
            {
                return $"Erreur Oracle ({ex.Number}) : {ex.Message} (fileName: {fileName})";
            }
            catch (Exception ex)
            {
                return $"Erreur : {ex.Message} (fileName: {fileName})";
            }
        }
    }
}