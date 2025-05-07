using static PROJETFIN1.ChargeAff;
using PROJETFIN1.DataSetProspectTableAdapters;
using System;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROJETFIN1
{
    public partial class Admin : Page
    {
        UTILISATEUR_TableAdapter tUTILISATEUR_ =new UTILISATEUR_TableAdapter(); 

        /* private static string connectionString = "Data Source=Katia12:1521/PROSPECT;User Id=KATIAa;Password=hbtf2025;";
        */
        private static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChargerStatistiques();
                ChargerUtilisateurs();
            }
        }

        private void ChargerStatistiques()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT COUNT(*) FROM UTILISATEUR_", conn);
                lblUsers.Text = cmd.ExecuteScalar().ToString();

                lblMessages.Text = "30";
            }
        }

        private void ChargerUtilisateurs()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT IDENTIFIANT AS ID, NAME AS Nom, ROLE_ as ROLE, DATE_CREATION AS DateAjout, EMAIL FROM UTILISATEUR_", conn);
                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsers.DataSource = dt;
                gvUsers.DataBind(); // Ajoute cette ligne pour afficher les données
            }
        }

        
        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string userId = e.CommandArgument.ToString();
            if (e.CommandName == "EditUser")
            {
                Response.Redirect("EditUser.aspx?id=" + userId);
            }
           else if (e.CommandName == "DesactivateUser")
            {
                ConfirmerSuppression(e.CommandArgument.ToString());
            }

        }
        private void ConfirmerSuppression(string userId)
        {
     //       tUTILISATEUR_.UpdateStatus1(userId, "2"); // Mettre à jour le statut de l'utilisateur 
            //using (OracleConnection conn = new OracleConnection(connectionString))
            //{
            //  conn.Open();
            //   OracleCommand cmd = new OracleCommand("UPDATE UTILISATEUR_ SET STATUS =2 WHERE IDENTIFIANT = :id", conn);
            //    cmd.Parameters.Add(new OracleParameter("id", userId));

            // int rowsAffected = cmd.ExecuteNonQuery();

            // if (rowsAffected > 0)
            //  {
            //     ChargerUtilisateurs();  // Rafraîchir le GridView après mise à jour
            //   }
            //}
        }
     
      

        protected void btnAjouter_Click(object sender, EventArgs e)
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("INSERT INTO UTILISATEUR_ (IDENTIFIANT, NAME, ROLE_, DATE_CREATION, NUMEROTEL, EMAIL) VALUES (:id, :name, :role, :date, :tel, :email)", conn);

                string newId = Guid.NewGuid().ToString().Substring(0, 5); // Générer un ID unique
                cmd.Parameters.Add(new OracleParameter("id", newId));
                cmd.Parameters.Add(new OracleParameter("name", "Nouvel Utilisateur"));
                cmd.Parameters.Add(new OracleParameter("role", "Utilisateur"));
                cmd.Parameters.Add(new OracleParameter("date", DateTime.Now.ToString("dd/MM/yy")));
                cmd.Parameters.Add(new OracleParameter("email", "nouveau@email.com"));

                cmd.ExecuteNonQuery();
            }
            ChargerUtilisateurs();
        }

        protected void gvUsers_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string id = btn.CommandArgument;
            tUTILISATEUR_.UpdateStatus1("2", id);
            Response.Redirect("~/Admin.aspx");
        }

    }

}
