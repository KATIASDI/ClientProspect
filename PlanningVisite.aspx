<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlanningVisite.aspx.cs" Inherits="PROJETFIN1.PlanningVisite" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Planning Visite</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet" />
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
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .sidebar.collapsed {
            width: 70px;
        }

        .sidebar.collapsed a {
            text-align: center;
            font-size: 0;
        }

        .sidebar.collapsed img {
            width: 40px;
            margin: 0 auto 20px;
        }

        .main-content {
            margin-left: 260px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        .sidebar.collapsed + .main-content {
            margin-left: 90px;
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

        .sidebar img {
            width: 150px;
            margin: 0 auto 30px;
            display: block;
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
        <a href="ChargeAff.aspx"><i class="fas fa-chart-line me-2"></i> Vue d'ensemble</a>
        <a href="AjoutClient.aspx"><i class="fas fa-user-plus me-2"></i> Proposer Client</a>
        <a href="PlanningVisite.aspx"><i class="fas fa-calendar-check me-2"></i> Consulter Planning Visite</a>
        <a href="AjoutFormVisite.aspx"><i class="fas fa-edit me-2"></i> Formulaire Visite</a>
    </div>

    <div class="main-content">
        <h3 class="mb-4 fw-semibold text-dark">📅 Planning Visite</h3>

        <!-- Tableau des clients prospects -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card shadow p-3">
                    <h6 class="text-primary mb-3">Liste des clients prospects</h6>
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Nom du client</th>
                                <th>Contact</th>
                                <th>Adresse</th>
                                <th>Dirigeant principal</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Société Alpha SARL</td>
                                <td>06 45 23 78 12</td>
                                <td>Alger, Alger Centre, 16000</td>
                                <td>Amine El Malki</td>
                                <td><span class="badge bg-warning text-dark">Validation en cours</span></td>
                                <td>
                                    <a href="FicheClient.aspx?id=1" class="btn btn-sm btn-outline-danger" target="_blank">Voir Fiche Client <i class="fas fa-file-pdf"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>Entreprise BETA</td>
                                <td>05 22 14 98 77</td>
                                <td>Alger, Bab El Oued, 16027</td>
                                <td>Sara Bennis</td>
                                <td><span class="badge bg-info text-dark">Validation initiale</span></td>
                                <td>
                                    <button class="btn btn-outline-success btn-sm me-2" onclick="ouvrirModal('Entreprise BETA')">Planifier visite</button>
                                    <a href="FicheClient.aspx?id=2" class="btn btn-sm btn-outline-danger" target="_blank">Voir Fiche Client <i class="fas fa-file-pdf"></i></a>
                                </td>
                            </tr>
                            <tr>
                                <td>Holding Kappa</td>
                                <td>06 78 99 11 00</td>
                                <td>Constantine, El Khroub, 25013</td>
                                <td>Youssef Oukacha</td>
                                <td><span class="badge bg-success">Visite terminée</span></td>
                                <td>
                                    <a href="AjoutFormVisite.aspx" class="btn btn-outline-dark btn-sm me-2">Rédiger compte rendu</a>
                                    <a href="FicheClient.aspx?id=3" class="btn btn-sm btn-outline-danger" target="_blank">Voir Fiche Client <i class="fas fa-file-pdf"></i></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Modal Planification -->
                    <div class="modal fade" id="modalPlanification" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content shadow">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalLabel">📅 Choisir une date de visite</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
                                </div>
                                <div class="modal-body">
                                    <input type="text" id="datepicker" class="form-control" placeholder="Sélectionner une date" />
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                    <button type="button" class="btn btn-primary" onclick="confirmerDate()">Confirmer</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Visites à venir -->
                    <div class="mt-5">
                        <h6 class="text-primary mb-3">Visites à venir</h6>
                        <table class="table table-bordered" id="tableVisites">
                            <thead class="table-light">
                                <tr>
                                    <th>Nom du client</th>
                                    <th>Date de visite</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Lignes ajoutées dynamiquement -->
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script>
        let clientSelectionne = null;
        let datesOccupees = [];

        function ouvrirModal(nomClient) {
            clientSelectionne = nomClient;
            const modal = new bootstrap.Modal(document.getElementById('modalPlanification'));
            modal.show();
        }

        function confirmerDate() {
            const date = document.getElementById('datepicker').value;
            if (!date || !clientSelectionne) {
                alert("Veuillez choisir une date.");
                return;
            }

            const table = document.getElementById("tableVisites").getElementsByTagName('tbody')[0];
            const row = table.insertRow();
            let color = "bg-secondary";
            const visitDate = new Date(date);
            const today = new Date();
            const diffDays = Math.ceil((visitDate - today) / (1000 * 60 * 60 * 24));

            if (diffDays < 0) {
                color = "bg-danger";
            } else if (diffDays <= 3) {
                color = "bg-warning";
            } else {
                color = "bg-success";
            }

            row.innerHTML = `
                <td>${clientSelectionne}</td>
                <td><span class="badge ${color} text-white">${date}</span></td>
                <td><button class="btn btn-sm btn-outline-warning" onclick="modifierDate(this)">Modifier la date</button></td>
            `;

            datesOccupees.push(date);
            rafraichirFlatpickr();
        }

        function modifierDate(btn) {
            const row = btn.closest("tr");
            const client = row.cells[0].innerText;
            clientSelectionne = client;
            const modal = new bootstrap.Modal(document.getElementById('modalPlanification'));
            modal.show();

            modal._element.querySelector('.btn-primary').onclick = function () {
                const newDate = document.getElementById('datepicker').value;
                if (newDate) {
                    const visitDate = new Date(newDate);
                    const today = new Date();
                    let color = "bg-secondary";
                    const diffDays = Math.ceil((visitDate - today) / (1000 * 60 * 60 * 24));

                    if (diffDays < 0) {
                        color = "bg-danger";
                    } else if (diffDays <= 3) {
                        color = "bg-warning";
                    } else {
                        color = "bg-success";
                    }

                    row.cells[1].innerHTML = `<span class="badge ${color} text-white">${newDate}</span>`;
                    modal.hide();

                    datesOccupees.push(newDate);
                    rafraichirFlatpickr();
                } else {
                    alert("Veuillez choisir une date.");
                }
            };
        }

        function rafraichirFlatpickr() {
            flatpickr("#datepicker", {
                minDate: "today",
                dateFormat: "Y-m-d",
                locale: "fr",
                disable: datesOccupees,
                onDayCreate: function (dObj, dStr, fp, dayElem) {
                    const dateStr = dayElem.dateObj.toISOString().split('T')[0];
                    if (datesOccupees.includes(dateStr)) {
                        dayElem.style.backgroundColor = "#dc3545";
                        dayElem.style.color = "white";
                    } else {
                        dayElem.style.backgroundColor = "#198754";
                        dayElem.style.color = "white";
                    }
                }
            });
        }

        rafraichirFlatpickr();

        document.getElementById("toggleSidebar").addEventListener("click", () => {
            document.querySelector(".sidebar").classList.toggle("collapsed");
        });
    </script>
</body>
</html>
