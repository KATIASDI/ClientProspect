<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="PROJETFIN1.WebForm1" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Direction Commerciale - Prospects</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.8);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
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
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
        }

        .btn-custom {
            background: var(--secondary);
            color: white;
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 600;
        }

        .btn-custom:hover {
            background: var(--primary);
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="text-center mb-4">
                <img src="Logo1m.png" alt="Logo" class="img-fluid" style="max-width: 80%;">
            </div>
            <a href="Dashboard.aspx"><i class="bi bi-house-door-fill me-2"></i>Dashboard</a>
            <a href="#"><i class="bi bi-folder2-open me-2"></i>View Prospects</a>
            <a href="#"><i class="bi bi-bar-chart-line-fill me-2"></i>Reports</a>
            <a href="#"><i class="bi bi-gear-fill me-2"></i>Settings</a>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4">
            <h2 class="mb-4">Liste des Prospects</h2>
            <div class="card-custom mb-4">
                <h5>Agence: Agence Centrale</h5>
                <table class="table table-hover mt-3">
                    <thead class="table-light">
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Dupont</td>
                            <td>Jean</td>
                            <td>En cours</td>
                            <td>
                                <button class="btn btn-custom me-2">Voir Fiche</button>
                                <button class="btn btn-custom">Demander des Informations</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Martin</td>
                            <td>Claire</td>
                            <td>Validé</td>
                            <td>
                                <button class="btn btn-custom me-2">Voir Fiche</button>
                                <button class="btn btn-custom">Soumettre au Comité Crédit</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="card-custom">
                <h5>Fiche Prospect</h5>
                <p><strong>Nom:</strong> Dupont</p>
                <p><strong>Prénom:</strong> Jean</p>
                <p><strong>Statut:</strong> En cours</p>
                <button class="btn btn-custom me-2">Demander des Informations Complémentaires</button>
                <button class="btn btn-custom">Soumettre au Comité Crédit</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
