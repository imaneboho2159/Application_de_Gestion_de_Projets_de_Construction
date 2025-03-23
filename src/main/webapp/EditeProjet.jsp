<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.Model.Projet, GestionProjets.DAO.ProjetDao" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    String idParam = request.getParameter("id_projet");
    Projet projet = null;
    String errorMessage = null;

    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            int projectId = Integer.parseInt(idParam);
            ProjetDao projetDao = new ProjetDao();
            projet = projetDao.getProjetById(projectId);
            if (projet == null) {
                errorMessage = "Aucun projet trouvé avec l'identifiant spécifié.";
            }
        } catch (NumberFormatException e) {
            errorMessage = "L'identifiant du projet doit être un nombre valide.";
        }
    } else {
        errorMessage = "Aucun identifiant de projet fourni.";
    }
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Modifier le Projet</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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
            text-decoration: none;
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

        .btn-custom {
            border: 2px solid #7d6b57;
            color: #7d6b57;
            font-size: 16px;
            font-weight: bold;
            padding: 8px 16px;
            background-color: transparent;
            border-radius: 5px;
            text-decoration: none;
        }

        .btn-custom:hover {
            background-color: #7d6b57;
            color: #FFFFFF;
        }

        .alert {
            margin-bottom: 20px;
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
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
        <% } else { %>
        <h4 class="mb-3">Modifier le Projet</h4>
        <form action="updateServlet" method="post">
            <input type="hidden" name="id_projet" value="<%= projet.getId_projet() %>">

            <div class="mb-3">
                <label for="project-name" class="form-label">Nom</label>
                <input type="text" class="form-control" id="project-name" name="nom" value="<%= projet.getNom() %>" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" required><%= projet.getDescription() %></textarea>
            </div>

            <div class="mb-3">
                <label for="start-date" class="form-label">Début</label>
                <input type="date" class="form-control" id="start-date" name="date_debut" value="<%= projet.getDate_de_Début() %>" required>
            </div>

            <div class="mb-3">
                <label for="end-date" class="form-label">Fin</label>
                <input type="date" class="form-control" id="end-date" name="date_fin" value="<%= projet.getDate_de_Fin() %>" required>
            </div>

            <div class="mb-3">
                <label for="budget" class="form-label">Budget (DH)</label>
                <input type="number" class="form-control" id="budget" name="budget" step="0.01" value="<%= projet.getBudget()%>" required>
            </div>

            <button type="submit" class="btn-custom">Valider</button>
        </form>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>