using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TonProjet
{
    public partial class ViewProspect : Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerDonnees();
            }
        }

        private void ChargerDonnees()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT ID_PROSPECT, DATE_CREATION, NOM, CAPITAL, NUMTEL AS TELEPHONE, ADRESSE FROM CLIENT_PROSPECT", conn);
                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VoirVotes")
            {
                string idProspect = e.CommandArgument.ToString();
                // Rediriger vers une page de détails des votes ou afficher les données dans un modal, etc.
                Response.Redirect("VoirVotes.aspx?id=" + idProspect);
            }
        }
    }
}
