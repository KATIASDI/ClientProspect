<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="PROJETFIN1.Admin" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Dashboard Admin</title>

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary: #003E7E;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --text-color: #333;
            --card-bg: #fff;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background);
            color: var(--text-color);
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100vh;
            background-color: var(--primary);
            padding: 30px 20px;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            color: white;
            z-index: 999;
        }

        .sidebar img {
            max-width: 80%;
            display: block;
            margin: 0 auto 30px;
        }

        .sidebar .nav-link {
            color: white;
            margin: 10px 0;
            font-size: 16px;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: all 0.2s ease;
        }

        .sidebar .nav-link:hover {
            text-decoration: none;
            transform: translateX(5px);
            color: var(--accent);
        }

        .content {
            margin-left: 270px;
            padding: 30px;
        }

        .card-style {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
        }

        .btn-custom {
            background-color: var(--secondary);
            color: white;
            font-weight: bold;
            border-radius: 10px;
        }

        .btn-custom:hover {
            background-color: #0056b3;
        }

        .profile-section {
            display: flex;
            align-items: center;
        }

        .profile-section img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-left: 10px;
        }

        .table th {
            background-color: var(--primary);
            color: white;
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
            document.getElementById('mainContent').style.display = 'none';
            document.getElementById('addUserContainer').style.display = 'block';
        }

        function flipBack() {
            document.getElementById('addUserContainer').style.display = 'none';
            document.getElementById('mainContent').style.display = 'block';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- SIDEBAR -->
        <div class="sidebar d-flex flex-column align-items-start">
            <div class="text-center w-100 mb-4">
                <img src="Logo1m.png" alt="Housing Bank Logo" class="img-fluid">
            </div>
            <a class="nav-link" href="Dashboard.aspx"><i class="bi bi-house-door-fill me-2"></i>Dashboard</a>
            <a class="nav-link" href="Admin.aspx"><i class="bi bi-people-fill me-2"></i>Manage Users</a>
            <a class="nav-link" href="AjoutUser.aspx"><i class="bi bi-person-plus-fill me-2"></i>Add New User</a>
            <a class="nav-link" href="#"><i class="bi bi-shield-lock-fill me-2"></i>Roles & Permissions</a>
            <a class="nav-link" href="#"><i class="bi bi-folder2-open me-2"></i>View Prospects</a>
            <a class="nav-link" href="#"><i class="bi bi-bar-chart-line-fill me-2"></i>Reports</a>
            <a class="nav-link" href="#"><i class="bi bi-clock-history me-2"></i>User History</a>
            <a class="nav-link" href="#"><i class="bi bi-gear-fill me-2"></i>Settings</a>
        </div>

        <!-- MAIN CONTENT -->
        <div class="content">
            <div id="mainContent">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Dashboard Admin</h2>
                    <div class="profile-section">
                        <span class="fw-semibold text-dark">Abdellah Toufik</span>
                        <img src="adminpic.png" alt="Profil" />
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card-style">
                            👤 Utilisateurs :
                            <asp:Label ID="lblUsers" runat="server" Text="0" CssClass="fw-bold fs-5 ms-2" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card-style">
                            📩 Notifications :
                            <asp:Label ID="lblMessages" runat="server" Text="0" CssClass="fw-bold fs-5 ms-2" />
                        </div>
                    </div>
                </div>

                <asp:Button ID="btnAjouter" runat="server" CssClass="btn btn-custom mb-3" Text="➕ Ajouter un utilisateur" OnClientClick="flipPage(); return false;" />

                <div class="table-responsive card-style">
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
                                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-sm btn-danger"
                                        CommandArgument='<%# Eval("ID") %>' Text="Désactiver" OnClick="btnUpdate_Click"
                                        OnClientClick='<%# "return confirmerSuppression(\"" + Eval("Nom") + "\", \"" + Eval("ID") + "\");" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Formulaire d’ajout utilisateur -->
            <div id="addUserContainer" style="display: none;">
                <h2 class="mb-3">Ajouter un utilisateur</h2>
                <iframe src="AjoutUser.aspx" width="100%" height="600px" style="border: none;"></iframe>
                <button class="btn btn-secondary mt-3" onclick="flipBack(); return false;">⬅ Retour</button>
            </div>
        </div>
    </form>
</body>
</html>
