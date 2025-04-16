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

            // Ici tu peux ajouter du code pour enregistrer ces informations dans une base de données

            Response.Write("<script>alert('Compte rendu enregistré avec succès !');</script>");
        }
    }
}
