<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjoutUser.aspx.cs" Inherits="PROJETFIN1.AjoutUser" %>

<!DOCTYPE html>
<html lang="fr">
<head runat="server">
    <meta charset="UTF-8">
    <title>Ajout Utilisateur</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

        .form-container {
            background: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            margin: auto;
        }

        .form-container h2 {
            margin-bottom: 25px;
            color: var(--primary);
            font-weight: 600;
        }

        .input-field, .dropdown-field {
            width: 100%;
            margin: 10px 0;
            padding: 14px;
            border-radius: 8px;
            border: 1px solid #dcdcdc;
            font-size: 15px;
        }

        .input-field:focus, .dropdown-field:focus {
            border-color: var(--primary);
            outline: none;
        }

        .btn-submit {
            width: 100%;
            padding: 14px;
            border-radius: 8px;
            border: none;
            background: var(--primary);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-submit:hover {
            background: #003060;
        }

        .aspNet-Label {
            display: block;
            margin-top: -6px;
            margin-bottom: 8px;
            font-size: 13px;
            color: red;
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
                    <a href="#"><i class="bi bi-person-plus-fill me-2"></i>Add New User</a>
                    <a href="#"><i class="bi bi-shield-lock-fill me-2"></i>Roles & Permissions</a>
                    <a href="#"><i class="bi bi-folder2-open me-2"></i>View Prospects</a>
                    <a href="#"><i class="bi bi-bar-chart-line-fill me-2"></i>Reports</a>
                    <a href="#"><i class="bi bi-clock-history me-2"></i>User History</a>
                    <a href="#"><i class="bi bi-gear-fill me-2"></i>Settings</a>
                </div>

                <!-- Main Content -->
                <div class="col-md-10 d-flex justify-content-center align-items-center" style="min-height: 100vh;">
                    <div class="form-container">
                        <h2>Ajout Utilisateur</h2>
                        <asp:TextBox ID="txtNom" runat="server" placeholder="Ex: Nom Prénom" CssClass="input-field"></asp:TextBox>
                        <asp:TextBox ID="txtEmail" runat="server" placeholder="Ex: nom.prenom@mail.com" CssClass="input-field"></asp:TextBox>
                        <asp:Label ID="lblEmailError" runat="server" CssClass="aspNet-Label" Visible="false"></asp:Label>
                        <asp:TextBox ID="txtIdentifiant" runat="server" placeholder="Ex: NomPrenom123_" CssClass="input-field"></asp:TextBox>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="dropdown-field">
                            <asp:ListItem Value="">Sélectionner un rôle</asp:ListItem>
                            <asp:ListItem Value="ADMINISTRATEUR">Administrateur</asp:ListItem>
                            <asp:ListItem Value="Chargé d'affaire">Chargé d'affaires</asp:ListItem>
                            <asp:ListItem Value="Direction d'agence">Directeur d'agence</asp:ListItem>
                            <asp:ListItem Value="Comité crédit">Comité crédit</asp:ListItem>
                            <asp:ListItem Value="Direction commercial">Direction commerciale</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Mot de passe sécurisé..." CssClass="input-field"></asp:TextBox>
                        <asp:Button ID="btnEnregistrer" runat="server" Text="Enregistrer" OnClick="btnEnregistrer_Click" CssClass="btn-submit" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
