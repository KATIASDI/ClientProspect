<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login2.aspx.cs" Inherits="PROJETFIN1.Login2" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Mise à jour du mot de passe – Prospect Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            background: linear-gradient(to bottom right, #1e88e5, #42a5f5);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-wrapper {
            display: flex;
            background: white;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 950px;
            width: 100%;
        }

        .login-left {
            background: linear-gradient(to bottom, #2196f3, #1e88e5);
            color: white;
            flex: 1;
            padding: 60px 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .login-left img {
            width: 100%;
            height: auto;
            max-height: 300px;
            object-fit: contain;
            margin-bottom: 30px;
        }

        .login-left h2 {
            font-size: 28px;
            margin-bottom: 15px;
        }

        .login-left p {
            font-size: 15px;
            opacity: 0.9;
        }

        .login-right {
            flex: 1;
            padding: 50px 40px;
        }

        .form-control {
            border-radius: 10px;
            margin-bottom: 5px;
            height: 45px;
        }

        .btn-login {
            width: 100%;
            background-color: #1e88e5;
            color: white;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            border: none;
            margin-top: 15px;
        }

        .btn-login:hover {
            background-color: #1565c0;
        }

        .footer-text {
            font-size: 0.8rem;
            color: #888;
            text-align: center;
            margin-top: 20px;
        }

        .validator {
            color: red;
            font-size: 0.85rem;
            margin-bottom: 10px;
            display: block;
        }

        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
                border-radius: 0;
                height: 100vh;
            }

            .login-left,
            .login-right {
                flex: none;
                width: 100%;
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">
            <!-- Partie gauche -->
            <div class="login-left">
                <img src="image.png" alt="Logo Prospect Manager" />
                <h2>Welcome to <strong>PROSPECT MANAGER</strong></h2>
                <p>Your business lead companion. Securely update your access and get started now.</p>
                <div class="mt-5">
                    <span style="font-size: 0.75rem;">PROSPECT MANAGER PLATFORM</span>
                </div>
            </div>

            <!-- Partie droite -->
            <div class="login-right">
                <h4 class="mb-4">UPDATE YOUR TEMPORARY PASSWORD</h4>

                <asp:TextBox ID="txtIdentifiant" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="RequiredIdentifiant" 
                    runat="server" 
                    ControlToValidate="txtIdentifiant" 
                    ErrorMessage="Ce champ doit être rempli" 
                    Display="Dynamic" 
                    CssClass="validator" />

                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="New Password" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="RequiredPass" 
                    runat="server" 
                    ControlToValidate="txtPassword" 
                    ErrorMessage="Ce champ doit être rempli" 
                    Display="Dynamic" 
                    CssClass="validator" />

                <asp:RegularExpressionValidator 
                    ID="RegexPassword" 
                    runat="server" 
                    ControlToValidate="txtPassword" 
                    Display="Dynamic" 
                    ErrorMessage="Le mot de passe doit contenir :<br/>
                    - 1 majuscule<br/>
                    - 1 minuscule<br/>
                    - 1 chiffre<br/>
                    - 1 caractère spécial<br/>
                    - entre 8 et 16 caractères"
                    CssClass="validator"
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,16}$" />

                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" placeholder="Confirm New Password" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator 
                    ID="RequiredConfirmPass" 
                    runat="server" 
                    ControlToValidate="txtConfirmPassword" 
                    ErrorMessage="Ce champ doit être rempli" 
                    Display="Dynamic" 
                    CssClass="validator" />

                <asp:CompareValidator 
                    ID="cvPasswords" 
                    runat="server" 
                    ControlToCompare="txtPassword" 
                    ControlToValidate="txtConfirmPassword" 
                    Display="Dynamic" 
                    ErrorMessage="Les mots de passe ne correspondent pas." 
                    CssClass="validator" />

<asp:Button ID="btnValider" runat="server" CssClass="btn btn-login" Text="Save Password" OnClick="btnValider_Click" />

                <div class="footer-text">
                    Need help? Contact your administrator.
                </div>
            </div>
        </div>
    </form>
</body>
</html>
