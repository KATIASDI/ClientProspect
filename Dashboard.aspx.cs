using PROJETFIN1.DataSetProspectTableAdapters;
using System;
using System.Collections.Generic;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
namespace PROJETFIN1

{
    public partial class Dashboard : System.Web.UI.Page
    {
        CLIENT_PROSPECTTableAdapter tPROSPECTS_ = new CLIENT_PROSPECTTableAdapter();
        UTILISATEUR_TableAdapter tUTILISATEUR_ = new UTILISATEUR_TableAdapter();

        protected int ActiveLoansCount = 0;
        protected int TotalCount = 0;
        protected int AcceptedCount = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
                   

                    string role = Session["ROLE_"] as string;

                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

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
                        linkHistory.Visible = false;
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

                // Statistiques
                decimal ProspectCount = tPROSPECTS_.Nbr_Prospect().GetValueOrDefault();
                int usersCount = Convert.ToInt32(tUTILISATEUR_.Nbr_Users());
                lblUsersCount.Text = usersCount.ToString();
                lblProspectsCount.Text = ProspectCount.ToString();



                ChargerResume();
                AfficherNombreDeVisites(); LoadLoanStats();
                BindRecentClients();




            }
        }
        private void BindRecentClients()
        {
            // Récupérer la chaîne de connexion depuis Web.config (le nom de ta connexion Oracle)
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection con = new OracleConnection(connectionString))
            {
                // Requête Oracle pour récupérer les 10 derniers clients, en utilisant ROWNUM et ORDER BY ID DESC
                string query = @"
            SELECT NOM, EMAIL, STATE 
            FROM (
                SELECT NOM, EMAIL, STATE
                FROM CLIENT_PROSPECT
                ORDER BY ID_PROSPECT DESC
            )
            WHERE ROWNUM <= 10";

                using (OracleCommand cmd = new OracleCommand(query, con))
                {
                    con.Open();

                    DataTable dt = new DataTable();
                    dt.Load(cmd.ExecuteReader());

                    GridViewRecentClients.DataSource = dt;
                    GridViewRecentClients.DataBind();
                }
            }
        }
        protected void GridViewRecentClients_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblState = (Label)e.Row.FindControl("lblState");
                if (lblState != null)
                {
                    string state = lblState.Text.ToLower();

                    switch (state)
                    {
                        case "Client Accepté , en attente d'entrée en relation":
                            lblState.ForeColor = System.Drawing.Color.Green;
                            break;
                        case "rouge":
                            lblState.ForeColor = System.Drawing.Color.Red;
                            break;
                        case "Client Crée par le chargé d'affaires":
                            lblState.ForeColor = System.Drawing.Color.Goldenrod; // jaune foncé
                            break;
                        case "Accepté par le chargé d'affaires":
                            lblState.ForeColor = System.Drawing.Color.Orange;
                            break;
                        case "En attente de la validation Finale":
                            lblState.ForeColor = System.Drawing.Color.Blue;
                            break;
                        default:
                            lblState.ForeColor = System.Drawing.Color.Black;
                            break;
                    }
                }
            }
        }

        private void AfficherNombreDeVisites()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;
            string query = "SELECT COUNT(*) FROM VISITE";

            using (OracleConnection conn = new OracleConnection(connectionString))
            using (OracleCommand cmd = new OracleCommand(query, conn))
            {
                conn.Open();
                int nombreVisites = Convert.ToInt32(cmd.ExecuteScalar());
                lblNombreVisites.Text = nombreVisites.ToString();
            }
        }
        private void LoadLoanStats()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();

                // Nombre total de dossiers
                string totalQuery = "SELECT COUNT(*) FROM CLIENT_PROSPECT";
                using (OracleCommand cmd = new OracleCommand(totalQuery, conn))
                {
                    TotalCount = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Nombre de dossiers acceptés
                string acceptedQuery = "SELECT COUNT(*) FROM CLIENT_PROSPECT WHERE STATUS = '15'";
                using (OracleCommand cmd = new OracleCommand(acceptedQuery, conn))
                {
                    AcceptedCount = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        } 
        public class RoleData
        {
            public string Role { get; set; }
            public int Count { get; set; }
        }

        private void ChargerResume()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;


            string query = "SELECT ROLE_, COUNT(*) AS NB FROM UTILISATEUR_ GROUP BY ROLE_";

            List<RoleData> liste = new List<RoleData>();

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                OracleCommand cmd = new OracleCommand(query, conn);
                conn.Open();

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string role = reader["ROLE_"].ToString();
                        int nb = Convert.ToInt32(reader["NB"]);

                        liste.Add(new RoleData { Role = role, Count = nb });
                    }
                }
            }



            RepeaterRoles.DataSource = liste;
            RepeaterRoles.DataBind();
        } 

        public string GetIcon(string role)
        {
            role = role.ToLower();
            if (role.Contains("admin")) return "🛠️";
            if (role.Contains("chargé")) return "📈";
            if (role.Contains("comité")) return "🏦";
            if (role.Contains("directeur")) return "📋";
            if (role.Contains("commerciale")) return "💼";
            if (role.Contains("client")) return "🧑‍💼";
            return "👤";
        }

        public string GetLabel(string role)
        {
            role = role.ToLower();
            if (role.Contains("admin")) return "Administrateurs";
            if (role.Contains("chargé")) return "Chargés d'affaires";
            if (role.Contains("comité")) return "Membres du Comité Crédit";
            if (role.Contains("directeur")) return "Directeurs d'agence";
            if (role.Contains("commerciale")) return "Directions Commerciales";
            if (role.Contains("client")) return "Nouveaux clients";
            return role;
        }
    }

}

    

        
    

