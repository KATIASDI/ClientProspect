using System;
using System.Data;
using System.Configuration;
using Oracle.ManagedDataAccess.Client;

namespace TonProjet
{
    public partial class VISITE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerVisites();
            }
        }

        private void ChargerVisites()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection con = new OracleConnection(connectionString))
            {
                string query = @"SELECT ID_VISITE, ID_PROSPECT, ID_USER, DATE_VISITE, EXTENSION, CRV_TMP 
                                 FROM VISITE 
                                 ORDER BY DATE_VISITE DESC";

                using (OracleCommand cmd = new OracleCommand(query, con))
                {
                    OracleDataAdapter da = new OracleDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewVisites.DataSource = dt;
                    GridViewVisites.DataBind();
                }
            }
        }
    }
}
