using PROJETFIN1.DataSetProspectTableAdapters;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PROJETFIN1
{
    public partial class AjoutClient : System.Web.UI.Page
    {
        CLIENT_PROSPECTTableAdapter tPROSPECTS_ = new CLIENT_PROSPECTTableAdapter();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            string nom = Nom.Value.Trim();

            decimal capital = 0;
            string formeJuridique = DropDownList6.SelectedValue;
            string secteur = DDLSecteur.SelectedValue;
            string sousSecteur = DDLSSecteur.SelectedValue;
            string canal = DropDownList1.SelectedValue;
            string nbEmployes = DropDownList3.SelectedValue;
            string wilaya = DropDownList2.SelectedValue;
            string commune = DDLCommune.SelectedValue;
            string codePostal = DropDownList5.SelectedValue;
            string dirigeant = Request.Form["Dirigeant"]?.Trim();
            string besoins = Request.Form["Besoins"]?.Trim();
            string typeRencontre = TypeRencontreDDL.SelectedValue;
            string interdit = RadioButtonList2?.SelectedValue ?? "";
            string blacklist = RadioButtonList1.SelectedValue ?? "";
            string adresse = $"{commune}, {wilaya}, {codePostal}";

            if (string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(formeJuridique) ||
                string.IsNullOrEmpty(secteur) || string.IsNullOrEmpty(sousSecteur) || string.IsNullOrEmpty(dirigeant) ||
                string.IsNullOrEmpty(nbEmployes) || string.IsNullOrEmpty(adresse) || string.IsNullOrEmpty(besoins) ||
                string.IsNullOrEmpty(typeRencontre) || string.IsNullOrEmpty(canal) || string.IsNullOrEmpty(interdit) ||
                string.IsNullOrEmpty(blacklist))
            {
                ShowAlert("Erreur", "Veuillez remplir tous les champs.", "error");
                return;
            }

            var existingProspects = tPROSPECTS_.GetData();
            foreach (var p in existingProspects)
            {
                if (p.NOM.Equals(nom, StringComparison.OrdinalIgnoreCase))
                {
                    ShowAlert("Erreur", "Ce client existe déjà dans la base de données.", "error");
                    return;
                }
            }

            int rowsInserted = tPROSPECTS_.InsertClient(
                1, // ID_PROSPECT simulé ou à adapter si auto-incrément
                nom,
                secteur,
                sousSecteur,
                besoins,
                nbEmployes,
                adresse,
                typeRencontre,
                canal,
                blacklist,
                interdit,
                DateTime.Now,
         
                formeJuridique,
                "",
                "",
                "");

            if (rowsInserted > 0)
            {
                ShowAlert("Succès", "Le prospect a été ajouté avec succès !", "success");
            }
            else
            {
                ShowAlert("Erreur", "Une erreur est survenue lors de l'ajout.", "error");
            }
        }

        protected void BtnSoumettreDirecteur_Click(object sender, EventArgs e)
        {
            // TODO: Implémenter la logique de soumission au directeur
        }

        protected void BtnClasserMotif_Click(object sender, EventArgs e)
        {
            // TODO: Implémenter la logique de classement avec motif
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            SqlSSecteur.DataBind();
            DDLSSecteur.DataBind();
        }

        protected void SqlDataSource2_Selecting1(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
        }

        private void ShowAlert(string titre, string message, string icone)
        {
            message = message.Replace("'", "\\'");
            string script = $"Swal.fire(\"{titre}\", \"{message}\", \"{icone}\");";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }
    }
}
