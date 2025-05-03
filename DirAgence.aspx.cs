using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJETFIN1
{
    public partial class DirAgence : Page
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerProspects();

            }

            if (IsPostBack && !string.IsNullOrWhiteSpace(txtMotifRejet.Text))
            {
                pnlMotifRejet.Visible = true;
                rfvMotifRejet.Enabled = true;
            }
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            gvProspects.RowCommand += gvProspects_RowCommand; // Toujours exécuté, même en postback
        }


        protected void btnTransmettre_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "✅ Prospect transmis à la direction commerciale avec succès.";
            lblMessage.CssClass = "text-success fw-bold";
            pnlDetails.Visible = false;
        }

        protected void btnDemanderInfos_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "📩 Une demande d'informations complémentaires a été envoyée.";
            lblMessage.CssClass = "text-warning fw-bold";
            pnlDetails.Visible = false;
        }


        private void ChargerProspects()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                string query = @"SELECT ID_PROSPECT, NOM, SECTEUR, SOUS_SECTEUR, BESOINS, NBR_EMPLOYES, 
                                        TYPE_RENCONTRE, CAPITAL, FORME_JURIDIQUE 
                                 FROM CLIENT_PROSPECT";

                OracleCommand cmd = new OracleCommand(query, conn);
                OracleDataAdapter adapter = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvProspects.DataSource = dt;
                gvProspects.DataBind();
            }
        }

        protected void btnValider_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "✅ Fiche validée et transmise avec succès.";
            lblMessage.CssClass = "text-success fw-bold";

            txtMotifRejet.Text = string.Empty;
            pnlMotifRejet.Visible = false;
        }


        protected void gvProspects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetails")
            {
                int idProspect = Convert.ToInt32(e.CommandArgument);
                ChargerDetailsProspect(idProspect);
            }
        }
        protected void btnRetour_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
            hfCurrentProspectId.Value = "";
        }
        private void UpdateStatutProspect(string idProspect, string nouveauStatut)
        {

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE CLIENT_PROSPECT SET STATUT = @Statut WHERE ID_PROSPECT = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Statut", nouveauStatut);
                    cmd.Parameters.AddWithValue("@Id", idProspect);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        private void LoadProspects()
        {

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM CLIENT_PROSPECT WHERE STATUT != '2.2'"; // tu exclus les rejetés

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    gvProspects.DataSource = dt;
                    gvProspects.DataBind();
                }
            }
        }

        protected void btnRejeterMotif_Click(object sender, EventArgs e)
        {
            string idProspect = hfCurrentProspectId.Value;

            if (!string.IsNullOrEmpty(idProspect))
            {
                lblMessage.Text = "❌ Merci d'indiquer un motif de rejet ci-dessous.";
                lblMessage.CssClass = "text-danger fw-bold";
                pnlMotifRejet.Visible = true;
                rfvMotifRejet.Enabled = true;
                // 1. Mettre à jour le statut du prospect dans la base de données
                UpdateStatutProspect(idProspect, "2.2");

                // 2. Recharger les données du GridView
                LoadProspects(); // Méthode à appeler qui recharge la liste

                // 3. Cacher le panel de détails
                pnlDetails.Visible = false;

                // 4. Afficher un message (facultatif)
                lblMessage.Text = "Le prospect a été rejeté avec succès.";
                lblMessage.CssClass = "text-danger fw-bold";
            }
        }


        private void ChargerDetailsProspect(int id)
        {
            hfCurrentProspectId.Value = id.ToString();

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT NOM, EMAIL, ADRESSE, CANAL_ACQUISITION, COMMENTAIRE, TO_CHAR(DATE_CREATION, 'DD/MM/YYYY') AS DATE_CREATION FROM CLIENT_PROSPECT WHERE ID_PROSPECT = :id", conn);
                cmd.Parameters.Add(new OracleParameter("id", id));

                using (OracleDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblNom.Text = "Nom : " + reader["NOM"].ToString();
                        lblEmail.Text = "Email : " + reader["EMAIL"].ToString();
                        lblAdresse.Text = "Adresse : " + reader["ADRESSE"].ToString();
                        lblCanal.Text = "Canal d'acquisition : " + reader["CANAL_ACQUISITION"].ToString();
                        lblDateCreation.Text = "Date création : " + reader["DATE_CREATION"].ToString();
                        lblCommentaire.Text = "Commentaire : " + reader["COMMENTAIRE"].ToString();
                        pnlDetails.Visible = true;
                    }
                }
            }
        }

    }
}