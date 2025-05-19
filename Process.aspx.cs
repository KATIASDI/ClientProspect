using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web;
using System.Web.Security;
using PROJETFIN1.DataSetProspectTableAdapters;
using System.Collections.Generic;

namespace WebRedaTest
{
    public partial class Process : System.Web.UI.Page
    {

        VISITETableAdapter tVisite = new VISITETableAdapter();

        //string role = "Direction commerciale"; // récupéré dynamiquement
        string role = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // if (Session["role"] != null)
                // {
                role = Session["ROLE_"] as string;
                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                //   }
                //  else
                //  {
                // role = "Administrateur";
                //    role = "Chargé d'affaires";
                // role = "Directeur d'agence";
                //   role = "Direction commerciale";
                // role = "Comité crédit";
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
            linkPlanningVisite.Visible = false;
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
                    linkPlanningVisite.Visible = true;
                    break;

                case "Directeur d'agence":
                    linkViewProspect.Visible = true;
                    break;

                case "Direction commercial":
                    linkViewProspect.Visible = true;
                    linkViewVote.Visible = true;
                    linkDecision.Visible = true;
                    break;

                case "Comité crédit":
                    linkVote.Visible = true;
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
                            SELECT cp.NOM, cp.BESOINS, cp.NBR_EMPLOYES, cp.TYPE_RENCONTRE,cp.CANAL_ACQUISITION, 
                                    cp.BLACK_LIST, cp.INTERDIT_CHEQUIER, cp.DATE_CREATION,cp.CAPITAL, 
                                    cp.FORME_JURIDIQUE, cp.COMMENTAIRE, cp.NUMTEL, cp.STATUS, cp.EMAIL, cp.ADRESSE,
n1.DESCRIPTION AS SECTEUR_DESC,
n2.DESCRIPTION AS SOUS_SECTEUR_DESC,

n3.DESCRIPTION AS STATUS_DESC

            FROM CLIENT_PROSPECT cp
            LEFT JOIN NOMENCLATURE n1 ON n1.CODE = cp.SECTEUR
            LEFT JOIN NOMENCLATURE n2 ON n2.CODE = cp.SOUS_SECTEUR

 LEFT JOIN NOMENCLATURE n3 ON n3.CODE = cp.STATUS

 LEFT JOIN NOMENCLATURE n2 ON n2.CODE = cp.SOUS_SECTEUR
            WHERE cp.ID_PROSPECT = :ID";


                        using (OracleCommand cmd = new OracleCommand(query, conn))
                        {
                            cmd.Parameters.Add(new OracleParameter("ID", OracleDbType.Decimal, Convert.ToDecimal(id), ParameterDirection.Input));
                            using (OracleDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string details = $@"
                                        <b>Nom :</b> {(reader["NOM"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NOM"].ToString()) : "N/A")}<br/>

 <b>Secteur :</b> {(reader["SECTEUR_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["SECTEUR_DESC"].ToString()) : "N/A")}<br/>
                        <b>Sous-secteur :</b> {(reader["SOUS_SECTEUR_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["SOUS_SECTEUR_DESC"].ToString()) : "N/A")}<br/>
                          
  <b>Statusss :</b> {(reader["STATUS_DESC"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["STATUS_DESC"].ToString()) : "N/A")}<br/>


                                        <b>Besoins :</b> {(reader["BESOINS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BESOINS"].ToString()) : "N/A")}<br/>
                                        <b>Nombre Employés :</b> {(reader["NBR_EMPLOYES"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NBR_EMPLOYES"].ToString()) : "N/A")}<br/>
                                        <b>Type Rencontre :</b> {(reader["TYPE_RENCONTRE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["TYPE_RENCONTRE"].ToString()) : "N/A")}<br/>
                                        <b>Canal Acquisition :</b> {(reader["CANAL_ACQUISITION"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["CANAL_ACQUISITION"].ToString()) : "N/A")}<br/>
                                        <b>Black List :</b> {(reader["BLACK_LIST"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BLACK_LIST"].ToString()) : "N/A")}<br/>
                                        <b>Interdit Chéquier :</b> {(reader["INTERDIT_CHEQUIER"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["INTERDIT_CHEQUIER"].ToString()) : "N/A")}<br/>
                                        <b>Date Création :</b> {(reader["DATE_CREATION"] != DBNull.Value ? reader["DATE_CREATION"].ToString() : "N/A")}<br/>
                                        <b>Capital :</b> {(reader["CAPITAL"] != DBNull.Value ? reader["CAPITAL"].ToString() : "N/A")}<br/>
                                        <b>Forme Juridique :</b> {(reader["FORME_JURIDIQUE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["FORME_JURIDIQUE"].ToString()) : "N/A")}<br/>
                                        <b>Commentaire :</b> {(reader["COMMENTAIRE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["COMMENTAIRE"].ToString()) : "N/A")}<br/>
                                        <b>Téléphone :</b> {(reader["NUMTEL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NUMTEL"].ToString()) : "N/A")}<br/>
                                        <b>Status :</b> {(reader["STATUS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["STATUS"].ToString()) : "N/A")}<br/>
                                        <b>Email :</b> {(reader["EMAIL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["EMAIL"].ToString()) : "N/A")}<br/>
                                        <b>Adresse :</b> {(reader["ADRESSE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["ADRESSE"].ToString()) : "N/A")}<br/>";
                                    lblDetails.Text = details;
                                    ClientScript.RegisterHiddenField("shouldOpenModal", "true");
                                    UpdatePanel1.Update();
                                }
                                else
                                {
                                    // Afficher une alerte si aucun prospect n'est trouvé
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
                    message = "<p>Validation directeur commerciale.</p>";
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
            // Récupérer l'ID utilisateur depuis la session
            string currentUserId = Session["UserId"]?.ToString() ?? "1"; // Remplacez "1" par votre logique réelle

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT NOM, NUMTEL, EMAIL, ADRESSE, ID_PROSPECT, STATUS FROM CLIENT_PROSPECT";






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
                                    string status = GridViewProspects.DataKeys[row.RowIndex].Value?.ToString() ?? "0";
                                    int statusValue;
                                    bool isNumericStatus = int.TryParse(status, out statusValue);
                                    if (!isNumericStatus) statusValue = 0;

                                    string prospectId = dt.Rows[row.RowIndex]["ID_PROSPECT"].ToString();

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
                                                // literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 12, 'Planifier Visite'); return false;\">Planifier Visite</button>";
                                                //  literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 13, 'Visite Réalisée'); return false;\">Visite Réalisée</button>";

                                                //   literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"openCalendar('{prospectId}'); return false;\">Planifier Visite</button>";
                                                //   literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"openPdfUpload('{prospectId}'); return false;\">Visite Réalisée</button>";

                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"handleVisitAction('{prospectId}', 12, 'Planifier Visite', 'calendar'); return false;\">Planifier Visite</button>";
                                                // literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"handleVisitAction('{prospectId}', 13, 'Visite Réalisée', 'pdf'); return false;\">Visite Réalisée</button>";
                                            }
                                            else if (statusValue == 12)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"handleVisitAction('{prospectId}', 12, 'Planifier Visite', 'calendar'); return false;\">Modifier la Visite</button>";


           
                                                





                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"handleVisitAction('{prospectId}', 13, 'Visite Réalisée', 'pdf'); return false;\">Visite Réalisée</button>";
                                            }
                                            else if (statusValue == 13)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"updateStatus('{prospectId}', 14, 'Soumettre a la directino commerciale'); return false;\">Soumettre a la directino commerciale</button>";
                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
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
                                                //literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Finale'); return false;\">Décision Finale</button>";
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Finale Favorable'); return false;\">Decision Finale Favorable</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 11, 'Decision Finale Defavorable'); return false;\">Decision Finale Defavorable</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 7 || statusValue == 8)
                                            {
                                                //literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Finale'); return false;\">Décision Finale</button>";
                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 10, 'Decision Finale Favorable'); return false;\">Decision Finale Favorable</button>";
                                                literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 11, 'Decision Finale Defavorable'); return false;\">Decision Finale Defavorable</button>";
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 14)
                                            {

                                                literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 15, 'Soummetre la décision finale'); return false;\">Decision Finale Favorable</button>";

                                            }
                                            else if (statusValue == 15)
                                            {
                                                literal.Text = "<span class='text-muted'>Client accepte</span>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Comité crédit":
                                            if (statusValue == 5)
                                            {
                                                // Vérifier si l'utilisateur a déjà voté
                                                string checkVoteQuery = "SELECT COUNT(*) FROM AVIS_ WHERE ID_PROSPECT = :prospectId AND ID_USER = :userId";
                                                using (OracleCommand checkCmd = new OracleCommand(checkVoteQuery, conn))
                                                {
                                                    checkCmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                                                    checkCmd.Parameters.Add(new OracleParameter("userId", currentUserId));
                                                    int voteCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                                                    if (voteCount == 0)
                                                    {
                                                        // L'utilisateur n'a pas encore voté, afficher les boutons de vote
                                                        //    literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"submitVote('{prospectId}', 'Favorable', 7); return false;\">Vote Favorable</button>";
                                                        //    literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"submitVote('{prospectId}', 'Defavorable', 8); return false;\">Vote Defavorable</button>";
                                                        literal.Text = $"<button class='btn btn-success btn-sm' onclick=\"updateStatus('{prospectId}', 7, 'Vote Favorable'); return false;\">Vote Favorable</button>";
                                                        literal.Text += $"<button class='btn btn-danger btn-sm' onclick=\"updateStatus('{prospectId}', 8, 'Vote Defavorable'); return false;\">Vote Defavorable</button>";

                                                    }
                                                    else
                                                    {
                                                        // L'utilisateur a déjà voté, afficher un message
                                                        literal.Text = "<span class='text-muted'>Vote déjà soumis</span>";
                                                    }
                                                }
                                                // Toujours afficher le bouton pour voir les résultats
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
                                            }
                                            else if (statusValue == 7 || statusValue == 8)
                                            {
                                                literal.Text += $"<button class='btn btn-warning btn-sm' onclick=\"showVoteResults('{prospectId}'); return false;\">Voir Résultats Vote</button>";
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
        public static string UpdateProspectStatus(string prospectId, int newStatus, string vote = null)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();



                    // Insérer le vote si fourni
                    if (!string.IsNullOrEmpty(vote))
                    {
                        string userId = System.Web.HttpContext.Current.Session["UserId"]?.ToString() ?? "1";
                        if (string.IsNullOrEmpty(userId))
                            return "Erreur : Utilisateur non authentifié.";

                        string insertVoteQuery = "INSERT INTO AVIS_ (ID_AVIS, AVIS, ID_PROSPECT, ID_USER) VALUES (SEQ_AVIS.NEXTVAL, :avis, :prospectId, :userId)";
                        using (OracleCommand cmd = new OracleCommand(insertVoteQuery, conn))
                        {
                            cmd.Parameters.Add(new OracleParameter("avis", "1"));
                            cmd.Parameters.Add(new OracleParameter("prospectId", prospectId));
                            cmd.Parameters.Add(new OracleParameter("userId", "1"));
                            cmd.ExecuteNonQuery();
                        }
                    }

                    // Mettre à jour le statut
                    string updateQuery = "UPDATE CLIENT_PROSPECT SET STATUS = :status WHERE ID_PROSPECT = :id";
                    using (OracleCommand cmd = new OracleCommand(updateQuery, conn))
                    {
                        cmd.Parameters.Add(new OracleParameter("status", newStatus));
                        cmd.Parameters.Add(new OracleParameter("id", prospectId));
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                            return "Statut mis à jour avec succès.";
                        else
                            return "Aucun prospect trouvé avec cet ID.";
                    }
                }
            }
            catch (OracleException ex) when (ex.Number == 2289)
            {
                return "Erreur : La séquence SEQ_AVIS n'existe pas. Veuillez contacter l'administrateur.";
            }
            catch (Exception ex)
            {
                return $"Erreur : {ex.Message}";
            }
        }


        [System.Web.Services.WebMethod]
        public static string GetVoteResults(string prospectId)
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


    }
}