using System;
using System.Globalization;
using System.Threading;
using System.Web.UI;

namespace YourNamespace
{
    public partial class Settings : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Charger les préférences actuelles depuis la session
                if (Session["Langue"] != null)
                    ddlLangue.SelectedValue = Session["Langue"].ToString();

                if (Session["Theme"] != null)
                    rblTheme.SelectedValue = Session["Theme"].ToString();

                if (Session["NotifEmail"] != null)
                    chkEmailNotif.Checked = (bool)Session["NotifEmail"];
            }
        }

        // Enregistrer la langue choisie et recharger la page
        protected void btnChangeLangue_Click(object sender, EventArgs e)
        {
            // Sauvegarder la langue en session
            Session["Langue"] = ddlLangue.SelectedValue;

            // Modifier la culture pour appliquer la langue
            string culture = ddlLangue.SelectedValue;
            CultureInfo ci = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = ci;
            Thread.CurrentThread.CurrentUICulture = ci;

            // Recharger la page pour appliquer la langue
            Response.Redirect(Request.RawUrl);
        }

        // Enregistrer le thème choisi et recharger la page
        protected void btnTheme_Click(object sender, EventArgs e)
        {
            // Sauvegarder le thème en session
            Session["Theme"] = rblTheme.SelectedValue;

            // Recharger la page pour appliquer le thème
            Response.Redirect(Request.RawUrl);
        }

        // Enregistrer les préférences de notification
        protected void btnNotif_Click(object sender, EventArgs e)
        {
            // Sauvegarder l'état des notifications en session
            Session["NotifEmail"] = chkEmailNotif.Checked;

            // Afficher un message de confirmation
            lblMessage.Text = "Préférences mises à jour avec succès.";
        }
    }
}
