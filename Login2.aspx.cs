using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using Oracle.ManagedDataAccess.Client;
using System.Web.UI;

namespace PROJETFIN1
{
    public partial class Login2 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        protected void btnValider_Click(object sender, EventArgs e)
        {
            string username = txtIdentifiant.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
            {
                ShowAlert("Veuillez remplir tous les champs.");
                return;
            }

            if (password != confirmPassword)
            {
                ShowAlert("Les mots de passe ne correspondent pas.");
                return;
            }

            if (!IsPasswordValid(password))
            {
                ShowAlert("Le mot de passe doit contenir : une majuscule, une minuscule, un chiffre, un caractère spécial, et avoir entre 8 et 16 caractères.");
                return;
            }

            string hashedPassword = HashPassword(password);
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Mise à jour du mot de passe et du statut
                    string updateQuery = "UPDATE UTILISATEUR_ SET PASSWORD_ = :hashedPwd, STATUS = '1' WHERE IDENTIFIANT = :identifiant";

                    using (OracleCommand updateCmd = new OracleCommand(updateQuery, conn))
                    {
                        updateCmd.Parameters.Add(":hashedPwd", OracleDbType.Varchar2).Value = hashedPassword;
                        updateCmd.Parameters.Add(":identifiant", OracleDbType.Varchar2).Value = username;

                        int rowsAffected = updateCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Récupérer le rôle de l'utilisateur
                            string roleQuery = "SELECT ROLE_ FROM UTILISATEUR_ WHERE IDENTIFIANT = :identifiant";

                            using (OracleCommand roleCmd = new OracleCommand(roleQuery, conn))
                            {
                                roleCmd.Parameters.Add(":identifiant", OracleDbType.Varchar2).Value = username;

                                using (OracleDataReader reader = roleCmd.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        string role = reader["ROLE_"].ToString();

                                        // Redirection selon le rôle
                                        if (role == "Administrateur")
                                            Response.Redirect("Dashboard.aspx");
                                        else if (role == "Chargé d'affaires")
                                            Response.Redirect("Dashboard.aspx");
                                        else if (role == "Directeur d'agence")
                                            Response.Redirect("Dashboard.aspx");
                                        else if (role == "Comité crédit")
                                            Response.Redirect("Dashboard.aspx");
                                        else
                                            Response.Redirect("Dashboard.aspx");
                                    }
                                    else
                                    {
                                        ShowAlert("Rôle utilisateur introuvable.");
                                    }
                                }
                            }
                        }
                        else
                        {
                            ShowAlert("Identifiant non trouvé ou erreur lors de la mise à jour.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    ShowAlert("Erreur de connexion : " + ex.Message);
                }
            }
        }

        private bool IsPasswordValid(string password)
        {
            if (password.Length < 8 || password.Length > 16)
                return false;
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[A-Z]")) // Majuscule
                return false;
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[a-z]")) // Minuscule
                return false;
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, "[0-9]")) // Chiffre
                return false;
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"[\W_]")) // Caractère spécial
                return false;
            return true;
        }

        private void ShowAlert(string message)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('{message}');", true);
        }

        private string HashPassword(string password)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] bytes = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
