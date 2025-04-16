using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using Oracle.ManagedDataAccess.Client;

namespace DashboardChargeAffaire
{
    public partial class Charge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerClientsProspects();
            }
        }

        private void ChargerClientsProspects()
        {
            List<ClientProspect> clients = new List<ClientProspect>
            {
                new ClientProspect { Nom = "Sonatrach", Statut = "En attente du Directeur d'Agence", Progression = 25 },
                new ClientProspect { Nom = "Cosider", Statut = "Validation par la Direction Commerciale", Progression = 50 },
                new ClientProspect { Nom = "Cevital", Statut = "En cours d'entrée en relation", Progression = 75 },
                new ClientProspect { Nom = "Condor", Statut = "Relation établie avec la banque", Progression = 100 }
            };

            rptClients.DataSource = clients;
            rptClients.DataBind();
        }

        protected string GetProgressBarClass(int progression)
        {
            if (progression < 33)
                return "progress-bar-pink";
            else if (progression < 66)
                return "progress-bar-yellow";
            else
                return "progress-bar-blue";
        }
    }

    public class ClientProspect
    {
        public string Nom { get; set; }
        public string Statut { get; set; }
        public int Progression { get; set; }
    }
}
