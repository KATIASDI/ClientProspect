<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PROJETFIN1.Dashboard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Housing Bank Dashboard</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">


    <style>
        :root {
            --primary: #00529B; /* Bleu foncé */
            --secondary: #007BFF; /* Bleu normal */
            --accent: #D4E6F1; /* Bleu clair */
            --background: #F7F9FB; /* Gris très clair */
            --beige: #C6B18D;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.8);
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
    background-color: #003e7e; /* fond identique au logo pour intégration */
}



    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        
        <!-- Bouton Hamburger -->
<button class="btn d-md-none" id="toggleSidebar" style="position: absolute; top: 1rem; left: 1rem; z-index: 1050;">
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
</button>
                <!-- Sidebar -->


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
<a id="linkViewProspect" runat="server" href="Process.aspx"><i class="bi bi-list-check me-2"></i>View Prospect</a>
<a id="linkVote" runat="server" href="Vote.aspx"><i class="bi bi-check2-circle me-2"></i>Cast Your Vote</a>
<a id="linkViewVote" runat="server" href="ViewVote.aspx"><i class="bi bi-card-checklist me-2"></i>View Vote</a>
<a id="linkPlanningVisite" runat="server" href="PlanningVisite.aspx"><i class="bi bi-calendar-check me-2"></i>Schedule Visit</a>
<a id="linkDecision" runat="server" href="Decision.aspx"><i class="bi bi-file-earmark-check me-2"></i>Final Decision</a>

<div class="mt-auto p-3">
    <a href="Login.aspx" class="btn btn-outline-danger w-100 d-flex align-items-center justify-content-center">
        <i class="bi bi-box-arrow-right me-2"></i> Déconnexion
    </a>
</div>


</div>



<!-- Main Content -->
<div class="col-md-10 p-4">
    <div class="row mb-4">
       <div class="col-md-3 small-card">
    <h6>Nombre de visites</h6>
    <h4><asp:Label ID="lblNombreVisites" runat="server"  /></h4>
</div>
        <div class="col-md-3 small-card" style="background: linear-gradient(135deg, var(--secondary), var(--accent));">
            <h6>Nombre d'utilisateurs</h6>
            <h4>
                <asp:Label ID="lblUsersCount" runat="server" Text="0"></asp:Label>
                <span class="text-success"></span>
            </h4>
        </div>
       <div class="col-md-3 small-card">
    <h6>Clients acceptés</h6>
    <h4><%= AcceptedCount %> <span class="text-warning"></span></h4>
</div>

        <div class="col-md-3 small-card" style="background: linear-gradient(135deg, var(--secondary), var(--accent));">
            <h6>Nombre de prospects</h6>
            <h4>
                <asp:Label ID="lblProspectsCount" runat="server" Text="0"></asp:Label>
                <span class="text-success"></span>
            </h4>
        </div>
    </div>



            <!-- Welcome Card -->
<!-- Welcome Card -->
<div class="card-custom mb-4 text-center">
    <h2>Welcome back, <%= Session["Username"] ?? "User" %> 👋</h2>
    <p>Here is the latest overview of the bank's performance.</p>
</div>





            <!-- Graphs -->
            <div class="row">
                <div class="col-md-8 chart-container">
                    <h5>Prospection mensuelle </h5>
                    <canvas id="transactionsChart"></canvas>
                </div>
                <div class="col-md-4 chart-container">
    <h5>Dossiers Acceptés</h5>
    <canvas id="loansChart"></canvas>
</div>


            <!-- Clients & Operations -->
            <div class="row mt-4">
                <div class="col-md-8">
                    <div class="card-custom">
                        <h5>Dossiers prospects en cours </h5>
                        <form id="form1" runat="server">

<asp:GridView ID="GridViewRecentClients" runat="server" AutoGenerateColumns="false" CssClass="table table-hover mt-3 rounded bg-light" OnRowDataBound="GridViewRecentClients_RowDataBound">
    <Columns>
        <asp:BoundField DataField="NOM" HeaderText="Client" />
        <asp:BoundField DataField="EMAIL" HeaderText="Email" />
        <asp:TemplateField HeaderText="State">
            <ItemTemplate>
                <asp:Label ID="lblState" runat="server" Text='<%# Eval("STATE") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

                  </form>
                    </div>
                </div>
<div class="col-md-4">
    <div class="card card-custom mt-4">
        <div class="card-body">
            <h5 class="card-title">Détails des acteurs</h5>
            <ul class="list-group mt-3">
                <asp:Repeater ID="RepeaterRoles" runat="server">
                    <ItemTemplate>
                        <li class="list-group-item bg-transparent border-0 text-dark">
                            <%# GetIcon(Eval("Role").ToString()) %> <%# Eval("Count") %> <%# GetLabel(Eval("Role").ToString()) %>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
        </div>
    </div>
</div>
            </div>

        </div>
    </div>
</div>


<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    var ctx1 = document.getElementById('transactionsChart').getContext('2d');
    var transactionsChart = new Chart(ctx1, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
            datasets: [{
                label: 'Prospecting',
                data: [1, 2, 3, 5, 6, 7, 8],
                backgroundColor: 'rgba(0, 123, 255, 0.2)',
                borderColor: '#00529B',
                borderWidth: 3,
                tension: 0.5,
                fill: true,
            }]
        }
    });
    e = "text/javascript" >
        document.addEventListener("DOMContentLoaded", function () {
            var accepted = <%= AcceptedCount %>;
        var total = <%= TotalCount %>;
        var rejected = total - accepted;

        var ctx = document.getElementById('loansChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Acceptés', 'Autres'],
                datasets: [{
                    data: [accepted, rejected],
                    backgroundColor: [
                        '#4FD1C5', // Validés - bleu turquoise
                        '#F66D9B', // Refusés - rose framboise
                        '#68D391', // En cours - vert menthe
                        '#F6E05E', // En attente de vote - jaune clair
                        '#C6F6D5'  // Info complémentaire - vert très pâle
                    ],
                    hoverBackgroundColor: [
                        '#38B2AC',
                        '#E53E6B',
                        '#48BB78',
                        '#ECC94B',
                        '#9AE6B4'
                    ],
                    borderColor: '#FFFFFF',
                    borderWidth: 2,
                    cutout: '70%'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    },
                    title: {
                        display: true,
                        text: 'Traitement des dossiers '
                    }
                }
            }
        });
    });
</script>


    <script>
        document.getElementById('toggleSidebar').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('active');
        });
    </script>
    </div>
</body>
</html>
