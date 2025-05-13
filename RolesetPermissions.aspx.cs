using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Web.UI;

namespace PROJETFIN1
{
    public partial class RolesetPermissions : System.Web.UI.Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerUtilisateurs();
            }
        }

        private void ChargerUtilisateurs(string filtreNom = "")
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT IDENTIFIANT, NAME, ROLE_ FROM UTILISATEUR_";
                if (!string.IsNullOrWhiteSpace(filtreNom))
                {
                    query += " WHERE LOWER(NAME) LIKE :filtre";
                }

                OracleCommand cmd = new OracleCommand(query, conn);
                if (!string.IsNullOrWhiteSpace(filtreNom))
                {
                    cmd.Parameters.Add(new OracleParameter("filtre", "%" + filtreNom.ToLower() + "%"));
                }

                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            ChargerUtilisateurs();
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            ChargerUtilisateurs();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string id = gvUsers.DataKeys[e.RowIndex].Value.ToString();
            GridViewRow row = gvUsers.Rows[e.RowIndex];
            DropDownList ddlRoles = (DropDownList)row.FindControl("ddlRoles");

            if (ddlRoles != null)
            {
                string nouveauRole = ddlRoles.SelectedValue;

                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    OracleCommand cmd = new OracleCommand("UPDATE UTILISATEUR_ SET ROLE_ = :role WHERE IDENTIFIANT = :id", conn);
                    cmd.Parameters.Add(new OracleParameter("role", nouveauRole));
                    cmd.Parameters.Add(new OracleParameter("id", id));
                    cmd.ExecuteNonQuery();
                }
            }

            gvUsers.EditIndex = -1;
            ChargerUtilisateurs();
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && gvUsers.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlRoles");
                if (ddl != null)
                {
                    ddl.DataSource = GetAllRoles();
                    ddl.DataTextField = "NOM_ROLE";
                    ddl.DataValueField = "NOM_ROLE";
                    ddl.DataBind();

                    string currentRole = DataBinder.Eval(e.Row.DataItem, "ROLE_").ToString();
                    ddl.SelectedValue = currentRole;
                }
            }
        }

        private DataTable GetAllRoles()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT NOM_ROLE FROM ROLES", conn);
                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void btnAjouterRole_Click(object sender, EventArgs e)
        {
            string nouveauRole = txtNouveauRole.Text.Trim();
            if (string.IsNullOrWhiteSpace(nouveauRole))
            {
                lblMessage.Text = "Le nom du rôle est vide.";
                return;
            }

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand checkCmd = new OracleCommand("SELECT COUNT(*) FROM ROLES WHERE NOM_ROLE = :role", conn);
                checkCmd.Parameters.Add(new OracleParameter("role", nouveauRole));
                int count = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (count == 0)
                {
                    OracleCommand insertCmd = new OracleCommand("INSERT INTO ROLES (NOM_ROLE) VALUES (:role)", conn);
                    insertCmd.Parameters.Add(new OracleParameter("role", nouveauRole));
                    insertCmd.ExecuteNonQuery();
                    lblMessage.Text = "Rôle ajouté avec succès.";
                }
                else
                {
                    lblMessage.Text = "Ce rôle existe déjà.";
                }
            }
            txtNouveauRole.Text = "";
        }

        protected void btnRecherche_Click(object sender, EventArgs e)
        {
            string filtre = txtRecherche.Text.Trim();
            ChargerUtilisateurs(filtre);
        }

        protected void gvUsers_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
