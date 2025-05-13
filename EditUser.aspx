<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="PROJETFIN1.EditUser" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="utf-8" />
    <title>Modifier un utilisateur</title>
     <!-- Bootstrap 5 -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
 <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f5f7fa;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #004085;
        }
        .btn-primary {
            background-color: #004085;
            border-color: #004085;
        }
        .btn-primary:hover {
            background-color: #0056b3;
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
    <div class="container-fluid">
    <div class="row">
        
<%--        <!-- Bouton Hamburger -->
<button class="btn d-md-none" id="toggleSidebar" style="position: absolute; top: 1rem; left: 1rem; z-index: 1050; color:red;">
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
</button>--%>
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
     
   

    <div class="col-md-10">
            <form id="form1" runat="server">
                <div class="form-container">
                    <h2 class="form-title text-center">Modifier l'utilisateur</h2>

                <div class="mb-3">
                    <label for="txtNom" class="form-label">Nom complet</label>
                    <asp:TextBox ID="txtNom" runat="server" CssClass="form-control" placeholder="Entrez le nom complet"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="txtIdentifiant" class="form-label">Identifiant</label>
                    <asp:TextBox ID="txtIdentifiant" runat="server" CssClass="form-control" placeholder="Entrez l'identifiant"></asp:TextBox>
                </div>

                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="exemple@domaine.com" TextMode="Email"></asp:TextBox>
                </div>

               <div class="mb-3">
    <label for="ddlRole" class="form-label">Rôle</label>
    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select" AutoPostBack="True" 
        DataSourceID="SqlDataSource1" DataTextField="DESCRIPTION" DataValueField="DESCRIPTION">
    </asp:DropDownList>

    <!-- Source de données SQL -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" 
        ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" 
        SelectCommand="SELECT DESCRIPTION FROM NOMENCLATURE WHERE TYPE_CODE='4'">
    </asp:SqlDataSource>
</div>


                <div class="d-grid">
                    <asp:Button ID="btnEnregistrer" runat="server" CssClass="btn btn-primary" Text="Enregistrer les modifications" OnClick="btnEnregistrer_Click" />
                </div>

                <div class="mt-3 text-center">
                    <a href="Admin.aspx" class="btn btn-link">← Retour à la liste des utilisateurs</a>
                </div>
            </div>
        
    </form>
        </div>
    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
