using System;
using System.Configuration;
using Oracle.ManagedDataAccess.Client; // ODP.NET moderne

namespace PROJETFIN1
{
    public partial class EditUser : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    string identifiant = Request.QueryString["id"];
                    RemplirChamps(identifiant);
                }
                else
                {
                    Response.Redirect("Admin.aspx");
                }
            }
        }

        private void RemplirChamps(string identifiant)
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                string query = "SELECT NAME, EMAIL, IDENTIFIANT, ROLE_ FROM UTILISATEUR_ WHERE IDENTIFIANT = :identifiant";
                OracleCommand cmd = new OracleCommand(query, conn);
                cmd.Parameters.Add(new OracleParameter("identifiant", OracleDbType.Varchar2)).Value = identifiant;

                conn.Open();
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtNom.Text = reader["NAME"].ToString();
                    txtEmail.Text = reader["EMAIL"].ToString();
                    txtIdentifiant.Text = reader["IDENTIFIANT"].ToString();
                    ddlRole.SelectedValue = reader["ROLE_"].ToString();
                }

                conn.Close();
            }
        }

        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            string identifiant = Request.QueryString["id"];

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                string updateQuery = @"
                    UPDATE UTILISATEUR_ 
                    SET NAME = :nom, 
                        EMAIL = :email, 
                        ROLE_ = :role 
                    WHERE IDENTIFIANT = :identifiant";

                OracleCommand cmd = new OracleCommand(updateQuery, conn);
                cmd.Parameters.Add(new OracleParameter("nom", OracleDbType.Varchar2)).Value = txtNom.Text;
                cmd.Parameters.Add(new OracleParameter("email", OracleDbType.Varchar2)).Value = txtEmail.Text;
                cmd.Parameters.Add(new OracleParameter("role", OracleDbType.Varchar2)).Value = ddlRole.SelectedValue;
                cmd.Parameters.Add(new OracleParameter("identifiant", OracleDbType.Varchar2)).Value = identifiant;

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("Admin.aspx?msg=updated");
            }
        }
        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRole = ddlRole.SelectedValue;
            // Traitez la sélection ici
        }

    }

}
