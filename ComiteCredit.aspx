<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComiteCredit.aspx.cs" Inherits="PROJETFIN1.ComiteCredit" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Comité Crédit</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <style>
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --text-color: #333;
            --card-bg: #fff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
            min-height: 100vh;
            overflow-x: hidden;
        }

        .sidebar {
            background-color: #003e7e;
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

        .logo-img {
            max-width: 80%;
            height: auto;
            opacity: 0.95;
        }

        .content-container {
            padding: 2rem;
        }

        .card {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .btn-submit {
            background: var(--primary);
            color: white;
            font-weight: 600;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
        }

        .btn-submit:hover {
            background: #003060;
        }

        .progress-bar {
            background-color: var(--primary);
        }

        .form-check-label {
            font-weight: 500;
        }

        .comment-box {
            display: none;
        }

        .comment-box.active {
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2 sidebar d-flex flex-column">
                    <div class="text-center mb-4">
                        <img src="Logo1m.png" alt="Housing Bank Logo" class="img-fluid logo-img" />
                    </div>
                    <a href="Dashboard.aspx"><i class="bi bi-house-door-fill me-2"></i>Dashboard</a>
                    <a href="Admin.aspx"><i class="bi bi-people-fill me-2"></i>Manage Users</a>
                    <a href="#"><i class="bi bi-folder2-open me-2"></i>View Prospects</a>
                    <a href="#"><i class="bi bi-bar-chart-line-fill me-2"></i>Reports</a>
                    <a href="#"><i class="bi bi-clock-history me-2"></i>User History</a>
                    <a href="#"><i class="bi bi-gear-fill me-2"></i>Settings</a>
                </div>

                <!-- Main Content -->
                <div class="col-md-10 content-container">
                    <h2 class="mb-4" style="color: var(--primary);">Comité Crédit - Consultation et Avis</h2>

                    <!-- Liste des prospects -->
                    <div class="card">
                        <h5 class="card-title">Liste des Prospects</h5>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Prospect 1
                                <a href="FicheClient.aspx?id=1" class="btn btn-link">Voir Fiche</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Prospect 2
                                <a href="FicheClient.aspx?id=2" class="btn btn-link">Voir Fiche</a>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Prospect 3
                                <a href="FicheClient.aspx?id=3" class="btn btn-link">Voir Fiche</a>
                            </li>
                        </ul>
                    </div>

                    <!-- Options d'avis -->
                    <div class="card">
                        <h5 class="card-title">Donner votre Avis</h5>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="avis" id="avisFavorable" value="favorable">
                            <label class="form-check-label" for="avisFavorable">Avis Favorable</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="avis" id="avisDefavorable" value="defavorable">
                            <label class="form-check-label" for="avisDefavorable">Avis Défavorable</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="avis" id="avisReexaminer" value="reexaminer">
                            <label class="form-check-label" for="avisReexaminer">Avis à Réexaminer</label>
                        </div>
                        <textarea id="commentaire" class="form-control comment-box mt-3" placeholder="Ajouter un commentaire..." rows="3"></textarea>
                    </div>

                    <!-- Bouton Soumettre -->
                    <div class="text-end">
                        <button type="button" class="btn btn-submit">Soumettre Avis</button>
                    </div>

                    <!-- Indicateur de progression -->
                    <div class="card mt-4">
                        <h5 class="card-title">Progression des Avis</h5>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">50%</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Gestion de l'affichage de la zone de commentaire
        document.querySelectorAll('input[name="avis"]').forEach(radio => {
            radio.addEventListener('change', function () {
                const commentBox = document.getElementById('commentaire');
                if (this.value === 'defavorable' || this.value === 'reexaminer') {
                    commentBox.classList.add('active');
                } else {
                    commentBox.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>
