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
     <!-- Bootstrap 5 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
 <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        :root {
            --primary: #1F2937;
            --secondary: #2563EB;
            --bg-light: #F9FAFB;
            --card-bg: #FFFFFF;
            --text-color: #111827;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-color);
        }

        .content {
            margin: 30px auto;
            max-width: 1100px;
            padding: 20px;
        }

        .title-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .card-style {
            background: var(--card-bg);
            border-radius: 16px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            padding: 2rem;
        }

        .btn-custom {
            background-color: var(--secondary);
            color: white;
            border-radius: 6px;
            font-weight: 600;
            padding: 8px 16px;
        }

        .btn-custom:hover {
            background-color: #1D4ED8;
        }

        .table {
            border-collapse: collapse;
            width: 100%;
        }

        .table thead th {
            background-color: var(--primary);
            color: white;
            text-align: center;
            padding: 10px;
            font-size: 13px;
            font-weight: 600;
            border-bottom: 1px solid #e5e7eb;
        }

        .table thead th:first-child {
            border-top-left-radius: 8px;
        }

        .table thead th:last-child {
            border-top-right-radius: 8px;
        }

        .table tbody td {
            background-color: white;
            text-align: center;
            vertical-align: middle;
            font-size: 13px;
            padding: 10px;
            border-bottom: 1px solid #f1f5f9;
        }

        .table tbody tr:hover {
            background-color: #f3f4f6;
            transition: background 0.3s ease;
        }

        .action-buttons .btn {
            font-size: 0.75rem;
            padding: 6px 10px;
        }

        .action-buttons i {
            font-size: 14px;
        }

        /* Modern toggle switch */
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 42px;
            height: 22px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            transition: 0.4s;
            border-radius: 22px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: 0.4s;
            border-radius: 50%;
        }

        .toggle-switch input:checked + .slider {
            background-color: var(--secondary);
        }

        .toggle-switch input:checked + .slider:before {
            transform: translateX(20px);
        }

        iframe {
            border: none;
            width: 100%;
            height: 600px;
            border-radius: 12px;
        }
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

    <script>
       
            document.getElementById('toggleSidebar').addEventListener('click', function () {
                document.querySelector('.sidebar').classList.toggle('active');
      });
  
        function confirmerDesactivation(nom, userId) {
            Swal.fire({
                title: "Désactiver l'utilisateur ?",
                text: "Souhaitez-vous désactiver le compte de " + nom + " ?",
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
    <div class="container-fluid">
        <div class="row">

            <!-- Bouton Hamburger pour mobile -->
            <button class="btn d-md-none" id="toggleSidebar" style="position: absolute; top: 1rem; left: 1rem; z-index: 1050; color:red;">
                <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
                <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
                <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
            </button>

            <!-- Sidebar -->
            <div class="col-md-2 sidebar d-flex flex-column">
                <div class="text-center mb-4">
                    <img src="Logo1m.png" alt="Housing Bank Logo" class="img-fluid logo-img" />
                   </div>
    <a href="Dashboard.aspx"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
<a href="Admin.aspx"><i class="bi bi-person-badge-fill me-2"></i>Manage Users</a>
<a href="AjoutUser.aspx"><i class="bi bi-person-plus-fill me-2"></i>Add New User</a>
<a href="RolesetPermissions.aspx"><i class="bi bi-key-fill me-2"></i>Roles & Permissions</a>
<a href="Settings.aspx"><i class="bi bi-gear-wide-connected me-2"></i>Settings</a>





</div>

            <!-- Contenu principal -->
            <div class="col-md-10 content">
                <div class="title-bar d-flex justify-content-between align-items-center my-4 px-3">
                    <h3>👤 Gestion des Utilisateurs</h3>
                </div>

                <div class="card-style px-3">
                    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped" OnRowCommand="gvUsers_RowCommand" OnSelectedIndexChanged="gvUsers_SelectedIndexChanged1">
                  

                        <Columns>
                            <asp:BoundField DataField="IDENTIFIANT" HeaderText="IDENTIFIANT" />
                            <asp:BoundField DataField="Nom" HeaderText="Nom" />
                            <asp:BoundField DataField="ROLE" HeaderText="Rôle" />
                            <asp:BoundField DataField="DateAjout" HeaderText="Date d'ajout" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-center gap-2 action-buttons">
<asp:LinkButton ID="btnEdit" runat="server"
    CssClass="btn btn-outline-warning btn-sm"
    ToolTip="Modifier"
    PostBackUrl='<%# "EditUser.aspx?id=" + Eval("IDENTIFIANT") + "&nom=" + Eval("NOM") + "&role=" + Eval("ROLE") + "&dateAjout=" + "&email=" + Eval("EMAIL") %>'>
    <i class="bi bi-pencil-square"></i>
</asp:LinkButton>
                                     <asp:LinkButton 
                    ID="btnDesactiver" 
                    runat="server" 
                    CommandName="Desactiver" 
                    CommandArgument='<%# Eval("IDENTIFIANT") %>' 
                    OnClientClick='<%# "return confirmerDesactivation(\"" + Eval("Nom") + "\", \"" + Eval("IDENTIFIANT") + "\");" %>'>
                    Désactiver
                </asp:LinkButton>
                                        
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                                                <asp:Panel ID="pnlEditForm" runat="server" Visible="false" CssClass="card p-3">
    <asp:HiddenField ID="hiddenIdentifiant" runat="server" />
    
    <div class="mb-2">
        <label>Nom :</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
    </div>
    <div class="mb-2">
        <label>Email :</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
    </div>
    <div class="mb-2">
        <label>Rôle :</label>
        <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" />
    </div>
    <div class="mb-2">
        <label>Statut :</label>
        <asp:TextBox ID="txtStatus" runat="server" CssClass="form-control" />
    </div>

    <asp:Button ID="btnUpdate" runat="server" Text="Enregistrer" CssClass="btn btn-success mt-2" OnClick="btnUpdate_Click" />
</asp:Panel>
                </div>

            </div>

        </div>
    </div>
</form>
   


            
      
</body>
</html>
