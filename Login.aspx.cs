﻿using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using Oracle.ManagedDataAccess.Client;
using System.Web.UI;

namespace YourNamespace
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Hachage du mot de passe en MD5
            string hashedPassword = HashPassword(password);

            // Récupération de la chaîne de connexion
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Vérification de l'utilisateur dans la base de données
                    string query = "SELECT ROLE_, STATUS, ID_USER FROM UTILISATEUR_ WHERE IDENTIFIANT = :Identifiant AND PASSWORD_ = :MotDePasse\r\n";

                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        cmd.Parameters.Add(":Identifiant", OracleDbType.Varchar2).Value = username;
                        cmd.Parameters.Add(":MotDePasse", OracleDbType.Varchar2).Value = hashedPassword; // Comparaison avec le mot de passe haché

                        using (OracleDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string role = reader["ROLE_"].ToString();
                                string iduser = reader["ID_USER"].ToString();

                                int status = Convert.ToInt32(reader["STATUS"]);

                                Session["Username"] = username;


                                Session["ROLE_"] = role;
                                Session["ID_USER"] = iduser;


                                if (status == 0)
                                {
                                    Response.Redirect("Login2.aspx");
                                }
                                else
                                {
                                    if (role == "Administrateur")
                                        Response.Redirect("Dashboard.aspx");
                                    else if (role == "Chargé d'affaires")
                                        Response.Redirect("Dashboard.aspx");
                                    else if (role == "Directeur d'agence")
                                        Response.Redirect("Dashboard.aspx");
                                    else if (role == "Comité crédit")
                                        Response.Redirect("Dashboard.aspx");
                                    else if (role == "Direction commercial")
                                        Response.Redirect("Dashboard.aspx");
                                    else
                                        Response.Redirect("Dashboard.aspx");
                                }
                            }
                            else
                            {
                                lblMessage.Text = "Identifiant ou mot de passe incorrect.";
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Erreur de connexion : " + ex.Message;
                }            }
        }

        // Fonction de hachage MD5
        public static string HashPassword(string password)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] bytes = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2")); // 2 chiffres hexadécimaux par byte
                }
                return builder.ToString(); // Résultat : 32 caractères
            }
        }
    }
}
