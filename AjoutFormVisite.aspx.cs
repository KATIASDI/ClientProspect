using System;
using System.Web.UI;

namespace DashboardFormulaire
{
    public partial class AjoutForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string raisonSociale = txtRaisonSociale.Value;
            string activite = txtActivite.Value;
            string adresse = txtAdresse.Value;
            string contact = txtContact.Value;
            string gerant = txtGerant.Value;
            string distribution = txtDistribution.Value;
            string reputation = txtReputation.Value;
            string solvabilite = txtSolvabilite.Value;

            // Simuler la récupération d'ID
            int idProspect = Convert.ToInt32(Request.QueryString["id_prospect"]);
            int idUser = Convert.ToInt32(Session["user_id"]);
            DateTime dateVisite = DateTime.Now;

            // Affichage de confirmation (exemple)
            Response.Write("<script>alert('Formulaire soumis avec succès !');</script>");
        }
    }
}
