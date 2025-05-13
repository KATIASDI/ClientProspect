using PROJETFIN1.DataSetProspectTableAdapters;
using System;
using System.Web.Security;
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
                string role = Session["ROLE_"] as string;

                if (string.IsNullOrEmpty(role))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Par défaut, tout est masqué sauf Dashboard
                linkDashboard.Visible = true;

                linkManageUsers.Visible = false;
                linkAddUser.Visible = false;
                linkRolesPermissions.Visible = false;
                linkHistory.Visible = false;
                linkSettings.Visible = false;
                linkAddProspect.Visible = false;
                linkViewProspect.Visible = false;
                linkVote.Visible = false;
                linkViewVote.Visible = false;
                linkPlanningVisite.Visible = false;
                linkDecision.Visible = false;

                switch (role)
                {
                    case "Administrateur":
                        linkManageUsers.Visible = true;
                        linkAddUser.Visible = true;
                        linkRolesPermissions.Visible = true;
                        linkHistory.Visible = true;
                        linkSettings.Visible = true;
                        break;

                    case "Chargé d'affaires":
                        linkAddProspect.Visible = true;
                        linkViewProspect.Visible = true;
                        linkPlanningVisite.Visible = true;
                        break;

                    case "Directeur d'agence":
                        linkViewProspect.Visible = true;
                        break;

                    case "Direction commerciale":
                        linkViewProspect.Visible = true;
                        linkViewVote.Visible = true;
                        linkDecision.Visible = true;
                        break;

                    case "Comité crédit":
                        linkVote.Visible = true;
                        linkViewProspect.Visible = true;
                        break;

                    default:
                        // Rôle inconnu, redirection par sécurité
                        Response.Redirect("Login.aspx");
                        break;
                }

                // Statistiques
                decimal ProspectCount = tPROSPECTS_.Nbr_Prospect().GetValueOrDefault();
                int usersCount = Convert.ToInt32(tUTILISATEUR_.Nbr_Users());
                lblUsersCount.Text = usersCount.ToString();
                lblProspectsCount.Text = ProspectCount.ToString();
            }
        }

    }
}
        
    

