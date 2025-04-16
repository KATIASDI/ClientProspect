<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjoutUser.aspx.cs" Inherits="PROJETFIN1.AjoutUser" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Ajout Utilisateur</title>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px gray;
            width: 400px;
            text-align: center;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .input-field, .dropdown-field {
            width: 100%;
            margin: 10px 0;
            padding: 12px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            box-sizing: border-box;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            border-radius: 5px;
            border: none;
            background: #2ecc71;
            color: white;
            font-size: 16px;
            cursor: pointer;
            box-sizing: border-box;
        }
        .btn-submit:hover {
            background: #27ae60;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Ajout Utilisateur</h2>
            
            <asp:TextBox ID="txtNom" runat="server" placeholder="Ex: Nom Prénom" CssClass="input-field"></asp:TextBox>
            
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Ex: Nom.Prénom@gmail.com" CssClass="input-field"></asp:TextBox>
            <asp:Label ID="lblEmailError" runat="server" ForeColor="Red" Visible="false"></asp:Label>

            <asp:TextBox ID="txtIdentifiant" runat="server" placeholder="Ex: NomPrenom123_" CssClass="input-field"></asp:TextBox>

            <asp:DropDownList ID="ddlRole" runat="server" CssClass="dropdown-field">
                <asp:ListItem Value="">Sélectionner un rôle</asp:ListItem>
                <asp:ListItem Value="ADMINISTRATEUR">ADMINISTRATEUR</asp:ListItem>
                <asp:ListItem Value="Chargé d'affaire">Chargé d'affaire</asp:ListItem>
                <asp:ListItem Value="Direction d'agence">Direction d'agence</asp:ListItem>
                <asp:ListItem Value="Comité crédit">Comité crédit</asp:ListItem>
                <asp:ListItem Value="Direction commercial">Direction commercial</asp:ListItem>
            </asp:DropDownList>

            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Ex: Min. 8 caractères, 1 majuscule, 1 chiffre,1 minuscule, 1 symbole" CssClass="input-field"></asp:TextBox>

            <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer" OnClick="btnEnregistrer_Click" CssClass="btn-submit" />
        </div>
    </form>

</body>
</html>
