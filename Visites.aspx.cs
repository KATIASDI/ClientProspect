using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace DashboardChargeAffaire
{
    public partial class Visites : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerProspects();
            }
        }

        private void ChargerProspects()
        {
            string connString = ConfigurationManager.ConnectionStrings["OracleDbContext"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connString))
            {
                conn.Open();
                string query = "SELECT ID_PROSPECT, NOM FROM CLIENT_PROSPECT";
                using (OracleCommand cmd = new OracleCommand(query, conn))
                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    ddlProspect.Items.Clear();
                    ddlProspect.Items.Add(new ListItem("-- Sélectionner un client --", ""));

                    while (reader.Read())
                    {
                        ddlProspect.Items.Add(new ListItem(reader["NOM"].ToString(), reader["ID_PROSPECT"].ToString()));
                    }
                }
            }
        }

        protected void btnPlanifier_Click(object sender, EventArgs e)
        {
            if (ddlProspect.SelectedIndex <= 0)
            {
                lblMessage.Text = "Veuillez sélectionner un client.";
                return;
            }

            string typeRencontre = "Visite commerciale";
            int idProspect = int.Parse(ddlProspect.SelectedValue);
            int idUser = 1; // ID de l'utilisateur connecté, à récupérer dynamiquement
            string date = txtDate.Text;
            string heure = txtHeure.Text;
            string lieu = txtLieu.Text;

            // TODO : Ajouter les colonnes DATE_VISITE, HEURE_VISITE, LIEU dans la table VISITE si elles n'existent pas

            string connString = ConfigurationManager.ConnectionStrings["OracleDbContext"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connString))
            {
                conn.Open();
                string query = @"INSERT INTO VISITE (ID_VISITE, TYPERENCONTRE, ID_PROSPECT, ID_USER)
                                 VALUES (SEQ_VISITE.NEXTVAL, :type, :idProspect, :idUser)";

                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    cmd.Parameters.Add(":type", typeRencontre);
                    cmd.Parameters.Add(":idProspect", idProspect);
                    cmd.Parameters.Add(":idUser", idUser);
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "✅ Visite planifiée avec succès !";
        }
    }
}
