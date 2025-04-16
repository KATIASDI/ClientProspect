<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjoutFormVisite.aspx.cs" Inherits="DashboardFormulaire.AjoutForm" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Ajout Compte Rendu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

               .sidebar {
    width: 240px;
    background: linear-gradient(180deg, #4b6cb7, #182848);
    color: white;
    position: fixed;
    height: 100vh;
    padding: 20px 15px;
    transition: all 0.3s ease;
    overflow: hidden;
}

        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: block;
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .main-content {
            margin-left: 270px;
            padding: 30px;
        }

        .card-form {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        h2 {
            color: #ff66b3;
            text-align: center;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            color: #4a90e2;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ddd;
            margin-top: 5px;
            font-size: 14px;
        }

        input:focus, textarea:focus, select:focus {
            border-color: #ffcc00;
            outline: none;
        }

        .btn-submit {
            background-color: #ffcc00;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 16px;
            margin-top: 20px;
        }

        .btn-submit:hover {
            background-color: #ff9900;
        }

        .btn-back {
            background-color: cornflowerblue;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 6px;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
        }

        @keyframes flip {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(180deg); }
        }

        .page-flip {
            animation: flip 0.6s forwards;
        }

        .stepper-wrapper {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .stepper-item {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            flex: 1;
        }

        .stepper-item::before {
            content: '';
            position: absolute;
            top: 15px;
            left: -50%;
            height: 2px;
            width: 100%;
            background: #b3d4fc;
            z-index: 1;
        }

        .stepper-item:first-child::before {
            content: none;
        }

        .stepper-item .step-counter {
            z-index: 2;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: white;
            border: 2px solid #0d6efd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #0d6efd;
        }

        .stepper-item.active .step-counter {
            background-color: #0d6efd;
            color: white;
        }

        .form-step {
            display: none;
        }

        .form-step.active {
            display: block;
            animation: fadeIn 0.3s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateX(20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .btn-next, .btn-prev, .btn-finish {
            background-color: #0d6efd;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 18px;
            transition: background 0.3s;
        }

        .btn-next:hover, .btn-prev:hover, .btn-finish:hover {
            background-color: #0056b3;
        }
                .logo-container {
    width: 100%;
    height: 160px; /* ou ce que tu veux */
    overflow: hidden;
}

.logo-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
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

.sidebar img {
    width: 100%;
    height: auto; /* ou une valeur fixe si tu veux remplir plus */
    display: block;
    margin: 0;
    padding: 0;
    object-fit: cover; /* pour bien le forcer à remplir sans déformer */
    border-radius: 0; /* s’il y avait des arrondis */
}


.sidebar.collapsed img {
    width: 40px;
    margin: 0 auto 20px;
}

.main-content {
    margin-left: 260px;
    transition: margin-left 0.3s ease;
}

.sidebar.collapsed + .main-content {
    margin-left: 90px;
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

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
            <h2>Compte Rendu de Visite</h2>

            <div class="stepper-wrapper">
                <div class="stepper-item active" id="stepper-1">
                    <div class="step-counter">1</div>
                </div>
                <div class="stepper-item" id="stepper-2">
                    <div class="step-counter">2</div>
                </div>
                <div class="stepper-item" id="stepper-3">
                    <div class="step-counter">3</div>
                </div>
            </div>

            <form runat="server">
                <!-- Step 1 -->
                <div class="form-step active" id="step1">
                    <div class="mb-3">
                        <label for="txtRaisonSociale">Nom complet ou raison sociale :</label>
                        <input type="text" runat="server" id="txtRaisonSociale" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtActivite">Activité :</label>
                        <input type="text" runat="server" id="txtActivite" class="form-control" />
                    </div>
                    <button type="button" class="btn-next" onclick="nextStep(1)">Suivant →</button>
                </div>

                <!-- Step 2 -->
                <div class="form-step" id="step2">
                    <div class="mb-3">
                        <label for="DropDownList1">Secteur :</label>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlSecteur" DataTextField="DESCRIPTION" DataValueField="CODE" class="form-control"></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlSecteur" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionStringProspect %>" ProviderName="<%$ ConnectionStrings:ConnectionStringProspect.ProviderName %>" SelectCommand="SELECT code, DESCRIPTION FROM NOMENCLATURE where type_code=1 order by DESCRIPTION"></asp:SqlDataSource>
                    </div>
                    <div class="mb-3">
                        <label for="txtAdresse">Adresse :</label>
                        <textarea runat="server" id="txtAdresse" class="form-control"></textarea>
                    </div>
                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn-prev" onclick="prevStep(2)">← Retour</button>
                        <button type="button" class="btn-next" onclick="nextStep(2)">Suivant →</button>
                    </div>
                </div>

                <!-- Step 3 -->
                <div class="form-step" id="step3">
                    <div class="mb-3">
                        <label for="txtContact">N° de téléphone / fax / Email :</label>
                        <input type="text" runat="server" id="txtContact" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtGerant">Gérant de la société :</label>
                        <input type="text" runat="server" id="txtGerant" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtDistribution">Distribution des parts sociales :</label>
                        <input type="text" runat="server" id="txtDistribution" class="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="txtReputation">Réputation et moralité :</label>
                        <textarea runat="server" id="txtReputation" class="form-control"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="txtSolvabilite">Solvabilité des associés :</label>
                        <textarea runat="server" id="txtSolvabilite" class="form-control"></textarea>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button type="button" class="btn-prev" onclick="prevStep(3)">← Retour</button>
                        <button type="submit" runat="server" class="btn-finish" onserverclick="BtnSubmit_Click">Enregistrer</button>
                    </div>
                    <button type="button" class="btn-back" onclick="flipPage('Chargé.aspx')">Retour a l'acceuil</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        let currentStep = 1;
        const totalSteps = 3;

        function updateStepView() {
            for (let i = 1; i <= totalSteps; i++) {
                document.getElementById("step" + i).classList.remove("active");
                document.getElementById("stepper-" + i).classList.remove("active");
            }
            document.getElementById("step" + currentStep).classList.add("active");
            document.getElementById("stepper-" + currentStep).classList.add("active");
        }

        function nextStep(step) {
            if (step < totalSteps) {
                currentStep++;
                updateStepView();
            }
        }

        function prevStep(step) {
            if (step > 1) {
                currentStep--;
                updateStepView();
            }
        }

        window.onload = updateStepView;

        function flipPage(url) {
            document.body.classList.add('page-flip');
            setTimeout(function () {
                window.location.href = url;
            }, 200);
        }
        
            document.getElementById("toggleSidebar").addEventListener("click", function () {
                document.querySelector(".sidebar").classList.toggle("collapsed");
    });
    </script>

   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>