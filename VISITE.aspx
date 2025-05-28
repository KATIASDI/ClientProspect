<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VISITE.aspx.cs" Inherits="TonProjet.VISITE" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Liste des Visites</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="mb-4 text-primary">Liste des Visites</h2>
            <asp:GridView ID="GridViewVisites" runat="server" CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="False" DataKeyNames="ID_VISITE">
                <Columns>
                    <asp:BoundField DataField="ID_VISITE" HeaderText="ID Visite" />
                    <asp:BoundField DataField="ID_PROSPECT" HeaderText="ID Prospect" />
                    <asp:BoundField DataField="ID_USER" HeaderText="ID Utilisateur" />
                    <asp:BoundField DataField="DATE_VISITE" HeaderText="Date de Visite" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="EXTENSION" HeaderText="Extension" />
                    <asp:BoundField DataField="CRV_TMP" HeaderText="Compte Rendu Visite" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
