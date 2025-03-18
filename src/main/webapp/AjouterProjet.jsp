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

        .container {
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

<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div>
        <a href="ListProjet.jsp" class="btn btn-custom">Projets</a>
    </div>
</div>

>
<div class="container">
    <div class="form-container">
        <h4>Créer un Projet</h4>
        <form method="post" action="ProjectServlet">
            <div class="mb-2">
                <label for="project-name" class="form-label">Nom</label>
                <input type="text" class="form-control" id="project-name" name="projectName" value="<%= request.getParameter("projectName") != null ? request.getParameter("projectName") : "" %>" required>
            </div>
            <div class="mb-2">
                <label for="project-description" class="form-label">Description</label>
                <textarea class="form-control" id="project-description" name="projectDescription" rows="2" required><%= request.getParameter("projectDescription") != null ? request.getParameter("projectDescription") : "" %></textarea>
            </div>
            <div class="mb-2">
                <label for="start-date" class="form-label">Début</label>
                <input type="date" class="form-control" id="start-date" name="startDate" value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>" required>
            </div>
            <div class="mb-2">
                <label for="end-date" class="form-label">Fin</label>
                <input type="date" class="form-control" id="end-date" name="endDate" value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>" required>
            </div>
            <div class="mb-2">
                <label for="budget" class="form-label">Budget (DH)</label>
                <input type="number" class="form-control" id="budget" name="budget" step="0.01" value="<%= request.getParameter("budget") != null ? request.getParameter("budget") : "" %>" required>
            </div>
            <button type="submit" class="btn btn-custom">Ajouter</button>
        </form>



    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
