<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.Model.Projet" %>

<%
    Projet projet = (Projet) request.getAttribute("projet");
    if (projet == null) {
        response.sendRedirect("ListProjetServlet?errorMessage=Aucun projet trouvé avec cet ID");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Détails du Projet</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
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

        .project-details {
            background: #FFFFFF;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .icon-btn {
            font-size: 16px;
            padding: 8px 12px;
            height: 40px;
            line-height: 24px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            text-decoration: none;
            color: #FFFFFF;
        }

        .btn-custom {
            background-color: #D76C82;
        }

        .btn-custom:hover {
            background-color: #B03052;
        }

        .btn-modifier {
            background-color: #f0ad4e;
        }

        .btn-modifier:hover {
            background-color: #c77c2a;
        }

        .btn-supprimer {
            background-color: #d9534f;
        }

        .btn-supprimer:hover {
            background-color: #b52b27;
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
    </style>
</head>

<body>

<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div class="button-group">

        <a href="ProjectServlet" class="icon-btn btn-custom" title="Retour aux Projets"><i class="bi bi-arrow-left"></i></a>
    </div>
</div>

<div class="container">
    <div class="project-details">
        <div class="d-flex justify-content-between align-items-center">
            <h4><%= projet.getNom() %></h4>
            <a href="updateServlet?id=<%= projet.getId_projet() %>" class="icon-btn btn-modifier" title="Modifier le Projet">
                <i class="bi bi-pencil"></i>
            </a>
        </div>
        <p><strong>Description:</strong> Construction d'un immeuble de bureaux moderne.</p>
        <p><strong>Dates:</strong> <%= projet.getDate_de_Début() %> - <%= projet.getDate_de_Fin() %></p>
        <p><strong>Budget:</strong> €<%= projet.getBudget() %></p>
    </div>

    <div class="mb-3">
        <div class="button-group">
            <a href="AddTaskServlet?idProjet=<%= projet.getId_projet() %>" class="icon-btn btn-custom" title="Ajouter une Tâche">
                <i class="bi bi-plus-circle"></i>
            </a>
            <a href="AddResourceServlet?idProjet=<%= projet.getId_projet() %>" class="icon-btn btn-custom" title="Ajouter des Ressources (Projet)">
                <i class="bi bi-box-seam"></i>
            </a>
        </div>
    </div>

    <div class="mt-4">
        <h5>Liste des Tâches</h5>
        <ul class="list-group mb-4">
<%--            &lt;%&ndash; Dynamically fetch tasks from the database &ndash;%&gt;--%>
<%--            <%--%>
<%--                if (projet.getTaches() != null) {--%>
<%--                    for (var tache : projet.getTaches()) {--%>
<%--            %>--%>
<%--            <li class="list-group-item">--%>
<%--                <div class="d-flex justify-content-between align-items-center">--%>
<%--                    <span><%= tache.getNom() %> (Échéance: <%= tache.getDateEcheance() %>)</span>--%>
<%--                    <div class="button-group">--%>
<%--                        <a href="AddResourceToTaskServlet?idProjet=<%= projet.getId_projet() %>&idTache=<%= tache.getId() %>" class="icon-btn btn-custom" title="Ajouter des Ressources">--%>
<%--                            <i class="bi bi-box-seam"></i>--%>
<%--                        </a>--%>
<%--                        <a href="EditTaskServlet?idTache=<%= tache.getId() %>" class="icon-btn btn-modifier" title="Modifier">--%>
<%--                            <i class="bi bi-pencil"></i>--%>
<%--                        </a>--%>
<%--                        <a href="DeleteTaskServlet?idTache=<%= tache.getId() %>" class="icon-btn btn-supprimer" title="Supprimer">--%>
<%--                            <i class="bi bi-trash"></i>--%>
<%--                        </a>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <ul class="list-group task-resources">--%>
<%--                    <%--%>
<%--                        if (tache.getRessources() != null) {--%>
<%--                            for (var ressource : tache.getRessources()) {--%>
<%--                    %>--%>
<%--                    <li class="list-group-item d-flex justify-content-between align-items-center">--%>
<%--                        <%= ressource.getNom() %> - Type: <%= ressource.getType() %>, Quantité: <%= ressource.getQuantite() %>--%>
<%--                        <div class="button-group">--%>
<%--                            <a href="EditResourceServlet?idRessource=<%= ressource.getId() %>" class="icon-btn btn-modifier" title="Modifier">--%>
<%--                                <i class="bi bi-pencil"></i>--%>
<%--                            </a>--%>
<%--                            <a href="DeleteResourceServlet?idRessource=<%= ressource.getId() %>" class="icon-btn btn-supprimer" title="Supprimer">--%>
<%--                                <i class="bi bi-trash"></i>--%>
<%--                            </a>--%>
<%--                        </div>--%>
<%--                    </li>--%>
<%--                    <%--%>
<%--                            }--%>
<%--                        }--%>
<%--                    %>--%>
<%--                </ul>--%>
<%--            </li>--%>
<%--            <%--%>
<%--                    }--%>
<%--                }--%>
<%--            %>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</div>--%>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
