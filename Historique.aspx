<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Historique.aspx.cs" Inherits="VotreProjet.Historique" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Historique des actions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --beige: #C6B18D;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.8);
        }
         .container-chart {
     height: 100vh;
     overflow-y: scroll;
     overflow-x: hidden;

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
    height: 100vh;
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
                .logo-img {
    max-width: 80%;
    height: auto;
    opacity: 0.95;
    mix-blend-mode: normal;
    filter: drop-shadow(0 0 5px rgba(255, 255, 255, 0.2));
    transition: all 0.3s ease-in-out;
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
     display:flex;
     flex-direction:column;
     justify-content:space-between;
 }
            .sidebar.active {
                transform: translateX(0);
            }

        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
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
                    <a id="linkHistory" runat="server" href="Historique.aspx"><i class="bi bi-clock-history me-2"></i>User History</a>

<a href="Settings.aspx"><i class="bi bi-gear-wide-connected me-2"></i>Settings</a>
                <div class="mt-auto p-3">
                    <a href="Login.aspx" class="btn btn-outline-danger w-100 d-flex align-items-center justify-content-center">
                        <i class="bi bi-box-arrow-right me-2"></i>Déconnexion
                    </a>
                </div>
            </div>

            <!-- Contenu principal -->
            <div class="col-md-10 mt-4  ">
                <form id="form1" runat="server">
                    <div class="container ">
                        <h2 class="mb-4">Historique des actions utilisateurs</h2>
                         <div class="input-group mb-3">
        <asp:TextBox ID="txtRecherche" runat="server" CssClass="form-control" placeholder="Rechercher une action, un utilisateur ou un ID..."></asp:TextBox>
        <asp:Button ID="btnRechercher" runat="server" Text="Rechercher" CssClass="btn btn-primary"  />
    </div>
                        <asp:GridView ID="GridViewHistorique" runat="server" CssClass="table table-striped table-bordered"
                            AutoGenerateColumns="False" EmptyDataText="Aucune donnée trouvée." GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="ID_PROSPECT" HeaderText="ID Prospect" />
                                <asp:BoundField DataField="ID_USER" HeaderText="ID Utilisateur" />
                                <asp:BoundField DataField="ACTIONS" HeaderText="Action" />
                                <asp:BoundField DataField="DATE_ACT" HeaderText="Date de l'action" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
