<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionTaches.DAO.TacheDao, GestionTaches.Model.Tache, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Modifier une Tâche</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #EBE8DB;
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: #FFFFFF;
            border-bottom: 2px solid #B03052;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 20px;
            font-weight: bold;
            color: #B03052;
        }

        .navbar-brand {
            color: #B03052;
            font-weight: bold;
        }

        .main-content {
            display: flex;
            flex: 1;
        }

        .sidebar h3 {
            color: #B03052;
            margin-bottom: 20px;
        }

        .sidebar a {
            text-decoration: none;
            color: #B03052;
            font-size: 18px;
            padding: 10px 0;
            width: 100%;
            display: block;
        }

        .sidebar a:hover {
            background-color: #D76C82;
            color: #FFFFFF;
            border-radius: 5px;
            padding-left: 10px;
        }

        .container-content {
            flex: 1;
            padding: 20px;
        }

        .form-container {
            background: #FFFFFF;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .btn-custom {
            background-color: #D76C82;
            color: #FFFFFF;
            border: none;
            font-size: 16px;
            padding: 10px;
        }

        .btn-custom:hover {
            background-color: #B03052;
        }
    </style>
</head>

<body>
<%
    Tache tache = (Tache) request.getAttribute("tache");
    String projectId = (String) request.getAttribute("projectId");
    if (tache == null) {
        response.sendRedirect("DashboardProjet.jsp?errorMessage=Aucune tâche trouvée");
        return;
    }
    if (projectId == null) {
        response.sendRedirect("DashboardProjet.jsp?errorMessage=ID du projet manquant");
        return;
    }
%>

<!-- Navbar -->
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div>
        <a href="DashboardProjet.jsp" class="btn btn-custom">Retour aux Projet</a>
    </div>
</div>

<div class="main-content">
    <div class="container-content">
        <div class="form-container">
            <h4>Modifier une Tâche</h4>
            <form action="ModifierTache" method="Post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="tacheId" value="<%= tache.getId_tache() %>">
                <input type="hidden" name="projectId" value="<%= projectId %>">
                <div class="mb-2">
                    <label for="task-description" class="form-label">Description</label>
                    <textarea class="form-control" id="task-description" name="taskDescription" rows="2" required><%= tache.getDescription() %></textarea>
                </div>
                <div class="mb-2">
                    <label for="start-date" class="form-label">Date de Début</label>
                    <input type="date" class="form-control" id="start-date" name="startDate" value="<%= tache.getDate_de_Début() %>" required>
                </div>
                <div class="mb-2">
                    <label for="end-date" class="form-label">Date de Fin</label>
                    <input type="date" class="form-control" id="end-date" name="endDate" value="<%= tache.getDate_de_Fin() %>" required>
                </div>
                <button type="submit" class="btn btn-custom">Valider</button>
            </form>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>