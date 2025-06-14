﻿//using static PROJETFIN1.ChargeAff;
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
                ChargerUtilisateurs();
            }

            string eventTarget = Request["__EVENTTARGET"];
            string eventArgument = Request["__EVENTARGUMENT"];

            if (!string.IsNullOrEmpty(eventTarget) && eventTarget == "ConfirmerSuppression")
            {
                ConfirmerSuppression(eventArgument); // Appelle ta méthode existante
            }
        }

      

        private void ChargerUtilisateurs()
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                OracleCommand cmd = new OracleCommand("SELECT IDENTIFIANT AS IDENTIFIANT, NAME AS Nom, ROLE_ as ROLE, DATE_CREATION AS DateAjout, EMAIL,STATUS FROM UTILISATEUR_", conn);
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
                using (OracleConnection conn = new OracleConnection(connectionString))
                {
                    conn.Open();
                    OracleCommand cmd = new OracleCommand("SELECT IDENTIFIANT, NAME, EMAIL, ROLE_, STATUS FROM UTILISATEUR_ WHERE IDENTIFIANT = :id", conn);
                    cmd.Parameters.Add(new OracleParameter("id", userId));
                    OracleDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hiddenIdentifiant.Value = reader["IDENTIFIANT"].ToString();
                        txtName.Text = reader["NAME"].ToString();
                        txtEmail.Text = reader["EMAIL"].ToString();
                        txtRole.Text = reader["ROLE_"].ToString();
                        txtStatus.Text = reader["STATUS"].ToString();

                        pnlEditForm.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "Desactiver")
            {
                string identifiant = e.CommandArgument.ToString();
                ConfirmerSuppression(identifiant);
            }
            else if (e.CommandName == "Reactivier")
            {
                string identifiant = e.CommandArgument.ToString();
                ReactiverUtilisateur(identifiant);
            }

        }
        private void ReactiverUtilisateur(string userId)
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                using (OracleCommand cmd = new OracleCommand("UPDATE UTILISATEUR_ SET STATUS = 1 WHERE IDENTIFIANT = :id", conn))
                {
                    cmd.Parameters.Add(new OracleParameter("id", userId));
                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected > 0)
                    {
                        ShowAlert("Réactivé", "Utilisateur réactivé avec succès.", "success");
                        ChargerUtilisateurs();  // Rafraîchit le GridView
                    }
                }
            }
        }

        private void ConfirmerSuppression(string userId)
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                using (OracleCommand cmd = new OracleCommand("UPDATE UTILISATEUR_ SET STATUS = 2 WHERE IDENTIFIANT = :id", conn))
                {
                    cmd.Parameters.Add(new OracleParameter("id", userId));

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowAlert("Désactivé", "Utilisateur désactivé avec succès.", "success");

                        ChargerUtilisateurs();  // Rafraîchir le GridView après mise à jour
                    }
                    else
                    {
                        // Optionnel : afficher un message d'erreur si nécessaire
                    }
                }
            }
        }
        private void ShowAlert(string title, string message, string icon)
        {
            string script = $@"<script>
        Swal.fire({{
            title: '{title}',
            text: '{message}',
            icon: '{icon}',
            confirmButtonText: 'OK'
        }});
    </script>";

            ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script);
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
            ShowAlert("Succès", "Nouvel utilisateur ajouté avec succès.", "success");

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // On récupère la saisie du TextBox serveur
            string filtre = txtSearch.Text.Trim();
            ChargerUtilisateurs(filtre);
        }

        private void ChargerUtilisateurs(string filtre = "")
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();

                string sql = @"
            SELECT IDENTIFIANT AS IDENTIFIANT,
                   NAME         AS Nom,
                   ROLE_        AS ROLE,
                   DATE_CREATION AS DateAjout,
                   EMAIL,
                   STATUS
            FROM UTILISATEUR_";

                if (!string.IsNullOrEmpty(filtre))
                {
                    sql += @"
            WHERE LOWER(NAME)    LIKE :filtre
               OR LOWER(EMAIL)   LIKE :filtre
               OR LOWER(ROLE_)   LIKE :filtre";
                }

                using (OracleCommand cmd = new OracleCommand(sql, conn))
                {
                    if (!string.IsNullOrEmpty(filtre))
                        cmd.Parameters.Add(new OracleParameter("filtre", "%" + filtre.ToLower() + "%"));

                    OracleDataAdapter da = new OracleDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
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

       
        protected void btnEdit_Command(object sender, CommandEventArgs e)
        {
            string identifiant = e.CommandArgument.ToString();
            hiddenIdentifiant.Value = identifiant;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT NAME, EMAIL, ROLE_, STATUS FROM UTILISATEUR_ WHERE IDENTIFIANT = :id";

                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    cmd.Parameters.Add(new OracleParameter("id", identifiant));
                    using (OracleDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtName.Text = reader["NAME"].ToString();
                            txtEmail.Text = reader["EMAIL"].ToString();
                            txtRole.Text = reader["ROLE_"].ToString();
                            txtStatus.Text = reader["STATUS"].ToString();
                            pnlEditForm.Visible = true;
                        }
                    }
                }
            }
        }

        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            string identifiant = hiddenIdentifiant.Value;
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string role = txtRole.Text.Trim();
            string status = txtStatus.Text.Trim();

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                conn.Open();
                string query = "UPDATE UTILISATEUR_ SET NAME = :name, EMAIL = :email, ROLE_ = :role, STATUS = :status WHERE IDENTIFIANT = :id";

                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    cmd.Parameters.Add(new OracleParameter("name", name));
                    cmd.Parameters.Add(new OracleParameter("email", email));
                    cmd.Parameters.Add(new OracleParameter("role", role));
                    cmd.Parameters.Add(new OracleParameter("status", status));
                    cmd.Parameters.Add(new OracleParameter("id", identifiant));

                    cmd.ExecuteNonQuery();
                }
            }

            pnlEditForm.Visible = false;
            ChargerUtilisateurs();
            ShowAlert("Mis à jour", "Les informations ont été mises à jour.", "success");
            // Recharge la liste
        }


    }

}
