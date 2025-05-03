<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChargeAff.aspx.cs" Inherits="PROJETFIN1.ChargeAff" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard Chargé d'Affaires</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        .sidebar {
            width: 240px;
            background: linear-gradient(180deg, #4b6cb7, #182848);
            color: white;
            position: fixed;
            height: 100vh;
            padding: 20px 15px;
        }

        .sidebar img {
            width: 150px;
            margin: 0 auto 30px;
            display: block;
        }

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 12px;
            display: block;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: background 0.2s ease-in-out;
        }

        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .main-content {
            margin-left: 260px;
            padding: 30px;
        }

        .card-metric {
            border-radius: 15px;
            color: white;
            padding: 20px;
            transition: transform 0.2s ease;
        }

        .card-metric:hover {
            transform: scale(1.02);
        }

        .card-metric h5 {
            font-weight: 500;
        }

        .sidebar.collapsed {
            width: 70px;
        }

        .sidebar.collapsed a {
            text-align: center;
            font-size: 0;
        }

        .sidebar.collapsed a i {
            font-size: 18px;
        }

        .sidebar img {
            width: 100%;
            height: auto;
            display: block;
            margin: 0;
            padding: 0;
            object-fit: cover;
            border-radius: 0;
        }

        .sidebar.collapsed img {
            width: 40px;
            margin: 0 auto 20px;
        }

        .main-content {
            margin-left: 260px;
            transition: margin-left 0.3s ease;
        }

        .sidebar.collapsed + .main-content {
            margin-left: 90px;
        }

        .chart-placeholder {
            height: 300px;
            background: #e6ecf3;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .table thead {
            background-color: #f1f3f5;
        }

        .progress-bar {
            border-radius: 12px;
        }

        .toggle-btn {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
            margin-bottom: 20px;
            margin-left: 5px;
        }

        .logout-btn {
            margin-top: 30px;
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            text-align: center;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c82333;
        }

        .logout-btn i {
            margin-right: 10px;
        }

    </style>
</head>
<body>

    <div class="sidebar">
        <div class="logo-container">
            <img src="logo.png" alt="Logo Housing Bank" />
        </div>
        <button id="toggleSidebar" class="toggle-btn">
            <i class="fas fa-bars"></i>
        </button>

        <a href="AjoutClient.aspx"><i class="fas fa-user-plus me-2"></i> Proposer Client</a>
        <a href="PlanningVisite.aspx"><i class="fas fa-calendar-check me-2"></i> Consulter Planning Visite</a>
        <a href="AjoutFormVisite.aspx"><i class="fas fa-edit me-2"></i> Formulaire Visite</a>

        <!-- Bouton de déconnexion -->
        <a href="Login.aspx" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Se Déconnecter
        </a>
    </div>

    <div class="main-content">
        <h3 class="mb-4 fw-semibold text-dark">Dashboard Chargé d'affaires</h3>

        <!-- Statistiques -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card-metric bg-primary">
                    <h5>👤 Clients</h5>
                    <h3>120</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card-metric bg-info">
                    <h5>📊 Projets</h5>
                    <h3>45</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card-metric" style= "background-color:#8f539a;color: white; ">
                    <h5>📨 Messages</h5>
                    <h3>68</h3>
                </div>
            </div>
            <div class="col-md-3">
<div class="card-metric" style="background-color: #ff00af53; color: white;">
                    <h5>📋 Dossiers</h5>
                    <h3>20</h3>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <!-- Progression client -->
            <div class="col-md-6">
                <div class="card shadow p-3">
                    <h6 class="text-primary mb-2">Progression du processus client</h6>
                    <div style="height: 220px;">
                        <canvas id="progressionChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- État des prospects -->
            <div class="col-md-6">
                <div class="card shadow p-3">
                    <h6 class="text-primary mb-2">État des prospects</h6>
                    <div style="height: 220px;">
                        <canvas id="prospectsPieChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="chart-placeholder">
            📊 Graphique de progression à intégrer ici (Chart.js / ASP.NET)
        </div>

        <!-- Tableau de dossiers -->
        <div class="card shadow p-4">
            <h5 class="text-primary mb-3">Dossiers en cours</h5>
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Statut</th>
                        <th>Progression</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptClients" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("Nom") %></td>
                                <td><%# Eval("Statut") %></td>
                                <td>
                                    <div class="progress" style="height: 20px;">
                                        <div class="progress-bar <%# GetProgressBarClass(Convert.ToInt32(Eval("Progression"))) %>" 
                                             role="progressbar"
                                             style="width: <%# Eval("Progression") %>%;" 
                                             aria-valuenow="<%# Eval("Progression") %>" 
                                             aria-valuemin="0" 
                                             aria-valuemax="100">
                                            <%# Eval("Progression") %>% 
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const toggleBtn = document.getElementById("toggleSidebar");
        const sidebar = document.querySelector(".sidebar");
        const mainContent = document.querySelector(".main-content");

        toggleBtn.addEventListener("click", () => {
            sidebar.classList.toggle("collapsed");
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Progression client
    const ctx = document.getElementById('progressionChart').getContext('2d');
    const progressionChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Prospection', 'Contact', 'RDV', 'Offre', 'Acceptation'],
            datasets: [{
                label: 'Taux (%)',
                data: [100, 80, 60, 40, 20],
                backgroundColor: '#4b6cb7',
                borderRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });

    // Camembert prospects
    const pieCtx = document.getElementById('prospectsPieChart').getContext('2d');
    const prospectsPieChart = new Chart(pieCtx, {
        type: 'doughnut',
        data: {
            labels: ['Clients', 'En cours', 'Rejetés'],
            datasets: [{
                data: [45, 30, 25],
                backgroundColor: ['#198754', '#ffc107', '#dc3545'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        font: {
                            size: 12
                        }
                    }
                }
            }
        }
    });
</script>

</body>
</html>
