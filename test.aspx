<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="TonNamespace.test" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Liste des Utilisateurs</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvUtilisateurs" runat="server" AutoGenerateColumns="true"></asp:GridView>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </form>
</body>
</html>
