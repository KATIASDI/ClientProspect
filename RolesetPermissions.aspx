<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RolesetPermissions.aspx.cs" Inherits="PROJETFIN1.RolesetPermissions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gestion des Rôles</title>
    <!-- Bootstrap & Google Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
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




</div>
                <!-- Main Content -->
                <div class="col-md-10 p-4">
                    <div class="card-custom">
    <h2 class="mb-4">Gestion des Rôles et Permissions</h2>

    <!-- Ligne avec bouton + à gauche et recherche à droite -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <button type="button" class="btn btn-success" onclick="location.href='AjoutUser.aspx'">
            <i class="bi bi-plus-lg"></i> Ajouter
        </button>

        <div class="input-group" style="max-width: 300px;">
            <asp:TextBox ID="txtRecherche" runat="server" CssClass="form-control" Placeholder="Rechercher..." />
            <button type="submit" class="btn btn-outline-primary" runat="server" onserverclick="btnRecherche_Click">
                <i class="bi bi-search"></i>
            </button>
        </div>
    </div>


                        <!-- Grid des utilisateurs -->
                        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
    OnRowEditing="gvUsers_RowEditing"
    OnRowUpdating="gvUsers_RowUpdating"
    OnRowCancelingEdit="gvUsers_RowCancelingEdit"
    CssClass="table table-striped table-bordered">
    
    <Columns>
        <asp:BoundField DataField="IDENTIFIANT" HeaderText="ID" ReadOnly="True" />
        <asp:BoundField DataField="NAME" HeaderText="Nom" ReadOnly="True" />

        <asp:TemplateField HeaderText="Rôle">
            <EditItemTemplate>
                <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-control" />
            </EditItemTemplate>
            <ItemTemplate>
                <%# Eval("ROLE_") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:CommandField ShowEditButton="True" ShowUpdateButton="True" ShowCancelButton="True" />
    </Columns>
</asp:GridView>


                       
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script>
    document.getElementById('toggleSidebar').addEventListener('click', function () {
        document.querySelector('.sidebar').classList.toggle('active');
    });
    </script>
</body>
</html>
