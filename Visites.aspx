<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visites.aspx.cs" Inherits="DashboardChargeAffaire.Visites" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Gestion des Visites</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
        }

        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: white;
            position: fixed;
            height: 100vh;
            padding-top: 30px;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .main-content {
            margin-left: 270px;
            padding: 20px;
        }

        .navbar {
            background-color: #343a40;
            height: 70px;
            padding: 0;
        }

        .navbar-brand {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100%;
        }

        .navbar-brand img {
            height: 100%;
            width: auto;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .pdf-link {
            color: #dc3545;
            text-decoration: underline;
        }

        .action-btn {
            margin-top: 10px;
        }
    </style>
</head>
<body class="bg-light">
    <form id="form1" runat="server">

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="text-center mb-4">
                <img src="logo.png" alt="Logo Housing Bank" style="max-width: 100%; height: auto; padding: 0 15px;" />
            </div>
            <h4 class="text-center">📊 Dashboard Chargé d'affaires</h4>
            <a href="AjoutClient.aspx">➕ Proposer Client</a>
            <a href="AjoutFormVisite.aspx">📝 Formulaire Visite</a>
            <a href="Visites.aspx">📅 Gestion des Visites</a>
        </div>

        <!-- Contenu principal -->
        <div class="main-content">
            <h2 class="mb-4 text-primary">Gestion des Visites</h2>

            <!-- Planning visite -->
            <div class="form-section card shadow p-4 mb-4">
                <h5 class="mb-3">🗓️ Planifier une nouvelle visite</h5>
                
                <div class="row">
                    <div class="col-md-4">
                        <label class="form-label">Client prospect</label>
                        <asp:DropDownList ID="ddlProspect" runat="server" CssClass="form-select" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Date de visite</label>
                        <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Heure</label>
                        <asp:TextBox ID="txtHeure" runat="server" CssClass="form-control" TextMode="Time" />
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-8">
                        <label class="form-label">Lieu</label>
                        <asp:TextBox ID="txtLieu" runat="server" CssClass="form-control" />
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <asp:Button ID="btnPlanifier" runat="server" CssClass="btn btn-success w-100" Text="Planifier la visite" OnClick="btnPlanifier_Click" />
                    </div>
                </div>
                <asp:Label ID="lblMessage" runat="server" CssClass="text-success mt-3 d-block" />
            </div>

            <!-- Calendrier -->
            <div class="card shadow p-4 mb-4">
                <h5 class="mb-3">📆 Calendrier des visites</h5>
                <div id="calendar"></div>
            </div>

            <!-- Compte rendu de visites -->
            <div class="card shadow p-4">
                <h5 class="mb-3">📝 Comptes rendus de visite</h5>
                <table class="table table-bordered table-striped">
                    <thead class="table-light">
                        <tr>
                            <th>Client</th>
                            <th>Date Visite</th>
                            <th>PDF Compte rendu</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Sonatrach</td>
                            <td>2025-04-15</td>
                            <td><a href="ComptesRendus/Sonatrach.pdf" target="_blank" class="pdf-link">Voir le PDF</a></td>
                            <td><button class="btn btn-primary btn-sm">Transmettre à la Direction Commerciale</button></td>
                        </tr>
                        <tr>
                            <td>Cosider</td>
                            <td>2025-04-18</td>
                            <td><a href="ComptesRendus/Cosider.pdf" target="_blank" class="pdf-link">Voir le PDF</a></td>
                            <td><button class="btn btn-primary btn-sm">Transmettre à la Direction Commerciale</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </form>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'fr',
                events: [
                    {
                        title: 'Visite - Sonatrach',
                        start: '2025-04-15'
                    },
                    {
                        title: 'Visite - Cosider',
                        start: '2025-04-18'
                    }
                ]
            });
            calendar.render();
        });
    </script>
</body>
</html>
