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



        <!-- Main Content -->
        <div class="col-md-10 p-4">
            <div class="row mb-4">
                <div class="col-md-3 small-card">
                    <h6>Today's Deposits</h6>
                    <h4>$120,000 <span class="text-success">+8%</span></h4>
                </div>
                <div class="col-md-3 small-card" style="background: linear-gradient(135deg, var(--secondary), var(--accent));">
                    <h6>New Accounts</h6>
                    <h4>45 <span class="text-success">+3%</span></h4>
                </div>
                <div class="col-md-3 small-card">
                    <h6>Loan Applications</h6>
                    <h4>25 <span class="text-warning">~</span></h4>
                </div>
                <div class="col-md-3 small-card" style="background: linear-gradient(135deg, var(--secondary), var(--accent));">
                    <h6>Total Clients</h6>
                    <h4>3,200 <span class="text-success">+5%</span></h4>
                </div>
            </div>

            <!-- Welcome Card -->
            <div class="card-custom mb-4 text-center">
                <h2>Welcome back, Chargé d'affaires 👋</h2>
                <p>Here is the latest overview of the bank's performance.</p>
            </div>

            <!-- Graphs -->
            <div class="row">
                <div class="col-md-8 chart-container">
                    <h5>Monthly Transactions</h5>
                    <canvas id="transactionsChart"></canvas>
                </div>
                <div class="col-md-4 chart-container">
                    <h5>Active Loans</h5>
                    <canvas id="loansChart"></canvas>
                </div>
            </div>

            <!-- Clients & Operations -->
            <div class="row mt-4">
                <div class="col-md-8">
                    <div class="card-custom">
                        <h5>Recent Client Activities</h5>
                        <table class="table table-hover mt-3 rounded bg-light">
                            <thead class="table-light">
                                <tr>
                                    <th>Client</th>
                                    <th>Account</th>
                                    <th>Action</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>Ahmed B.</td><td>Savings</td><td>Deposit</td><td>27 Apr 2025</td></tr>
                                <tr><td>Sara D.</td><td>Current</td><td>Withdrawal</td><td>27 Apr 2025</td></tr>
                                <tr><td>Mohamed K.</td><td>Loan</td><td>Application</td><td>26 Apr 2025</td></tr>
                                <tr><td>Lina Z.</td><td>Savings</td><td>Deposit</td><td>26 Apr 2025</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card-custom">
                        <h5>Summary</h5>
                        <ul class="list-group mt-3">
                            <li class="list-group-item bg-transparent border-0 text-dark">✔️ 10 New Deposits</li>
                            <li class="list-group-item bg-transparent border-0 text-dark">📝 5 Loan Applications</li>
                            <li class="list-group-item bg-transparent border-0 text-dark">📈 Account Growth +5%</li>
                            <li class="list-group-item bg-transparent border-0 text-dark">🛒 2 New Business Accounts</li>
                        </ul>
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
                label: 'Transactions',
                data: [300, 400, 350, 500, 450, 480, 530],
                backgroundColor: 'rgba(0, 123, 255, 0.2)',
                borderColor: '#00529B',
                borderWidth: 3,
                tension: 0.5,
                fill: true,
            }]
        }
    });

    var ctx2 = document.getElementById('loansChart').getContext('2d');
    var loansChart = new Chart(ctx2, {
        type: 'bar',
        data: {
            labels: ['Home', 'Car', 'Business', 'Personal'],
            datasets: [{
                label: 'Loans',
                data: [30, 20, 15, 10],
                backgroundColor: '#007BFF'
            }]
        }
    });
</script>
    <script>
        document.getElementById('toggleSidebar').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('active');
        });
    </script>

</body>
</html>
