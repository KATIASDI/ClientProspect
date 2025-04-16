<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DirComm.aspx.cs" Inherits="PROJETFIN1.DirComm" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Direction Commerciale - Prospects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f2f2f2;
            color: #2c3e50;
            font-family: 'Segoe UI', sans-serif;
        }

        .table th {
            background-color: #34495e;
            color: white;
        }

        .btn-action {
            background-color: #f1c40f;
            border: none;
            color: #2c3e50;
        }

        .btn-action:hover {
            background-color: #d4ac0d;
        }

        #ficheOverlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(4px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        #ficheCard {
            background: white;
            padding: 30px;
            border-radius: 12px;
            width: 600px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        .close-btn {
            float: right;
            font-size: 20px;
            cursor: pointer;
        }

        .fiche-label {
            font-weight: bold;
        }

        .fiche-value {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container mt-4">
        <h2 class="mb-4 text-center text-primary">Liste des Prospects par Agence</h2>

        <asp:GridView ID="gvProspects" runat="server" CssClass="table table-striped table-bordered"
            AutoGenerateSelectButton="True" OnSelectedIndexChanged="gvProspects_SelectedIndexChanged">
        </asp:GridView>

        <div id="ficheOverlay" runat="server">
            <div id="ficheCard">
                <span class="close-btn" onclick="document.getElementById('ficheOverlay').style.display='none'">&times;</span>
                <h4 class="mb-3 text-primary">Fiche Prospect</h4>

                <div class="fiche-value"><span class="fiche-label">Nom :</span> <asp:Label ID="lblNom" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Capital :</span> <asp:Label ID="lblCapital" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Activité principale :</span> <asp:Label ID="lblActivite" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Dirigeant :</span> <asp:Label ID="lblDirigeant" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Nombre d'employés :</span> <asp:Label ID="lblEmployes" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Adresse :</span> <asp:Label ID="lblAdresse" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Besoins :</span> <asp:Label ID="lblBesoins" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Type de rencontre :</span> <asp:Label ID="lblRencontre" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Canal d'acquisition :</span> <asp:Label ID="lblCanal" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Interdit de chéquier :</span> <asp:Label ID="lblInterditChequier" runat="server" /></div>
                <div class="fiche-value"><span class="fiche-label">Blacklisté :</span> <asp:Label ID="lblBlacklist" runat="server" /></div>

                <asp:Button ID="btnInfos" runat="server" Text="Demander des Informations Complémentaires" CssClass="btn btn-action mt-3" OnClick="btnInfos_Click" />
                <asp:Button ID="btnComite" runat="server" Text="Soumettre au Comité Crédit" CssClass="btn btn-primary mt-3 ms-2" OnClick="btnComite_Click" />
            </div>
        </div>
    </form>
</body>
</html>
