<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjoutClient.aspx.cs" Inherits="PROJETFIN1.AjoutClient" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Ajout Client - Prospect</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
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
            overflow: hidden;
            transition: all 0.3s ease;
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
        .radio-group label {
    display: inline-flex;
    align-items: center;
    margin-right: 20px;
    font-size: 16px;
    color: #4b6cb7;
    font-weight: 500;
}

.radio-group input[type="radio"] {
    margin-right: 6px;
}

.radio-group .icon-oui::before {
    content: "\f058"; /* Font Awesome icon: check-circle */
    font-family: "Font Awesome 6 Free";
    font-weight: 900;
    color: green;
    margin-right: 6px;
}

.radio-group .icon-non::before {
    content: "\f057"; /* Font Awesome icon: times-circle */
    font-family: "Font Awesome 6 Free";
    font-weight: 900;
    color: red;
    margin-right: 6px;
}


        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .logo-container {
    width: 100%;
    height: 160px;
    overflow: hidden;
}

.logo-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
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

        .sidebar.collapsed {
            width: 70px;
        }

        .sidebar.collapsed a {
            text-align: center;
            font-size: 0;
        }

        .sidebar.collapsed a i {
            font-size: 18px;
        }

        .main-content {
            margin-left: 260px;
            padding: 30px;
            transition: margin-left 0.3s ease;
        }

        .sidebar.collapsed + .main-content {
            margin-left: 90px;
        }

        .card-form {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h1 {
            color: #4b6cb7;
            text-align: center;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            color: #4b6cb7;
        }

        input[type="text"], input[type="number"], input[type="email"], textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ddd;
            margin-top: 5px;
            font-size: 14px;
        }

        input:focus, textarea:focus, select:focus {
            border-color: #4b6cb7;
            outline: none;
        }

        .btn-submit {
            background-color: #4b6cb7;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
        }

        .btn-submit:hover {
            background-color: #3551a3;
        }
        .sidebar img {
    width: 100%;
    height: auto;
    display: block;
    margin: 0;
    padding: 0;
    object-fit: cover;
    border-radius: 0;
}

.sidebar.collapsed img {
    width: 40px;
    margin: 0 auto 20px;
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
        <a href="Chargé.aspx"><i class="fas fa-chart-line me-2"></i> Vue d'ensemble</a>
        <a href="AjoutClient.aspx"><i class="fas fa-user-plus me-2"></i> Proposer Client</a>
        <a href="GererDossiers.aspx"><i class="fas fa-folder-open me-2"></i> Gérer Dossiers</a>
                <a href="PlanningVisite.aspx"><i class="fas fa-calendar-check me-2"></i> Consulter Planning Visite</a>

        <a href="AjoutFormVisite.aspx"><i class="fas fa-edit me-2"></i> Formulaire Visite</a>
    </div>

    <div class="main-content">
        <div class="card-form">
            <h1>Ajout d'un Client Prospect</h1>
            <form id="ajoutClientForm" runat="server">
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="Nom">Nom</label>
            <input type="text" id="Nom" runat="server" placeholder="Entrez le nom du client/prospect" />
        </div>
        <div class="col-md-6 mb-3">
            <label for="Secteur">Secteur</label>
            <asp:DropDownList ID="DDLSecteur" runat="server" CssClass="form-select" AutoPostBack="True"
                DataSourceID="SqlSecteur" DataTextField="DESCRIPTION" DataValueField="CODE"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlSecteur" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>"
                ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>"
                SelectCommand="select * from NOMENCLATURE where type_code = '1' order by description"></asp:SqlDataSource>
        </div>
        <div class="col-md-6 mb-3">
            <label for="SousSecteur">Sous-Secteur</label>
            <asp:DropDownList ID="DDLSSecteur" runat="server" CssClass="form-select"
                DataSourceID="SqlSSecteur" DataTextField="DESCRIPTION" DataValueField="CODE"></asp:DropDownList>
            <asp:SqlDataSource ID="SqlSSecteur" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>"
                ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>"
                SelectCommand="select * from NOMENCLATURE where type_code = '2' and PCODE = :pPCODE">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DDLSecteur" Name="pPCODE" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <div class="col-md-6 mb-3">
            <label for="Canal d'acquisition">Canal d'acquisition</label>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-select">
                <asp:ListItem>Evenements</asp:ListItem>
                <asp:ListItem>Email</asp:ListItem>
                <asp:ListItem>Recommandation</asp:ListItem>
                <asp:ListItem>SiteWeb</asp:ListItem>
                <asp:ListItem>Téléphone</asp:ListItem>
                <asp:ListItem>Salon Professionnel</asp:ListItem>
            </asp:DropDownList>
        </div>
        
    <div class="col-md-6 mb-3">
    <label for="NbrEmployes">Nombre d'Employés</label>
    <asp:DropDownList ID="DropDownList3" runat="server" CssClass="form-select">
        <asp:ListItem>1 à 10</asp:ListItem>
        <asp:ListItem>11 à 50</asp:ListItem>
        <asp:ListItem>51 à 100</asp:ListItem>
        <asp:ListItem>101 à 500</asp:ListItem>
        <asp:ListItem>501 à 1000</asp:ListItem>
        <asp:ListItem>1001 à 1500</asp:ListItem>
        <asp:ListItem>1501 à 2000</asp:ListItem>
        <asp:ListItem>Plus de 2000</asp:ListItem>
    </asp:DropDownList>
</div>


    
    <div class="col-md-6 mb-3">
    <label for="DDLWilaya">Wilaya</label>
    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select" DataSourceID="SqlDataSource2" DataTextField="WILAYA" DataValueField="WILAYA" AutoPostBack="True">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT WILAYA FROM ADRESSE  ORDER BY WILAYA"></asp:SqlDataSource>
&nbsp</div>

    

        <div class="col-md-6 mb-3">
    <label for="DDLCommune">Commune</label>
    <asp:DropDownList ID="DDLCommune" runat="server" CssClass="form-select" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="COMMUNE" DataValueField="COMMUNE">
    </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT COMMUNE FROM ADRESSE WHERE WILAYA=:wilaya order by commune">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="wilaya" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
</div>
            <div class="col-md-6 mb-3">
     <label for="CodePostal">Code Postal</label>
 <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlCodePostal" DataTextField="CODE_POSTAL" DataValueField="CODE_POSTAL">
 </asp:DropDownList>
    <asp:SqlDataSource ID="SqlCodePostal" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT CODE_POSTAL FROM ADRESSE WHERE  COMMUNE =:commune and WILAYA=:wilaya order by CODE_POSTAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLCommune" Name="commune" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList2" Name="wilaya" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
&nbsp;</div>


       <!-- Capital, Forme Juridique, Dirigeant et Téléphone -->
<div class="col-md-6 mb-3">
    <label for="Capital">Capital</label>
    <input type="text" class="form-control" id="Capital" name="Capital" value="10000 DA" />
</div>
<div class="col-md-6 mb-3">
    <label for="FormeJuridique">Forme Juridique</label>
    <asp:SqlDataSource ID="DATASOURCEFORMEJURIDIQUE" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DESCRIPTION FROM NOMENCLATURE  WHERE CODE=3 order by DESCRIPTION "></asp:SqlDataSource>
    <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="DATASOURCEFORMEJURIDIQUE" DataTextField="DESCRIPTION" DataValueField="DESCRIPTION">
    </asp:DropDownList>
&nbsp;</div>
<div class="col-md-6 mb-3">
    <label for="Dirigeant">Principal Dirigeant</label>
    <input type="text" id="Dirigeant" runat="server" placeholder="Nom du dirigeant" class="form-control" />
</div>
<div class="col-md-6 mb-3">
    <label for="TelDirigeant">Numéro de téléphone </label>
&nbsp;<input type="text" id="TelDirigeant" runat="server" placeholder="Ex : 0550 00 00 00" class="form-control" />
</div>
  <div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label for="RadioButtonList1">Blacklisté</label>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                <asp:ListItem Text="<span class='icon-oui'>oui</span>" Value="oui" />
                <asp:ListItem Text="<span class='icon-non'>non</span>" Value="non" />
            </asp:RadioButtonList>
        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group">
            <label for="RadioButtonList2">Interdit de chéquier</label>
            <asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                <asp:ListItem Text="<span class='icon-oui'>oui</span>" Value="oui" />
                <asp:ListItem Text="<span class='icon-non'>non</span>" Value="non" />
            </asp:RadioButtonList>
        </div>
    </div>
</div>




        <!-- Besoins à gauche, Type de Rencontre à droite -->
        <div class="col-md-6 mb-3">
            <label for="Besoins">Besoins Exprimés</label>
            <textarea id="Besoins" runat="server" rows="3" class="form-control" placeholder="Quels sont les besoins du prospect ?"></textarea>
        </div>
        <div class="col-md-6 mb-3">
            <label for="TypeRencontreDDL">Type de Rencontre</label>
            <asp:DropDownList ID="TypeRencontreDDL" runat="server" CssClass="form-select">
                <asp:ListItem Text="Présentiel" Value="Présentiel" />
                <asp:ListItem Text="Distanciel" Value="Distanciel" />
                <asp:ListItem Text="Événementiel" Value="Événementiel" />
            </asp:DropDownList>
        </div>

        <!-- Actions -->
        <div class="col-md-6 mb-3">
            <asp:Button ID="BtnSoumettreDirecteur" runat="server" Text="Soumettre au Directeur d'Agence"
                CssClass="btn btn-success w-100" OnClick="BtnSoumettreDirecteur_Click" />
        </div>
        
        <div class="col-md-12 mb-3">
            <asp:Button ID="BtnSubmit" runat="server" Text="Ajouter Client" CssClass="btn btn-submit" OnClick="BtnSubmit_Click" />
        </div>
    </div>
</form>

        </div>
    </div>

    <script>
        const toggleBtn = document.getElementById("toggleSidebar");
        const sidebar = document.querySelector(".sidebar");
        toggleBtn.addEventListener("click", () => {
            sidebar.classList.toggle("collapsed");
        });
    </script>
</body>
</html>