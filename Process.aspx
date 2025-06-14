﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Process.aspx.cs" Inherits="WebRedaTest.Process" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Housing Bank Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
         .tracker {
  position: relative;
  margin-top: 20px;
  margin-bottom: 20px;
}

.step {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  background-color: #ccc;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2;
  position: relative;
}

.step.active {
  background-color: green !important;
}

.progress-line {
  position: absolute;
  top: 50%;
  left: 0;
  right: 0;
  height: 5px;
  background-color: #ccc;
  z-index: 1;
}


        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
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
                                    font-size: 1.2rem;

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
            gap: 10px;
            justify-content: center;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>

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
                        DataKeyNames="ID_PROSPECT,STATUS_ID">
                        <Columns>
                            <asp:BoundField DataField="NOM" HeaderText="Nom" />
                            <asp:BoundField DataField="NUMTEL" HeaderText="Téléphone" />
                            <asp:BoundField DataField="EMAIL" HeaderText="Email" />
                            <asp:BoundField DataField="ADRESSE" HeaderText="Adresse" />
                            <asp:BoundField DataField="STATUS_NAME" HeaderText="Statut" />
                            
                            <asp:TemplateField HeaderText="Détails">
                                <ItemTemplate>
                                    <asp:Button ID="btnDetails" runat="server"
                                        Text="Voir détails"
                                        CommandName="Details"
                                        CommandArgument='<%# Eval("ID_PROSPECT") %>'
                                        CssClass="btn btn-info btn-sm" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Info Supplémentaire">
                                <ItemTemplate>
                                    <asp:Literal ID="LiteralInfoSup" runat="server" />
                                    <asp:Button ID="btnViewComment" runat="server"
                                        Text="Voir Commentaire"
                                        CommandName="ViewComment"
                                        CommandArgument='<%# Eval("ID_PROSPECT") %>'
                                        CssClass="btn btn-secondary btn-sm mt-2" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="grid-actions">
                                        <asp:Literal ID="LiteralAction" runat="server" />
                                    </div>
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
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background-color: #1F3BB3; color: white;">
                <h5 class="modal-title w-100 text-center" id="detailsLabel">
                    Détails du prospect
                </h5>
                <button type="button" class="btn-close position-absolute end-0 me-3" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
                         <div class="px-4 pt-3">
  <div class="d-flex justify-content-between align-items-center tracker position-relative">
    <div class="progress-line"></div>
    <div class="step" id="step-CA">CA</div>
    <div class="step" id="step-DA">DA</div>
    <div class="step" id="step-DC">DC</div>
    <div class="step" id="step-CC">CC</div>
  </div>
</div>

      
                            <div class="modal-body">
                                <asp:Label ID="lblDetails" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <!-- Modal pour le calendrier -->
        <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="calendarModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="calendarModalLabel">Planifier une visite</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="visitDate">Date de la visite :</label>
                            <input type="date" class="form-control" id="visitDate" />
                        </div>
                        <input type="hidden" id="calendarProspectId" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="button" class="btn btn-primary" onclick="saveVisitDate()">Valider</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal pour l'upload PDF -->
        <div class="modal fade" id="pdfUploadModal" tabindex="-1" role="dialog" aria-labelledby="pdfUploadModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="pdfUploadModalLabel">Uploader le rapport de visite</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="pdfFile">Sélectionner un fichier PDF :</label>
                            <input type="file" class="form-control-file" id="pdfFile" accept=".pdf" />
                        </div>
                        <input type="hidden" id="pdfProspectId" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
                        <button type="button" class="btn btn-primary" onclick="savePdfUpload()">Valider</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

        function updateStatus(prospectId, newStatus, action) {
            confirmAction(
                'Confirmer l\'action',
                `Voulez-vous vraiment effectuer l'action : ${action} ?`,
                'Confirmer',
                'Annuler',
                (comment) => {
                    PageMethods.UpdateProspectStatus(prospectId, newStatus, null, comment,
                        (response) => {
                            showMessage('Succès', response, 'success', () => {
                                window.location.reload();
                            });
                        },
                        (error) => {
                            showMessage('Erreur', error._message, 'error');
                        }
                    );
                }
            );
        }

        function submitVote(prospectId, vote, newStatus) {
            confirmAction(
                'Confirmer votre vote',
                `Voulez-vous confirmer votre vote : ${vote} ?`,
                'Confirmer',
                'Annuler',
                (comment) => {
                    PageMethods.UpdateProspectStatus(prospectId, newStatus, vote, comment,
                        (response) => {
                            showMessage('Succès', response, 'success', () => {
                                window.location.reload();
                            });
                        },
                        (error) => {
                            showMessage('Erreur', error._message, 'error');
                        }
                    );
                }
            );
        }

        function showVoteResults(prospectId) {
            PageMethods.GetVoteResults(prospectId,
                (response) => {
                    showMessage('Résultats des votes', response, 'info');
                },
                (error) => {
                    showMessage('Erreur', error._message, 'error');
                }
            );
        }

        function handleVisitAction(prospectId, newStatus, action, modalType) {
            confirmAction(
                'Confirmer l\'action',
                `Voulez-vous vraiment effectuer l'action : ${action} ?`,
                'Confirmer',
                'Annuler',
                (comment) => {
                    PageMethods.UpdateProspectStatus(prospectId, newStatus, null, comment,
                        (response) => {
                            // Mise à jour OK, on ouvre la modal selon type
                            if (modalType === 'calendar') {
                                $('#calendarProspectId').val(prospectId);
                                $('#visitDate').val('');
                                $('#calendarModal').modal('show');
                            } else if (modalType === 'pdf') {
                                $('#pdfProspectId').val(prospectId);
                                $('#pdfFile').val('');
                                $('#pdfUploadModal').modal('show');
                            } else {
                                window.location.reload();
                            }
                        },
                        (error) => {
                            showMessage('Erreur', error._message, 'error');
                        }
                    );
                }
            );
        }

        function saveVisitDate() {
            const prospectId = $('#calendarProspectId').val();
            const visitDate = $('#visitDate').val();
            if (!visitDate) {
                showMessage('Erreur', 'Veuillez sélectionner une date pour la visite.', 'error');
                return;
            }
            PageMethods.SaveVisit(prospectId, visitDate,
                (response) => {
                    showMessage('Succès', response, 'success', () => {
                        $('#calendarModal').modal('hide');
                        $('#calendarModal').on('hidden.bs.modal', () => {
                            window.location.reload();
                        });
                    });
                },
                (error) => {
                    showMessage('Erreur', error._message, 'error');
                }
            );
        }

        function savePdfUpload() {
            const prospectId = $('#pdfProspectId').val();
            const fileInput = document.getElementById('pdfFile');
            if (!fileInput.files[0]) {
                showMessage('Erreur', 'Veuillez sélectionner un fichier PDF pour le rapport de visite.', 'error');
                return;
            }
            const file = fileInput.files[0];
            const fileName = file.name;

            // Vérifier la taille du fichier (par exemple, max 10 Mo)
            const maxFileSize = 10 * 1024 * 1024; // 10 Mo en octets
            if (file.size > maxFileSize) {
                showMessage('Erreur', 'Le fichier PDF est trop volumineux. La taille maximale autorisée est de 10 Mo.', 'error');
                return;
            }

            // Lire le contenu du fichier en base64
            const reader = new FileReader();
            reader.onload = function (e) {
                const fileData = e.target.result;
                console.log('Envoi du fichier : ', fileName); // Pour débogage
                PageMethods.SaveVisitReport(prospectId, fileName, fileData,
                    (response) => {
                        showMessage('Succès', response, 'success', () => {
                            $('#pdfUploadModal').modal('hide');
                            $('#pdfUploadModal').on('hidden.bs.modal', () => {
                                window.location.reload();
                            });
                        });
                    },
                    (error) => {
                        showMessage('Erreur', error._message, 'error');
                    }
                );
            };
            reader.onerror = function (e) {
                showMessage('Erreur', 'Erreur lors de la lecture du fichier PDF.', 'error');
            };
            reader.readAsDataURL(file);
        }

        function openCalendar(prospectId) {
            $('#calendarProspectId').val(prospectId);
            $('#visitDate').val('');
            $('#calendarModal').modal('show');
        }

        function openPdfUpload(prospectId) {
            $('#pdfProspectId').val(prospectId);
            $('#pdfFile').val('');
            $('#pdfUploadModal').modal('show');
        }

        function showMessage(title, text, icon, callback) {
            Swal.fire({
                title: title,
                text: text,
                icon: icon,
                confirmButtonText: 'OK',
                customClass: {
                    confirmButton: 'btn btn-primary'
                },
                buttonsStyling: false
            }).then(callback);
        }

        function confirmAction(title, text, confirmText, cancelText, callback) {
            Swal.fire({
                title: title,
                text: text,
                icon: 'question',
                input: 'textarea',
                inputLabel: 'Commentaire',
                inputPlaceholder: 'Entrez votre commentaire ici...',
                showCancelButton: true,
                confirmButtonText: confirmText,
                cancelButtonText: cancelText,
                customClass: {
                    confirmButton: 'btn btn-primary me-2',
                    cancelButton: 'btn btn-secondary'
                },
                buttonsStyling: false,
                inputValidator: (value) => {
                    if (value && value.length > 200) {
                        return 'Le commentaire ne doit pas dépasser 200 caractères.';
                    }
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    callback(result.value || '');
                }
            });
        }

        function showLastComment(prospectId) {
            PageMethods.GetLastComment(prospectId,
                (response) => {
                    if (response) {
                        showMessage('Dernier Commentaire', response, 'info');
                    } else {
                        showMessage('Information', 'Aucun commentaire trouvé pour ce prospect.', 'info');
                    }
                },
                (error) => {
                    showMessage('Erreur', error._message, 'error');
                }
            );
        }
    </script>
</body>
</html>