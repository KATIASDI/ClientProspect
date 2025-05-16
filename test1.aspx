﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test1.aspx.cs" Inherits="WebRedaTest.test1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Housing Bank Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --beige: #C6B18D;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.8);
        }
        @keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}


        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
            min-height: 100vh;
            overflow-x: hidden;
            color: var(--text-color);
        }

        .sidebar {
            background: var(--primary);
            min-height: 100vh;
            padding: 1rem;
            color: white;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

            .sidebar a {
                color: white;
                text-decoration: none;
                margin-bottom: 1.2rem;
                display: block;
                font-weight: 600;
            }

                .sidebar a:hover {
                    text-decoration: underline;
                }

        .card-custom {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: none;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            margin-bottom: 20px;
        }

        .small-card {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 16px;
            padding: 1rem;
            text-align: center;
            color: white;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s;
        }

            .small-card:hover {
                transform: translateY(-5px);
            }

        .chart-container {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 1.5rem;
            backdrop-filter: blur(10px);
        }

        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1040;
            }

                .sidebar.active {
                    transform: translateX(0);
                }

            .col-md-10 {
                margin-left: 0 !important;
            }
        }

        .logo-img {
            max-width: 80%;
            height: auto;
            opacity: 0.95;
            mix-blend-mode: normal;
            filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.2));
            transition: all 0.3s ease-in-out;
        }

        .sidebar {
            background-color: #003e7e;
        }

        .grid-table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

            .grid-table th, .grid-table td {
                padding: 15px;
                text-align: center;
                border: 1px solid #ddd;
            }

            .grid-table th {
                background-color: #00529B;
                color: white;
                font-weight: bold;
            }

            .grid-table td {
                background-color: #f9f9f9;
            }

            .grid-table tr:hover {
                background-color: #f1f1f1;
            }

        .grid-actions {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container-fluid">
            <div class="row">
                <button class="btn d-md-none" id="toggleSidebar" style="position: absolute; top: 1rem; left: 1rem; z-index: 1050;">
                    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
                    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
                    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
                </button>
                <div class="col-md-2 sidebar d-flex flex-column">
                    <div class="text-center mb-4">
                        <img src="Logo1m.png" alt="Housing Bank Logo" class="img-fluid logo-img">
                    </div>

                    <a id="linkDashboard" runat="server" href="Dashboard.aspx"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                    <a id="linkManageUsers" runat="server" href="Admin.aspx"><i class="bi bi-person-badge-fill me-2"></i>Manage Users</a>
                    <a id="linkAddUser" runat="server" href="AjoutUser.aspx"><i class="bi bi-person-plus-fill me-2"></i>Add New User</a>
                    <a id="linkRolesPermissions" runat="server" href="RolesetPermissions.aspx"><i class="bi bi-key-fill me-2"></i>Roles & Permissions</a>
                    <a id="linkHistory" runat="server" href="History.aspx"><i class="bi bi-clock-history me-2"></i>User History</a>
                    <a id="linkSettings" runat="server" href="Settings.aspx"><i class="bi bi-gear-wide-connected me-2"></i>Settings</a>
                    <a id="linkAddProspect" runat="server" href="AjoutClient.aspx"><i class="bi bi-person-lines-fill me-2"></i>Add New Prospect</a>
                    <a id="linkViewProspect" runat="server" href="ViewProspect.aspx"><i class="bi bi-list-check me-2"></i>View Prospect</a>
                    <a id="linkVote" runat="server" href="Vote.aspx"><i class="bi bi-check2-circle me-2"></i>Cast Your Vote</a>
                    <a id="linkViewVote" runat="server" href="ViewVote.aspx"><i class="bi bi-card-checklist me-2"></i>View Vote</a>
                    <a id="linkPlanningVisite" runat="server" href="PlanningVisite.aspx"><i class="bi bi-calendar-check me-2"></i>Schedule Visit</a>
                    <a id="linkDecision" runat="server" href="Decision.aspx"><i class="bi bi-file-earmark-check me-2"></i>Final Decision</a>

                </div>
                <div class="col-md-10 p-4">
                    <div class="card-custom mb-4 text-center">
                        <h2>Tableau de Prospect</h2>
                        <asp:Literal ID="LiteralMessage" runat="server" />
                    </div>
                    <asp:GridView ID="GridViewProspects" runat="server" AutoGenerateColumns="False"
                        CssClass="grid-table" OnRowCommand="GridViewProspects_RowCommand"
                        DataKeyNames="STATUS">
                        <Columns>
                            <asp:BoundField DataField="NOM" HeaderText="Nom" />
                            <asp:BoundField DataField="NUMTEL" HeaderText="Téléphone" />
                            <asp:BoundField DataField="EMAIL" HeaderText="Email" />
                            <asp:BoundField DataField="ADRESSE" HeaderText="Adresse" />
                            <asp:BoundField DataField="STATUS" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Fiche Prospect">
                                <ItemTemplate>
                                    <asp:Button ID="btnDetails" runat="server"
                                        Text="Voir détails"
                                        CommandName="Details"
                                        CommandArgument='<%# Eval("ID_PROSPECT") %>'
                                        CssClass="btn btn-info btn-sm" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Literal ID="LiteralAction" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
           <ContentTemplate>
    <div class="modal fade" id="detailsModal" tabindex="-1" aria-labelledby="detailsLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content shadow-lg rounded-4 border-0" style="animation: fadeInUp 0.4s ease-in-out;">
                <div class="modal-header text-white rounded-top-4"  style="background-color: #003e7e;">
                    <h5 class="modal-title fw-bold" id="detailsLabel">Détails du prospect</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4" style="font-family: 'Segoe UI', sans-serif;">
                    <asp:Label ID="lblDetails" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    </div>
</ContentTemplate>

        </asp:UpdatePanel>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('toggleSidebar')?.addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('active');
        });

        function openModal() {
            try {
                var modalElement = document.getElementById('detailsModal');
                if (modalElement) {
                    var myModal = new bootstrap.Modal(modalElement);
                    myModal.show();
                    console.log('Modal ouvert avec succès');
                } else {
                    console.error('Modal non trouvé dans le DOM');
                }
            } catch (e) {
                console.error('Erreur lors de l\'ouverture du modal : ', e);
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var shouldOpenModal = document.getElementById('shouldOpenModal');
            if (shouldOpenModal && shouldOpenModal.value === 'true') {
                openModal();
            }
        });
    </script>
</body>
</html>