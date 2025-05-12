using System;
using System.Text;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;
using PROJETFIN1.DataSetProspectTableAdapters;
using System.Net;
using System.Net.Mail;



namespace PROJETFIN1
{
    public partial class AjoutUser : System.Web.UI.Page
    {
        UTILISATEUR_TableAdapter tUTILISATEUR_ = new UTILISATEUR_TableAdapter();

        #region btnEnregistrer_Click
        protected void btnEnregistrer_Click(object sender, EventArgs e)
        {
            string nom = txtNom.Text.Trim();
            string email = txtEmail.Text.Trim();
            string identifiant = txtIdentifiant.Text.Trim();
            string roleTexte = ddlRole.SelectedValue;
            string password = txtPassword.Text.Trim();

            // Vérification des champs obligatoires
            if (string.IsNullOrEmpty(nom) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(identifiant) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(roleTexte))
            {
                ShowAlert("Erreur", "Tous les champs sont obligatoires.", "error");
                return;
            }

            // Vérification du format de l'email
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                lblEmailError.Text = "Format incorrect de l'email.";
                lblEmailError.Visible = true;
                return;
            }

            // 🔍 Vérifier si l'utilisateur existe déjà
            var existingUsers = tUTILISATEUR_.GetData(); // Récupère tous les utilisateurs
            foreach (var user in existingUsers)
            {
                if (user.EMAIL.Equals(email, StringComparison.OrdinalIgnoreCase))
                {
                    ShowAlert("Erreur", "Cet email est déjà utilisé.", "error");
                    return;
                }

                if (user.IDENTIFIANT.Equals(identifiant, StringComparison.OrdinalIgnoreCase))
                {
                    ShowAlert("Erreur", "Cet identifiant est déjà utilisé.", "error");
                    return;
                }
            }

            // Hachage du mot de passe
            string hashedPassword = HashPassword(password);

            // Insertion dans la base de données
            int nbInsertedRows = tUTILISATEUR_.InsertUtilisateur(
                identifiant,
                hashedPassword,
                nom,
                email,
                roleTexte,
                "0",
                DateTime.Now
            );

            if (nbInsertedRows > 0)
            {
                EnvoyerMail(email, nom, identifiant, password);
                ShowAlert("Succès", "Utilisateur ajouté avec succès !", "success");
            }

            else
            {
                string message = "Une erreur est survenue lors de l'ajout.";
                string safeMessage = HttpUtility.JavaScriptStringEncode(message);
                string script = $"Swal.fire('Erreur', '{safeMessage}', 'error');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);


            }
        }
        #endregion

        // Hachage MD5
        public static string HashPassword(string password)
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

        private void ShowAlert(string title, string message, string icon)
        {
            message = message.Replace("'", "\\'");
            string script = $"Swal.fire(\"{title}\", \"{message}\", \"{icon}\");";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        protected void txtNom_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtIdentifiant_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void EnvoyerMail(string destinataire, string nomUtilisateur, string identifiant, string motDePasseTemporaire)
        {
            var fromAddress = new MailAddress("noreplyhbtf@gmail.com", "HBTF Algérie");
            var toAddress = new MailAddress(destinataire);
            const string sujet = "Création de votre compte HBTF";

            string body = $@"
Bonjour {nomUtilisateur},

Votre compte a été créé avec succès sur notre plateforme HBTF Algérie.

Veuillez vous connecter en utilisant les identifiants suivants :
- Identifiant : {identifiant}
- Mot de passe temporaire : {motDePasseTemporaire}

Pour votre sécurité, pensez à changer votre mot de passe après la première connexion.

Cordialement,
L'équipe HBTF.";

            string motDePasseApp = "zkyetzzjkwmfouzn"; // 🔐 À sécuriser ailleurs en prod (fichier de config chiffré)

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, motDePasseApp)
            };

            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = sujet,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }

    }
}
