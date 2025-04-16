using System;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace TonNamespace
{
    public partial class test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerUtilisateurs();
            }
        }

        private void ChargerUtilisateurs()
        {
            string connectionString = "User Id=KATIA;Password=hbtf2025;Data Source=Katia12:1521/PROSPECT";

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT NAME FROM UTILISATEUR_ WHERE PASSWORD_ LIKE 'pass%'";

                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            gvUtilisateurs.DataSource = dt;
                            gvUtilisateurs.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Erreur : " + ex.Message;
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}
