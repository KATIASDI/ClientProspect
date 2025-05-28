using System;
using System.Data;
using System.Web.UI;
using System.Configuration;
using System.Data.OracleClient; // Attention : OracleClient est obsolète, préférez Oracle.ManagedDataAccess.Client si possible

namespace VotreProjet
{
    public partial class Historique : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerHistorique();
            }
        }

        private void ChargerHistorique()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                        SELECT ID_PROSPECT, ID_USER, ACTIONS, DATE_ACT
                        FROM HISTORIQUE_
                        ORDER BY DATE_ACT DESC";

                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            GridViewHistorique.DataSource = dt;
                            GridViewHistorique.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Gérer les erreurs (par exemple : logger ou afficher un message)
                    Response.Write("<script>alert('Erreur : " + ex.Message.Replace("'", "\\'") + "');</script>");
                }


            }
        }
    }
}
