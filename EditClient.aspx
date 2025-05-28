<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditClient.aspx.cs" Inherits="PROJETFIN1.EditClient" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Modifier Client - Prospect</title>
    <!-- CSS identiques à AjoutClient.aspx -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        /* même style que dans AjoutClient.aspx */
        :root {
            --primary: #00529B;
            --secondary: #007BFF;
            --accent: #D4E6F1;
            --background: #F7F9FB;
            --beige: #C6B18D;
            --text-color: #333333;
            --card-bg: rgba(255, 255, 255, 0.8);
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--background);
            min-height: 100vh;
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
            display: block;
            margin-bottom: 1rem;
        }
        .main-content {
            padding: 30px;
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
        input, select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .btn-submit {
            background-color: #4b6cb7;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar">
                <div class="text-center mb-4">
                    <img src="Logo1m.png" class="img-fluid logo-img" />
                </div>
                <a href="Dashboard.aspx"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                <a href="AjoutClient.aspx"><i class="bi bi-person-lines-fill me-2"></i>Add New Prospect</a>
                <a href="Process.aspx"><i class="bi bi-list-check me-2"></i>View Prospect</a>
            </div>
            <!-- Contenu principal -->
            <div class="col-md-10 main-content">
                <div class="card-form">
                    <h1>Modifier un Client Prospect</h1>
                    <form id="formEditClient" runat="server">
                        <asp:HiddenField ID="HiddenClientId" runat="server" />
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="TBNom">Nom</label>
                                <asp:TextBox ID="TBNom" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="DDLSecteur">Secteur</label>
                                <asp:DropDownList ID="DDLSecteur" runat="server" CssClass="form-select"
                                    DataSourceID="SqlSecteur" DataTextField="DESCRIPTION" DataValueField="CODE">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlSecteur" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>"
                                    ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>"
                                    SelectCommand="SELECT * FROM NOMENCLATURE WHERE TYPE_CODE = '1' ORDER BY DESCRIPTION"></asp:SqlDataSource>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="DDLSSecteur">Sous-Secteur</label>
                                <asp:DropDownList ID="DDLSSecteur" runat="server" CssClass="form-select"
                                    DataSourceID="SqlSSecteur" DataTextField="DESCRIPTION" DataValueField="CODE">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlSSecteur" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>"
                                    ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>"
                                    SelectCommand="SELECT * FROM NOMENCLATURE WHERE TYPE_CODE = '2' AND PCODE = :pPCODE">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="pPCODE" ControlID="DDLSecteur" PropertyName="SelectedValue" />
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
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="DropDownList2" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
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
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="DropDownList3" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
</div>


    
    <div class="col-md-6 mb-3">
    <label for="DDLWilaya">Wilaya</label>
    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-select" DataSourceID="SqlDataSource2" DataTextField="NOMWILAYA" DataValueField="NOMWILAYA" AutoPostBack="True">
    </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="DropDownList2" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
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
    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Le capital ne doit pas etre inferieur ou égale a 0" ForeColor="Red" ValidationExpression="^[1-9]\d*(,\d+)?$" ControlToValidate="TBCapital"></asp:RegularExpressionValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TBCapital" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;</div>
<div class="col-md-6 mb-3">
    <label for="FormeJuridique">Forme Juridique</label>
    <asp:SqlDataSource ID="DATASOURCEFORMEJURIDIQUE" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT DESCRIPTION FROM NOMENCLATURE  WHERE TYPE_CODE=3 order by DESCRIPTION "></asp:SqlDataSource>
    <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="DATASOURCEFORMEJURIDIQUE" DataTextField="DESCRIPTION" DataValueField="DESCRIPTION" AutoPostBack="True">
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="DropDownList6" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
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
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TBAdresse" ErrorMessage="Champ obligatoire " ForeColor="Red"></asp:RequiredFieldValidator>
&nbsp;</div>
                <div class="col-md-6 mb-3">
    <label for="E-mail">E-mail</label>
    <asp:TextBox ID="TBEMAIL" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TBEMAIL" ErrorMessage="Obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBEMAIL" ErrorMessage="Email non valide" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
</div>

<!-- Téléphones -->
<div class="mb-3">
    <label class="form-label">Numéro de téléphone</label>
    <div id="telephones-container">
        <asp:TextBox ID="TBNumTel" runat="server"></asp:TextBox>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Numéro de télephone non valide " ForeColor="Red" ControlToValidate="TBNumTel" ValidationExpression="^(0)(5[0-9]|6[0-9]|7[0-9]|2[0-9])\d{7}$"></asp:RegularExpressionValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TBNumTel" ErrorMessage="Champs Obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
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
            <asp:TextBox ID="TBBesoins" runat="server" Height="100px" MaxLength="200" TextMode="MultiLine" ></asp:TextBox>
&nbsp;</div>
        <div class="col-md-6 mb-3">
            <label for="TypeRencontreDDL">Type de Rencontre</label>
            <asp:DropDownList ID="TypeRencontreDDL" runat="server" CssClass="form-select" >
                <asp:ListItem Text="Présentiel" Value="Présentiel" />
                <asp:ListItem Text="Distanciel" Value="Distanciel" />
                <asp:ListItem Text="Événementiel" Value="Événementiel" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="TypeRencontreDDL" ErrorMessage="Champ obligatoire" ForeColor="Red"></asp:RequiredFieldValidator>
        </div>

       

                            <!-- Ajoute ici d'autres champs selon les besoins -->
                        </div>
                        <asp:Button ID="btnUpdate" runat="server" Text="Mettre à jour" CssClass="btn-submit" OnClick="btnUpdate_Click" />
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
