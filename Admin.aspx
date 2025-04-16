<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="PROJETFIN1.Admin" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="UTF-8">
                            <title>Dashboard Admin</title>
    
    <!-- CSS Nifty (ou personnalisé) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    
    <!-- SweetAlert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        .sidebar {
            background-color: #1e3c72;
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            padding-top: 20px;
        }

        .sidebar img {
    width: 80%; /* ou 100% si tu veux qu'il remplisse toute la largeur */
    height: auto;
    margin: 0 auto 20px auto;
    display: block;
    margin-top: 0; /* s'assurer qu'il commence tout en haut */
    padding-top: 0;
}

        .sidebar .nav-link {
            color: white;
            font-weight: 500;
        }

        .sidebar .nav-link:hover {
            background-color: #2a5298;
            color: #fff;
        }

        .content {
            margin-left: 250px;
            padding: 30px;
        }

        .card-style {
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
        }

        .table th {
            background-color: #1e3c72;
            color: white;
        }

        .btn-custom {
            background-color: #2ecc71;
            color: white;
            font-weight: bold;
        }

        .btn-custom:hover {
            background-color: #27ae60;
        }

        .logout {
            position: absolute;
            bottom: 20px;
            left: 20px;
            color: white;
        }

        iframe {
            border: none;
        }
        .profile-section {
    display: flex;
    justify-content: flex-end;
    align-items: center;
}

.profile-section img {
    border-radius: 50%;
    width: 40px;
    height: 40px;
    margin-right: 10px;
}

.profile-section .profile-icon {
    font-size: 20px;
    color: #1e3c72;
    margin-right: 10px;
}

    </style>

    <script>
        function confirmerSuppression(nom, userId) {
            Swal.fire({
                title: "Désactiver l'utilisateur ?",
                text: "Êtes-vous sûr de vouloir désactiver le compte de " + nom + " ?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "✅ Oui",
                cancelButtonText: "❌ Annuler"
            }).then((result) => {
                if (result.isConfirmed) {
                    __doPostBack('btnDesactivate', userId);
                }
            });
            return false;
        }

        function flipPage() {
            document.getElementById('addUserContainer').style.display = 'block';
            document.getElementById('mainContent').style.display = 'none';
        }

        function flipBack() {
            document.getElementById('addUserContainer').style.display = 'none';
            document.getElementById('mainContent').style.display = 'block';
        }
    </script>
</head>
<body>
    <form runat="server">
        <!-- Sidebar -->
        <div class="sidebar d-flex flex-column justify-content-between">
            <div>
                <img src="Logo.png" alt="Housing Bank Logo" />
               <nav class="nav flex-column px-3">
    <a class="nav-link" href="Admin.aspx">🏠 Dashboard</a>
    <a class="nav-link" href="#" onclick="flipPage(); return false;">➕ Ajouter Utilisateur</a>
    <!-- Liens supplémentaires -->
    <a class="nav-link" href="#">👔 Chargé d'affaire</a>
    <a class="nav-link" href="#">🏢 Direction commerciale</a>
    <a class="nav-link" href="#">💼 Comité crédit</a>
    <a class="nav-link" href="#">🏦 Directeur d'agence</a>
</nav>

            </div>
            <div class="logout">
                <a href="Login.aspx" class="text-white text-decoration-none">🔒 Déconnexion</a>
            </div>
        </div>

        <!-- Main content -->
        <div class="content">
            <div id="mainContent">
         
                <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Dashboard Admin</h2>
    <div class="profile-section">
        <span class="profile-icon"><i class="bi bi-person-circle"></i></span>
        <img src="adminpic.png" alt="Admin" />
        <span class="text-dark">Abdellah Toufik</span>
    </div>
</div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card card-style p-3">
                            👤 Utilisateurs : <asp:Label ID="lblUsers" runat="server" Text="0" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card card-style p-3">
                            📩 Notifications : <asp:Label ID="lblMessages" runat="server" Text="0" />
                        </div>
                    </div>
                </div>

                <asp:Button ID="btnAjouter" runat="server" CssClass="btn btn-custom mb-3" Text="➕ Ajouter un utilisateur" OnClientClick="flipPage(); return false;" />

                <!-- GridView Utilisateurs -->
                <div class="table-responsive card card-style p-3">
                    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="gvUsers_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" />
                            <asp:BoundField DataField="Nom" HeaderText="Nom" />
                            <asp:BoundField DataField="ROLE" HeaderText="Rôle" />
                            <asp:BoundField DataField="DateAjout" HeaderText="Date d'ajout" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditUser" CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-sm btn-warning me-2">✏️</asp:LinkButton>
                                  
                                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-sm btn-danger" title="Mettre à jour"
            CommandArgument='<%# Eval("ID") %>' Text="Désactiver" OnClick="btnUpdate_Click"
            OnClientClick="return confirm('Voulez-vous vraiment mettre à jour ce prospect ?');">
        </asp:Button>
    </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Ajout Utilisateur -->
            <div id="addUserContainer" style="display: none;">
                <h2>Ajouter un utilisateur</h2>
                <iframe src="AjoutUser.aspx" width="100%" height="600px"></iframe>
                <button class="btn btn-secondary mt-3" onclick="flipBack(); return false;">⬅ Retour</button>
            </div>
        </div>
    </form>
</body>
</html>
