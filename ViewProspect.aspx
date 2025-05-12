<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProspect.aspx.cs" Inherits="TonProjet.ViewProspect" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Liste des Prospects</title>

    <!-- Bootstrap et autres styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.9);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
        }

        .sidebar {
            background: #003e7e;
            min-height: 100vh;
            padding: 1rem;
            color: white;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .sidebar a {
            color: white;
            display: block;
            margin-bottom: 1.2rem;
            font-weight: 600;
            text-decoration: none;
        }

        .sidebar a:hover {
            text-decoration: underline;
        }

        .logo-img {
            max-width: 80%;
            height: auto;
            filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.2));
        }

        .table-container {
            background: var(--card-bg);
            padding: 2rem;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            margin-top: 2rem;
        }

        .badge-status {
            font-size: 0.85rem;
            font-weight: 600;
        }

        .action-btn {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
        }

        .action-btn:hover {
            background-color: var(--secondary);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 sidebar">
                    <div class="text-center mb-4">
                        <img src="Logo1m.png" alt="Logo" class="img-fluid logo-img" />
                    </div>
                        <a href="Dashboard.aspx"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
<a href="Admin.aspx"><i class="bi bi-person-badge-fill me-2"></i>Manage Users</a>
<a href="AjoutUser.aspx"><i class="bi bi-person-plus-fill me-2"></i>Add New User</a>
<a href="RolesetPermissions.aspx"><i class="bi bi-key-fill me-2"></i>Roles & Permissions</a>
<a href="History.aspx"><i class="bi bi-clock-history me-2"></i>User History</a>
<a href="Settings.aspx"><i class="bi bi-gear-wide-connected me-2"></i>Settings</a>
<a href="AjoutClient.aspx"><i class="bi bi-person-lines-fill me-2"></i>Add New Prospect</a>
<a href="ViewProspect.aspx"><i class="bi bi-list-check me-2"></i>View Prospect</a>
<a href="Vote.aspx"><i class="bi bi-check2-circle me-2"></i>Cast Your Vote</a>
<a href="ViewVote.aspx"><i class="bi bi-card-checklist me-2"></i>View Vote</a>
<a href="PlanningVisite.aspx"><i class="bi bi-calendar-check me-2"></i>Schedule Visit</a>
<a href="Decision.aspx"><i class="bi bi-file-earmark-check me-2"></i> Final Decision</a>
                </div>

                <!-- Main content -->
                <div class="col-md-10 p-4">
                    <h2 class="mb-4">Liste des Clients Prospects</h2>
                    <div class="table-container">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False" DataKeyNames="ID_PROSPECT" OnRowCommand="GridView1_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="DATE_CREATION" HeaderText="Date" />
                                <asp:BoundField DataField="NOM" HeaderText="Nom" />
                                <asp:BoundField DataField="CAPITAL" HeaderText="Capital" />
                                <asp:BoundField DataField="TELEPHONE" HeaderText="Téléphone" />
                                <asp:BoundField DataField="ADRESSE" HeaderText="Adresse" />

                               <%-- Statut dynamique --%>
<asp:TemplateField HeaderText="Statut">
    <ItemTemplate>
        <span class="badge bg-success badge-status">Vote terminé</span>
    </ItemTemplate>
</asp:TemplateField>


                               <%-- Participation dynamique --%>
<asp:TemplateField HeaderText="Participation">
    <ItemTemplate>
        <span class="badge bg-info badge-status">100%</span>
    </ItemTemplate>
</asp:TemplateField>


                                
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:Button ID="btnVote" runat="server" Text="Voir votes" CssClass="action-btn"
                                            CommandName="VoirVotes" CommandArgument='<%# Eval("ID_PROSPECT") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
