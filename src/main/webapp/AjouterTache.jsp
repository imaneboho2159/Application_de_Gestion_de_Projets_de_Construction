<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Ajouter une Tache</title>
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
        <h4 class="mb-3">Ajouter une Tâche</h4>
        <form action="TacheServlet" method="post">

            <div class="mb-3">
                <label for="task-description" class="form-label">Description</label>
                <textarea class="form-control" id="task-description" name="taskDescription" rows="2" required></textarea>
            </div>

            <div class="mb-3">
                <label for="start-date" class="form-label">Date de Début</label>
                <input type="date" class="form-control" id="start-date" name="startDate" required>
            </div>

            <div class="mb-3">
                <label for="end-date" class="form-label">Date de Fin</label>
                <input type="date" class="form-control" id="end-date" name="endDate" required>
            </div>

            <% String projectId = request.getParameter("projectId");
                if (projectId != null && projectId.matches("\\d+")) { %>
            <input type="hidden" name="projectId" value="<%= projectId %>">
            <% } else { %>
            <div class="alert alert-danger" role="alert">Erreur : ID du projet manquant ou invalide !</div>
            <% } %>

            <button type="submit" class="btn-custom">Valider</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>