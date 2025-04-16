using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace PROJETFIN1
{
    public partial class DirComm : System.Web.UI.Page
    {
        [Serializable]
        public class Prospect
        {
            public string Nom { get; set; }
            public string Capital { get; set; }
            public string Activite { get; set; }
            public string Dirigeant { get; set; }
            public int Employes { get; set; }
            public string Adresse { get; set; }
            public string Besoins { get; set; }
            public string Rencontre { get; set; }
            public string Canal { get; set; }
            public bool InterditChequier { get; set; }
            public bool Blackliste { get; set; }
        }

        static List<Prospect> prospects = new List<Prospect>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                prospects = new List<Prospect>
                {
                    new Prospect { Nom = "Entreprise A", Capital = "100000 €", Activite = "Tech", Dirigeant = "M. Dupont", Employes = 25, Adresse = "Paris", Besoins = "Financement", Rencontre = "Présentiel", Canal = "Site Web", InterditChequier = false, Blackliste = false },
                    new Prospect { Nom = "Entreprise B", Capital = "50000 €", Activite = "Santé", Dirigeant = "Mme Durand", Employes = 12, Adresse = "Lyon", Besoins = "Investissement", Rencontre = "Distantiel", Canal = "Événement", InterditChequier = true, Blackliste = false },
                    new Prospect { Nom = "Startup C", Capital = "20000 €", Activite = "IA", Dirigeant = "M. Martin", Employes = 8, Adresse = "Toulouse", Besoins = "Accompagnement bancaire", Rencontre = "Présentiel", Canal = "LinkedIn", InterditChequier = false, Blackliste = true },
                    new Prospect { Nom = "Société D", Capital = "150000 €", Activite = "BTP", Dirigeant = "Mme Petit", Employes = 45, Adresse = "Marseille", Besoins = "Matériel", Rencontre = "Présentiel", Canal = "Partenariat", InterditChequier = true, Blackliste = true },
                    new Prospect { Nom = "Entreprise E", Capital = "75000 €", Activite = "Agroalimentaire", Dirigeant = "M. Lopez", Employes = 30, Adresse = "Nice", Besoins = "Exportation", Rencontre = "Distantiel", Canal = "Recommandation", InterditChequier = false, Blackliste = false },
                    new Prospect { Nom = "SARL F", Capital = "30000 €", Activite = "Transport", Dirigeant = "Mme Girard", Employes = 20, Adresse = "Strasbourg", Besoins = "Véhicules", Rencontre = "Présentiel", Canal = "Site Web", InterditChequier = false, Blackliste = false }
                };

                gvProspects.DataSource = prospects;
                gvProspects.DataBind();
            }
        }

        protected void gvProspects_SelectedIndexChanged(object sender, EventArgs e)
        {
            int index = gvProspects.SelectedIndex;
            string nom = gvProspects.Rows[index].Cells[1].Text;
            Prospect p = prospects.Find(pr => pr.Nom == nom);

            if (p != null)
            {
                lblNom.Text = p.Nom;
                lblCapital.Text = p.Capital;
                lblActivite.Text = p.Activite;
                lblDirigeant.Text = p.Dirigeant;
                lblEmployes.Text = p.Employes.ToString();
                lblAdresse.Text = p.Adresse;
                lblBesoins.Text = p.Besoins;
                lblRencontre.Text = p.Rencontre;
                lblCanal.Text = p.Canal;
                lblInterditChequier.Text = p.InterditChequier ? "Oui" : "Non";
                lblBlacklist.Text = p.Blackliste ? "Oui" : "Non";

                ficheOverlay.Style["display"] = "flex";
            }
        }

        protected void btnInfos_Click(object sender, EventArgs e)
        {
            // Action pour demander des informations complémentaires
        }

        protected void btnComite_Click(object sender, EventArgs e)
        {
            // Action pour soumettre au comité crédit
        }
    }
}
