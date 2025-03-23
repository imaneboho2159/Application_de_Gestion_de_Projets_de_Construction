<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.Model.Projet" %>
<%@ page import="GestionTaches.Model.Tache" %>
<%@ page import="GestionTaches.DAO.TacheDao" %>
<%@ page import="GestionRessorces.DAO.RessorceDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Détails du Projet</title>
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
            /* Remove underline */
        }

        .container {
            flex: 1;
            padding: 20px;
        }

        .project-details {
            background: #d9d0b4;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .icon-btn {
            font-size: 16px;
            padding: 8px 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            text-decoration: none !important;
            /* Ensure underline is removed completely */
            color: #7d6b57;
            background-color: transparent;
        }

        .icon-btn:hover {
            color: #FFFFFF;
            background-color: #7d6b57;
            border-radius: 5px;
        }

        .btn-ajouter {
            border: 2px solid #7d6b57;
            color: #7d6b57;
            font-size: 16px;
            font-weight: bold;
            padding: 8px 16px;
            background-color: transparent;
            border-radius: 5px;
            text-decoration: none;
            /* Remove underline */
        }

        .btn-ajouter:hover {
            background-color: #7d6b57;
            color: #FFFFFF;
        }

        .button-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .task-resources {
            margin-left: 20px;
            margin-top: 10px;
        }

        .alert {
            margin-bottom: 20px;
        }

        .list-group-item {
            background: #f8f1e7;
        }
    </style>
</head>

<body>
<%
    Projet projet = (Projet) request.getAttribute("projet");
    TacheDao tacheDao = new TacheDao();
    RessorceDao ressorceDao = new RessorceDao();
    List<Tache> taches = null;

    if (projet == null) {
        response.sendRedirect("ProjectServlet?errorMessage=Aucun projet trouvé avec cet ID");
        return;
    }

    try {
        taches = tacheDao.getTachesByProjetId(projet.getId_projet());
    } catch (SQLException e) {
        request.setAttribute("errorMessage", "Erreur lors de la récupération des tâches : " + e.getMessage());
    }
%>

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
    <div class="project-details">
        <div class="d-flex justify-content-between align-items-center">
            <h4>
                <%= projet.getNom() %>
            </h4>
            <a href="updateServlet?id_projet=<%= projet.getId_projet() %>" class="icon-btn" title="Modifier le Projet">
                <i class="bi bi-pencil"></i>
            </a>
        </div>
        <p><strong>Description:</strong>
            <%= projet.getDescription() %>
        </p>
        <p><strong>Dates:</strong>
            <%= projet.getDate_de_Début() %> -
            <%= projet.getDate_de_Fin() %>
        </p>
        <p><strong>Budget:</strong> DH
            <%= projet.getBudget() %>
        </p>
    </div>

    <div class="mb-3">
        <a href="AjouterTache.jsp?projectId=<%= projet.getId_projet() %>" class="btn-ajouter">Ajouter une Tâche</a>
    </div>

    <div class="mt-4">
        <h5>Liste des Tâches</h5>
        <ul class="list-group mb-4">
            <% if (taches == null) { %>
            <li class="list-group-item text-center text-danger">Erreur: La liste des tâches est null.</li>
            <% } else if (taches.isEmpty()) { %>
            <li class="list-group-item text-center text-danger">Aucune tâche trouvée pour ce projet.</li>
            <% } else { %>
            <% for (Tache tache : taches) { %>
            <li class="list-group-item">
                <div class="d-flex justify-content-between align-items-center">
                    <span><%= tache.getDescription()  %> <%= tache.getId_tache()%>(Début: <%= tache.getDate_de_Début() %>, Fin: <%= tache.getDate_de_Fin() %>)</span>
                    <div class="button-group">
                        <a href="AjouterRessource.jsp?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>" class="icon-btn" title="Ajouter une Ressource">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                        <a href="ModifierTache?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>" class="icon-btn" title="Modifier la Tâche">
                            <i class="bi bi-pencil"></i>
                        </a>
                        <a href="SupprimerTache?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>" class="icon-btn" title="Supprimer la Tâche" onclick="return confirm('Voulez-vous supprimer cette tâche ?');">
                            <i class="bi bi-trash"></i>
                        </a>
                    </div>
                </div>
            </li>
            <% } %>
            <% } %>
        </ul>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>