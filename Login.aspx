<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="YourNamespace.Login" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion</title>
    <style>
        body {
            background: url('LOGIN.png') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
    width: 450px;
    padding: 40px;
    background: rgba(255, 255, 255, 0.7); /* Transparence douce */
    backdrop-filter: blur(8px); /* Ajoute un effet de flou élégant */
    -webkit-backdrop-filter: blur(8px); /* Compatibilité Safari */
    border-radius: 10px;
    box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.3);
    text-align: center;
}

       .textbox, .btn {
    width: 100%; /* Alignement parfait */
    padding: 12px;
    margin-bottom: 20px;
    font-size: 16px;
    border: 1px solid #ccc; /* Ajout d'une bordure pour uniformiser */
    border-radius: 5px;
    box-sizing: border-box; /* Évite que le padding casse l'alignement */
}

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            font-size: 18px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <asp:Image ID="imgLogo" runat="server" ImageUrl="Logo.png" Width="150px" />
            <h1>Prospect Manager</h1>
            <h2>Connexion</h2>
            
            <asp:TextBox ID="txtUsername" runat="server" CssClass="textbox" Placeholder="Identifiant"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="textbox" Placeholder="Mot de passe" TextMode="Password"></asp:TextBox>
            <asp:TextBox ID="hashedPassword" runat="server" TextMode="SingleLine" Placeholder="HashedPassword" Style="display:none;" />


            <asp:Button ID="btnLogin" runat="server" Text="Se connecter" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <asp:Label ID="lblHash" runat="server" ForeColor="Gray"></asp:Label>
            <asp:Label ID="lblHashedPassword" runat="server" ForeColor="Gray" Font-Size="Small" />

        </div>
    </form>
</body>
</html>
