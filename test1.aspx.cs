using System;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web;
using System.Web.Security;

namespace WebRedaTest
{
    public partial class test1 : System.Web.UI.Page
    {
        //string role = "Direction commerciale"; // récupéré dynamiquement
        string role = "";



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string target = Request["__EVENTTARGET"];
                if (!string.IsNullOrEmpty(target) && target.StartsWith("soumission_"))
                {
                    string idStr = target.Replace("soumission_", "");
                    if (int.TryParse(idStr, out int ID))
                    {
                        // Mettre à jour le client
                        UpdateClientStatus(ID);

                        // Afficher un message et recharger
                        string script = "alert('Client soumis à la direction commerciale'); window.location.reload();";
                        ClientScript.RegisterStartupScript(this.GetType(), "soumissionPopup", script, true);
                    }
                }
                //  if (Session["role"] != null)
                //   {

                //string[] roles = Roles.GetRolesForUser(); // Récupère les rôles de l'utilisateur connecté
                //role = roles.Length > 0 ? roles[0] : ""; // Prend le 1er rôle
                //   role = Session["role"].ToString();
                //  }
                //  else
                //  {
                //role = "Administrateur";
                //  }

                // if (Session["role"] != null)
                // {

                role = Session["ROLE_"] as string;
                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                //  }
                //  else
                //  {

                ///      role = "Administrateur";
                // role = "Directeur d'agence";
                //  role = "Chargé d'affaires";
                // role = "Directeur d'agence";
                //role = "Direction commerciale";
                //role = "Comité crédit";
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

                                    switch (role)
                                    {
                                        case "Administrateur":
                                            if (statusValue == 0 || statusValue == 3)
                                            {
                                                literal.Text = "<button class='btn btn-success btn-sm'>Valider</button>";
                                                literal.Text += "<button class='btn btn-warning btn-sm'>Modifier</button>";
                                                literal.Text += "<button class='btn btn-danger btn-sm'>Supprimer</button>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Chargé d'affaires":
                                            if (statusValue == 0 || statusValue == 3)
                                            {
                                                literal.Text = @"
<style>
    .btn-fixed {
        min-width: 160px;
        justify-content: center;
    }
    .btn-offset {
        margin-top: 4px;
    }
</style>

<button 
    class='btn btn-light text-success border border-success rounded-pill px-4 py-2 d-flex align-items-center me-2 btn-fixed' 
    style='--bs-success: #28a745; --bs-success-rgb: 40,167,69;'>
    <svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='#28a745' class='bi bi-pencil-square me-2' viewBox='0 0 16 16'>
        <path d='M15.502 1.94a.5.5 0 0 1 0 .706l-1 1a.5.5 0 0 1-.706 0L13 2.207l1-1a.5.5 0 0 1 .707 0l.795.733z'/>
        <path d='M13.5 3.207l-8 8V13h1.793l8-8L13.5 3.207z'/>
        <path fill-rule='evenodd' d='M1 13.5a.5.5 0 0 1 .5-.5H11a.5.5 0 0 1 0 1H1.5a.5.5 0 0 1-.5-.5z'/>
    </svg>
    Modifier
</button>";

                                                string idProspect = GridViewProspects.DataKeys[row.RowIndex].Value.ToString();
                                                literal.Text += $@"
<button 
    class='btn btn-light text-pink border border-pink rounded-pill px-4 py-2 d-flex align-items-center btn-fixed btn-offset' 
    style='--bs-pink: #ff6f91; --bs-pink-rgb: 255,111,145;' 
    onclick=""__doPostBack('soumission_{idProspect}', '')"">
    <svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='#ff6f91' class='bi bi-check2-circle me-2' viewBox='0 0 16 16'>
        <path d='M2.5 8a5.5 5.5 0 1 1 11 0 5.5 5.5 0 0 1-11 0zm8.354-1.354a.5.5 0 0 0-.708 0L7 9.793 5.854 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3.5-3.5a.5.5 0 0 0 0-.708z'/>
    </svg>
    Soumission
</button>";



                                            }
                                            else if (statusValue == 10)
                                            {
                                               
                                                literal.Text += @"
<style>
    .btn-fixed {
        min-width: 160px;
        justify-content: center;
    }
    .btn-offset {
        margin-top: 4px;
    }
</style>

<button 
    class='btn btn-light text-warning border border-warning rounded-pill px-4 py-2 d-flex align-items-center me-2 btn-fixed' 
    style='--bs-warning: #f4a261; --bs-warning-rgb: 244,162,97;'>
    <svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='#f4a261' class='bi bi-calendar-event me-2' viewBox='0 0 16 16'>
        <path d='M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v1H0V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zM4.5 7a.5.5 0 0 1 .5.5V9h1.5a.5.5 0 0 1 0 1H5v1.5a.5.5 0 0 1-1 0V10H2.5a.5.5 0 0 1 0-1H4V7.5a.5.5 0 0 1 .5-.5z'/>
    </svg>
    Planifier Visite
</button>";

                                                literal.Text += @"
<button 
    class='btn btn-light text-danger border border-danger rounded-pill px-4 py-2 d-flex align-items-center btn-fixed btn-offset' 
    style='--bs-danger: #e63946; --bs-danger-rgb: 230,57,70;'>
    <svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='#e63946' class='bi bi-check-all me-2' viewBox='0 0 16 16'>
        <path d='M8.97 4.97a.75.75 0 0 1 1.06 1.06L7.477 8.582a.75.75 0 0 1-1.06 0L5.47 7.636a.75.75 0 1 1 1.06-1.06L7 7.086l1.97-2.116z'/>
        <path d='M11.97 4.97a.75.75 0 0 1 1.06 1.06l-3.5 3.5a.75.75 0 0 1-1.06 0l-.97-.97a.75.75 0 1 1 1.06-1.06l.44.44 2.97-2.97z'/>
    </svg>
    Visite Réalisée
</button>";
                                            }
                                            else
                                            {
                                                literal.Text = @"
<span class='d-flex align-items-center' style='color: #5dade2; font-weight: 700; text-shadow: 0 0 2px rgba(0,0,0,0.1); font-size: 1rem;'>
    <svg xmlns='http://www.w3.org/2000/svg' width='18' height='18' fill='#5dade2' class='me-2' viewBox='0 0 16 16'>
        <path d='M2 2a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v2a1 1 0 0 1-.553.894L10 8l2.447 3.106A1 1 0 0 1 13 12v2a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-2a1 1 0 0 1 .553-.894L6 8 3.553 4.894A1 1 0 0 1 3 4V2z'/>
    </svg>
    En traitement
</span>";



                                            }
                                            break;
                                        case "Directeur d'agence":
                                            if (statusValue == 1)
                                            {
                                                literal.Text = "<button class='btn btn-success btn-sm'>Accepter</button>";
                                                literal.Text += "<button class='btn btn-warning btn-sm'>PlusInfo</button>";
                                                literal.Text += "<button class='btn btn-danger btn-sm'>Rejete</button>";
                                            }
                                            else if (statusValue == 6)
                                            {
                                                literal.Text += "<button class='btn btn-warning btn-sm'>PlusInfo</button>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Direction commercial":
                                            if (statusValue == 2)
                                            {
                                                literal.Text = "<button class='btn btn-success btn-sm'>Transmettre</button>";
                                                literal.Text += "<button class='btn btn-warning btn-sm'>PlusInfo</button>";
                                            }
                                            else if (statusValue == 9)
                                            {
                                                literal.Text += "<button class='btn btn-danger btn-sm'>Decision Finale</button>";
                                            }
                                            else
                                            {
                                                literal.Text = "<span class='text-muted'>En traitement</span>";
                                            }
                                            break;
                                        case "Comité crédit":
                                            if (statusValue == 5)
                                            {
                                                literal.Text = "<button class='btn btn-success btn-sm'>Vote</button>";
                                                literal.Text += "<button class='btn btn-warning btn-sm'>StatusVote</button>";
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
                    // Gérer l'erreur sans LiteralMessage, par exemple via une alerte
                    ClientScript.RegisterStartupScript(this.GetType(), "Error", $"alert('Erreur lors de la lecture de la base de données : {ex.Message}');", true);
                }
            }
        }
        private void UpdateClientStatus(int ID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                using (OracleCommand cmd = new OracleCommand("UPDATE CLIENT_PROSPECT SET STATUS = :status WHERE ID_PROSPECT = :id", conn))
                {
                    cmd.Parameters.Add(new OracleParameter("status", "1")); // chaîne de caractères "1"
                    cmd.Parameters.Add(new OracleParameter("id", ID)); // entier
                    cmd.ExecuteNonQuery();
                }
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
                cp.NOM, 
                n1.DESCRIPTION AS SECTEUR_DESC,
                n2.DESCRIPTION AS SOUS_SECTEUR_DESC,
                cp.BESOINS, 
                cp.NBR_EMPLOYES, 
                cp.TYPE_RENCONTRE,
                cp.CANAL_ACQUISITION, 
                cp.BLACK_LIST, 
                cp.INTERDIT_CHEQUIER, 
                cp.DATE_CREATION,
                cp.CAPITAL, 
                cp.FORME_JURIDIQUE, 
                cp.BESOINS, 
                cp.NUMTEL, 
                cp.STATUS, 
                cp.EMAIL,
                cp.ADRESSE,
                cp.AUTRES_SECTEURS
            FROM CLIENT_PROSPECT cp
            LEFT JOIN NOMENCLATURE n1 ON n1.CODE = cp.SECTEUR
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
                        <b>Besoins :</b> {(reader["BESOINS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BESOINS"].ToString()) : "N/A")}<br/>
                        <b>Nombre Employés :</b> {(reader["NBR_EMPLOYES"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NBR_EMPLOYES"].ToString()) : "N/A")}<br/>
                        <b>Type Rencontre :</b> {(reader["TYPE_RENCONTRE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["TYPE_RENCONTRE"].ToString()) : "N/A")}<br/>
                        <b>Canal Acquisition :</b> {(reader["CANAL_ACQUISITION"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["CANAL_ACQUISITION"].ToString()) : "N/A")}<br/>
                        <b>Black List :</b> {(reader["BLACK_LIST"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BLACK_LIST"].ToString()) : "N/A")}<br/>
                        <b>Interdit Chéquier :</b> {(reader["INTERDIT_CHEQUIER"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["INTERDIT_CHEQUIER"].ToString()) : "N/A")}<br/>
                        <b>Date Création :</b> {(reader["DATE_CREATION"] != DBNull.Value ? Convert.ToDateTime(reader["DATE_CREATION"]).ToString("dd/MM/yyyy") : "N/A")}<br/>
                        <b>Capital :</b> {(reader["CAPITAL"] != DBNull.Value ? reader["CAPITAL"].ToString() : "N/A")}<br/>
                        <b>Forme Juridique :</b> {(reader["FORME_JURIDIQUE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["FORME_JURIDIQUE"].ToString()) : "N/A")}<br/>
                        <b>Commentaire :</b> {(reader["BESOINS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["BESOINS"].ToString()) : "N/A")}<br/>
                        <b>Téléphone :</b> {(reader["NUMTEL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["NUMTEL"].ToString()) : "N/A")}<br/>
                        <b>Status :</b> {(reader["STATUS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["STATUS"].ToString()) : "N/A")}<br/>
                        <b>Email :</b> {(reader["EMAIL"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["EMAIL"].ToString()) : "N/A")}<br/>
                        <b>Adresse :</b> {(reader["ADRESSE"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["ADRESSE"].ToString()) : "N/A")}<br/>
                        <b>Autres Secteurs :</b> {(reader["AUTRES_SECTEURS"] != DBNull.Value ? HttpUtility.HtmlEncode(reader["AUTRES_SECTEURS"].ToString()) : "N/A")}<br/>";

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
    }
}