<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DirAgence.aspx.cs" Inherits="PROJETFIN1.DirAgence" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dashboard - Directeur d’Agence</title>

    <!-- Bootstrap & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 0;
        }
        .sidebar {
            background-color: #012970;
            min-height: 100vh;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            transition: width 0.3s;
            z-index: 1000;
        }
        .sidebar a {
            color: #fff;
            display: block;
            padding: 15px;
            text-decoration: none;
        }
        .sidebar a:hover {
            background-color: #0a58ca;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }
        .navbar {
            background-color: #fff;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            margin-left: 250px;
        }
        .navbar-brand {
            font-weight: bold;
            color: #012970;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
        }
        .card-header, .card-body {
            background-color: #fff;
            border-radius: 10px;
        }
        .table {
            color: #212529;
        }
        .sidebar-collapsed {
            width: 70px;
        }
        .collapsed .main-content {
            margin-left: 70px;
        }
        #sidebarToggle {
            background-color: transparent;
            border: none;
            color: #012970;
            font-size: 24px;
        }
        .sidebar img {
            margin: 20px auto;
            display: block;
            max-width: 80%;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar d-flex flex-column">
            <img src="Logo1m.png" alt="Housing Bank Logo" />
            <a href="DashboardDirComm.aspx"><i class="fas fa-home me-2"></i>Dashboard</a>
            <a href="#"><i class="fas fa-check-circle me-2"></i>Validation Fiches</a>
            <a href="#"><i class="fas fa-question-circle me-2"></i>Demandes Infos</a>
            <a href="#"><i class="fas fa-cog me-2"></i>Paramètres</a>
        </div>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top">
            <div class="container-fluid">
<button id="sidebarToggle" class="btn"><i class="fas fa-bars"></i></button>
                <a class="navbar-brand ms-3" href="#">Bienvenue Directeur d'Agence</a>
            </div>
        </nav>

        <!-- Main Content -->
        <div class="main-content pt-5">
            <div class="row mb-4">
                <!-- Cartes Statistiques -->
                <div class="col-md-3">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Fiches Reçues</h5>
                            <p class="card-text fs-4">25</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Fiches Validées</h5>
                            <p class="card-text fs-4">18</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-danger mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Fiches Rejetées</h5>
                            <p class="card-text fs-4">5</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-warning mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Demandes Infos</h5>
                            <p class="card-text fs-4">2</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Titre -->
            <h2 class="text-primary mb-4">Validation des Fiches Client Prospect</h2>

            <!-- Tableau des prospects -->
            <div class="card mb-4">
                <div class="card-body">
                    <asp:GridView ID="gvProspects" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" HeaderStyle-CssClass="table-light">
                        <Columns>
                            <asp:BoundField DataField="NOM" HeaderText="Nom" />
                            <asp:BoundField DataField="SECTEUR" HeaderText="Secteur" />
                            <asp:BoundField DataField="SOUS_SECTEUR" HeaderText="Sous-secteur" />
                            <asp:BoundField DataField="BESOINS" HeaderText="Besoins" />
                            <asp:BoundField DataField="NBR_EMPLOYES" HeaderText="Nb Employés" />
                            <asp:BoundField DataField="TYPE_RENCONTRE" HeaderText="Type Rencontre" />
                            <asp:BoundField DataField="CAPITAL" HeaderText="Capital (DA)" />
                            <asp:BoundField DataField="FORME_JURIDIQUE" HeaderText="Forme Juridique" />
                            <asp:TemplateField HeaderText="Autres informations">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkInfos" runat="server"
                                        Text="Plus d'informations"
                                        CommandName="ShowDetails"
                                        CommandArgument='<%# Eval("ID_PROSPECT") %>' 
                                        CssClass="text-primary text-decoration-underline" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Détails du prospect -->
            <asp:Panel ID="pnlDetails" runat="server" CssClass="card p-4 mb-4 border-start border-5 border-primary" Visible="false">
                <h5 class="text-primary mb-3">Détails du Prospect</h5>
                <asp:Label ID="lblNom" runat="server" CssClass="d-block fw-bold" />
                <asp:Label ID="lblEmail" runat="server" CssClass="d-block" />
                <asp:Label ID="lblAdresse" runat="server" CssClass="d-block" />
                <asp:Label ID="lblCanal" runat="server" CssClass="d-block" />
                <asp:Label ID="lblDateCreation" runat="server" CssClass="d-block" />
                <asp:Label ID="lblCommentaire" runat="server" CssClass="d-block" />
                <asp:HiddenField ID="hfCurrentProspectId" runat="server" />

                <div class="mt-4 d-flex flex-wrap gap-2">
                    <asp:Button ID="btnRejeterMotif" runat="server" CssClass="btn btn-danger" Text="❌ Rejeter avec motif" OnClick="btnRejeterMotif_Click" />
                    <asp:Button ID="btnTransmettre" runat="server" CssClass="btn btn-success" Text="📤 Transmettre à la direction commerciale" OnClick="btnTransmettre_Click" />
                    <asp:Button ID="btnDemanderInfos" runat="server" CssClass="btn btn-warning" Text="❓ Demander plus d'informations" OnClick="btnDemanderInfos_Click" />
                    <asp:Button ID="Button1" runat="server" CssClass="btn btn-secondary" Text="↩️ Retour" OnClick="btnRetour_Click" />
                </div>
            </asp:Panel>

            <!-- Motif du rejet -->
            <asp:Panel ID="pnlMotifRejet" runat="server" Visible="false" CssClass="card p-3 mb-4 border-danger border-2">
                <div class="mb-3">
                    <label for="txtMotifRejet" class="form-label text-danger">Motif du rejet *</label>
                    <asp:TextBox ID="txtMotifRejet" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                    <asp:RequiredFieldValidator ID="rfvMotifRejet" runat="server"
                        ControlToValidate="txtMotifRejet"
                        ErrorMessage="Veuillez remplir le motif de rejet."
                        CssClass="text-danger"
                        Display="Dynamic"
                        ValidationGroup="Rejet"
                        Enabled="false" />
                </div>
            </asp:Panel>

            <!-- Message retour -->
            <div class="mt-3">
                <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold text-warning" />
            </div>
        </div>
    </form>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Sidebar Toggle -->
    <script>
        document.getElementById('sidebarToggle').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('sidebar-collapsed');
            document.querySelector('body').classList.toggle('collapsed');
        });
    </script>
</body>
</html>
