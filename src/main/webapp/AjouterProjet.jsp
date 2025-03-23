<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="GestionProjets.DAO.ProjetDao, GestionProjets.Model.Projet, java.sql.Date" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Ajouter un Projet</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1ddbf;
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: #d9d0b4;
            border-bottom: 2px solid #7d6b57;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
            color: #7d6b57;
        }

        .navbar-brand {
            color: #7d6b57;
            font-weight: bold;
        }

        .btn-custom {
            border: 2px solid #7d6b57;
            color: #7d6b57;
            font-size: 16px;
            font-weight: bold;
            padding: 10px 20px;
            background-color: transparent;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-custom:hover {
            background-color: #7d6b57;
            color: #FFFFFF;
        }

        .container {
            flex: 1;
            padding: 20px;
        }

        .form-container {
            background: #d9d0b4;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #7d6b57;">Xpert</span></a>
    <div>
        <form action="ProjectServlet">
            <input name="action" type="hidden" value="list">
            <button type="submit" class="btn-custom">Projets</button>
        </form>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h4>Créer un Projet</h4>
        <form method="post" action="ProjectServlet">
            <div class="mb-2">
                <label for="project-name" class="form-label">Nom</label>
                <input type="text" class="form-control" id="project-name" name="projectName" value="<%= request.getParameter(" projectName ") != null ? request.getParameter("projectName ") : " " %>" required>
            </div>
            <div class="mb-2">
                <label for="project-description" class="form-label">Description</label>
                <textarea class="form-control" id="project-description" name="projectDescription" rows="2" required><%= request.getParameter("projectDescription") != null ? request.getParameter("projectDescription") : "" %></textarea>
            </div>
            <div class="mb-2">
                <label for="start-date" class="form-label">Début</label>
                <input type="date" class="form-control" id="start-date" name="startDate" value="<%= request.getParameter(" startDate ") != null ? request.getParameter("startDate ") : " " %>" required>
            </div>
            <div class="mb-2">
                <label for="end-date" class="form-label">Fin</label>
                <input type="date" class="form-control" id="end-date" name="endDate" value="<%= request.getParameter(" endDate ") != null ? request.getParameter("endDate ") : " " %>" required>
            </div>
            <div class="mb-2">
                <label for="budget" class="form-label">Budget (DH)</label>
                <input type="number" class="form-control" id="budget" name="budget" step="0.01" value="<%= request.getParameter(" budget ") != null ? request.getParameter("budget ") : " " %>" required>
            </div>
            <button type="submit" class="btn-custom">Ajouter</button>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const form = document.querySelector("form");
        const startDateInput = document.getElementById("start-date");
        const endDateInput = document.getElementById("end-date");
        const budgetInput = document.getElementById("budget");

        form.addEventListener("submit", function(event) {
            const today = new Date().toISOString().split("T")[0];
            const startDate = startDateInput.value;
            const endDate = endDateInput.value;
            const budget = budgetInput.value;
            let isValid = true;
            let errorMessage = "";

            const startDateObj = new Date(startDate);
            const endDateObj = new Date(endDate);
            const todayObj = new Date();

            if (startDateObj < todayObj) {
                errorMessage += "La date de début ne doit pas être dans le passé.\n";
                isValid = false;
            }

            if (endDateObj <= startDateObj) {
                errorMessage += "La date de fin doit être après la date de début.\n";
                isValid = false;
            }

            if (budget === "" || parseFloat(budget) <= 0) {
                errorMessage += "Le budget doit être un nombre positif.\n";
                isValid = false;
            }

            if (!isValid) {
                alert(errorMessage);
                event.preventDefault();
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>