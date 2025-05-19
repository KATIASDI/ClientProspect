<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjoutClient.aspx.cs" Inherits="PROJETFIN1.AjoutClient" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Ajout Client - Prospect</title>
    <!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
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


        



        .main-content {
            margin-left:  0 px;
            padding: 30px;
            transition: margin-left 0.3s ease;
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


       

    </style>
</head>
<body>
<!-- Bouton Hamburger -->
<button class="btn d-md-none" id="toggleSidebar" style="position: absolute; top: 1rem; left: 1rem; z-index: 1050;">
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
    <div style="width: 25px; height: 3px; background-color: white; margin: 5px 0;"></div>
</button>
    <div class="container-fluid">
    <div class="row">

<!-- Sidebar -->
        <div class="col-md-2 sidebar d-flex flex-column">
    <div class="text-center mb-4">
        <img src="Logo1m.png" alt="Housing Bank Logo" class="img-fluid logo-img">
   
                                           </div>
                        <a href="Dashboard.aspx"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>

<a href="AjoutClient.aspx"><i class="bi bi-person-lines-fill me-2"></i>Add New Prospect</a>
<a href="Process.aspx"><i class="bi bi-list-check me-2"></i>View Prospect</a>
                </div>
        <!-- Contenu principal -->
        <div class="col-md-10 main-content">
        <div class="card-form">
            <h1>Ajout d'un Client Prospect</h1>
            <form id="ajoutClientForm" runat="server">
    <div class="row">
        <div class="col-md-6 mb-3">
            <label for="Nom">Nom</label>&nbsp;
            <asp:TextBox ID="TBNom" runat="server" MaxLength="30"></asp:TextBox>
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
    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select" DataSourceID="SqlDataSource2" DataTextField="NOMWILAYA" DataValueField="NOMWILAYA" AutoPostBack="True">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT NOMWILAYA FROM WILAYA ORDER BY NOMWILAYA"></asp:SqlDataSource>
&nbsp</div>

    

      <%--  <div class="col-md-6 mb-3">
    <label for="DDLCommune">Commune</label>
    <asp:DropDownList ID="DDLCommune" runat="server" CssClass="form-select" AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="COMMUNE" DataValueField="COMMUNE">
    </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT COMMUNE FROM ADRESSE order by commune">
            </asp:SqlDataSource>
</div>
            <div class="col-md-6 mb-3">
     <label for="CodePostal">Code Postal</label>
 <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="SqlCodePostal" DataTextField="CODE_POSTAL" DataValueField="CODE_POSTAL">
 </asp:DropDownList>
    <asp:SqlDataSource ID="SqlCodePostal" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DISTINCT CODE_POSTAL FROM ADRESSE WHERE  COMMUNE =:commune
order by CODE_POSTAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLCommune" Name="commune" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
&nbsp;</div>--%>


       <!-- Capital, Forme Juridique, Dirigeant et Téléphone -->
<div class="col-md-6 mb-3">
    <label for="Capital">Capital (en DZD)</label>
    <asp:TextBox ID="TBCapital" runat="server" ></asp:TextBox>
&nbsp;</div>
<div class="col-md-6 mb-3">
    <label for="FormeJuridique">Forme Juridique</label>
    <asp:SqlDataSource ID="DATASOURCEFORMEJURIDIQUE" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DESCRIPTION FROM NOMENCLATURE  WHERE TYPE_CODE=3 order by DESCRIPTION "></asp:SqlDataSource>
    <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="DATASOURCEFORMEJURIDIQUE" DataTextField="DESCRIPTION" DataValueField="DESCRIPTION" AutoPostBack="True">
    </asp:DropDownList>
&nbsp;</div>
<div class="mb-3">
    <label class="form-label">Principal Dirigeant</label>
    <div id="dirigeants-container">
        <div class="input-group mb-2">
            <input type="text" name="dirigeant[]" class="form-control" placeholder="Nom du dirigeant">
            <button type="button" class="btn btn-outline-primary" onclick="ajouterChamp('dirigeants-container', 'dirigeant[]')">+</button>
        </div>
    </div>
</div>
        <div class="col-md-6 mb-3">
    <label for="Adresse">Adresse</label>
    <asp:TextBox ID="TBAdresse" runat="server" ></asp:TextBox>
&nbsp;</div>
                <div class="col-md-6 mb-3">
    <label for="E-mail">E-mail</label>
    <asp:TextBox ID="TBEMAIL" runat="server" ></asp:TextBox>
</div>

<!-- Téléphones -->
<div class="mb-3">
    <label class="form-label">Numéro de téléphone</label>
    <div id="telephones-container">
        <asp:TextBox ID="TBNumTel" runat="server"></asp:TextBox>
    </div>
    &nbsp;
</div>

  <div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label for="RadioButtonList1">Blacklisté</label>
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                <asp:ListItem Text="<span class='icon-oui'>oui</span>" Value="oui" />
                <asp:ListItem Text="<span class='icon-non'>non</span>" Selected="True"  Value="non" />
            </asp:RadioButtonList>
        </div>
    </div>

    <div class="col-md-6">
        <div class="form-group">
            <label for="RadioButtonList2">Interdit de chéquier</label>
            <asp:RadioButtonList ID="RadioButtonList2" runat="server" RepeatDirection="Horizontal" CssClass="radio-group">
                <asp:ListItem Text="<span class='icon-oui'>oui</span>" Value="oui" />
                <asp:ListItem Text="<span class='icon-non'>non</span>" Selected="True"  Value="non" />
            </asp:RadioButtonList>
        </div>
    </div>
</div>




        <!-- Besoins à gauche, Type de Rencontre à droite -->
        <div class="col-md-6 mb-3">
            <label for="Besoins">Commentaire</label>
            <asp:TextBox ID="TBBesoins" runat="server" Height="100px" MaxLength="200" TextMode="MultiLine" OnTextChanged="TBBesoins_TextChanged"></asp:TextBox>
&nbsp;</div>
        <div class="col-md-6 mb-3">
            <label for="TypeRencontreDDL">Type de Rencontre</label>
            <asp:DropDownList ID="TypeRencontreDDL" runat="server" CssClass="form-select" OnSelectedIndexChanged="TypeRencontreDDL_SelectedIndexChanged">
                <asp:ListItem Text="Présentiel" Value="Présentiel" />
                <asp:ListItem Text="Distanciel" Value="Distanciel" />
                <asp:ListItem Text="Événementiel" Value="Événementiel" />
            </asp:DropDownList>
        </div>

       

        <!-- Actions -->
       
        
        <div class="col-md-12 mb-3">
            <asp:Button ID="BtnSubmit" runat="server" Text="Ajouter Client" CssClass="btn btn-submit" OnClick="BtnSubmit_Click" />
        </div>
    </div>
</form>

        </div>
    </div>
          </div>
</div>
    <script>
        function ajouterChamp(containerId, name) {
            const container = document.getElementById(containerId);

            const group = document.createElement('div');
            group.className = 'input-group mb-2';

            const input = document.createElement('input');
            input.type = 'text';
            input.name = name;
            input.className = 'form-control';
            input.placeholder = (name === 'dirigeant[]') ? 'Nom du dirigeant' : 'Numéro de téléphone';

            const bouton = document.createElement('button');
            bouton.type = 'button';
            bouton.className = 'btn btn-outline-danger';
            bouton.textContent = '-';
            bouton.onclick = () => group.remove();

            group.appendChild(input);
            group.appendChild(bouton);

            container.appendChild(group);
        }
    </script>

    <script>
        const toggleBtn = document.getElementById("toggleSidebar");
        const sidebar = document.querySelector(".sidebar");
        toggleBtn.addEventListener("click", () => {
            sidebar.classList.toggle("collapsed");
        });
    </script>
    <script>
        document.getElementById('toggleSidebar').addEventListener('click', function () {
            document.querySelector('.sidebar').classList.toggle('active');
        });
    </script>
</body>
</html>