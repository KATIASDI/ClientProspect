using PROJETFIN1.DataSetProspectTableAdapters;
using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace PROJETFIN1
{
    public partial class AjoutClient : System.Web.UI.Page
    {
        CLIENT_PROSPECTTableAdapter tPROSPECTS_ = new CLIENT_PROSPECTTableAdapter();
        //VISITETableAdapter tVisite = new VISITETableAdapter();
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            //string nom = Nom.Value.Trim();
            var nom = TBNom.Text.Trim();
            decimal CAPITAL = Convert.ToDecimal(TBCapital.Text.Trim());
           
            string formeJuridique = DropDownList6.SelectedValue;
            string secteur = DDLSecteur.SelectedValue;
            string sousSecteur = DDLSSecteur.SelectedValue;
            string canal = DropDownList1.SelectedValue;
            string nbEmployes = DropDownList3.SelectedValue;
            string wilaya = DropDownList2.SelectedValue;
            string dirigeant = Request.Form["Dirigeant"]?.Trim();
            string besoins = TBBesoins.Text.Trim();
            string typeRencontre = TypeRencontreDDL.SelectedValue;
            string interdit = RadioButtonList2?.SelectedValue ?? "";
            string blacklist = RadioButtonList1.SelectedValue ?? "";
            string numTel = TBNumTel.Text.Trim();
            string email = TBEMAIL.Text.Trim();
            string adresse = TBAdresse.Text.Trim();
            // TBNumTel est ton TextBox pour le numéro


            int rowsInserted = 0;

            //ne pas inserer un Client qui existe deja 
            bool AuMoinsUnNull = new[] { nom, formeJuridique, secteur, sousSecteur, dirigeant, nbEmployes, wilaya, canal, interdit, blacklist,email,adresse }.Any(string.IsNullOrEmpty);
             if (true)/*(!AuMoinsUnNull)*/

                {
                    int ifExists = (int)tPROSPECTS_.IfExists(nom.ToUpper()).Value;

                if (ifExists == 0)
                {
                    rowsInserted = tPROSPECTS_.InsertClient(
           nom,
           secteur,
           sousSecteur,
           besoins,
           nbEmployes, // <- ici on met l'entier converti
           typeRencontre,
           canal,
           blacklist,
           interdit,
           DateTime.Now,
           CAPITAL,
           formeJuridique,
           numTel,
           email,
           adresse
           // commentaire
            // numtel
       );
                }
                else
                {

                    ShowAlert("Erreur", "Nom Prospect exite déjà.", "error");
                    return;
                }

            }
            else
            {
                ShowAlert("Erreur", "Veuillez remplir tous les champs.", "error");
                return;
            }

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

        protected void TypeRencontreDDL_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void TBBesoins_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TBCapital_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
