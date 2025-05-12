using PROJETFIN1.DataSetProspectTableAdapters;
using System;
namespace PROJETFIN1
{
    public partial class Dashboard : System.Web.UI.Page
    {
        CLIENT_PROSPECTTableAdapter tPROSPECTS_ = new CLIENT_PROSPECTTableAdapter();
        UTILISATEUR_TableAdapter tUTILISATEUR_ = new UTILISATEUR_TableAdapter();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Récupérer les valeurs en les convertissant avec GetValueOrDefault() pour éviter les erreurs
                decimal ProspectCount = tPROSPECTS_.Nbr_Prospect().GetValueOrDefault();
                int usersCount = Convert.ToInt32(tUTILISATEUR_.Nbr_Users());
                lblUsersCount.Text = usersCount.ToString();

                lblProspectsCount.Text = ProspectCount.ToString();
            }
        }
    }
}
