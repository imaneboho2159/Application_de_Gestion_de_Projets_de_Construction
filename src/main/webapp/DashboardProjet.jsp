<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.Model.Projet" %>
<%@ page import="GestionTaches.Model.Tache" %>
<%@ page import="GestionTaches.DAO.TacheDao" %>
<%@ page import="GestionRessorces.DAO.RessorceDao" %>
<%@ page import="GestionRessorces.Model.Ressorce" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="GestionRessorces.DAO.RessorceDao" %>

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
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div class="button-group">
        <a href="ProjectServlet" class="icon-btn btn-custom" title="Retour aux Projets">
            <i class="bi bi-arrow-left"></i>
        </a>
    </div>
</div>

<div class="container">
    <div class="project-details">
        <div class="d-flex justify-content-between align-items-center">
            <h4><%= projet.getNom() %></h4>
            <a href="ModifierServlet?id=<%= projet.getId_projet() %>" class="icon-btn btn-modifier" title="Modifier le Projet">
                <i class="bi bi-pencil"></i>
            </a>
        </div>
        <p><strong>Description:</strong> <%= projet.getDescription() %></p>
        <p><strong>Dates:</strong> <%= projet.getDate_de_Début() %> - <%= projet.getDate_de_Fin() %></p>
        <p><strong>Budget:</strong> DH<%= projet.getBudget() %></p>
    </div>

    <div class="mb-3">
        <div class="button-group">
            <a href="AjouterTache.jsp?projectId=<%= projet.getId_projet() %>" class="icon-btn btn-custom" title="Ajouter une Tâche">
                <i class="bi bi-plus-circle"></i>
            </a>
        </div>
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
                        <a href="AjouterRessource.jsp?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>" class="icon-btn btn-custom" title="Ajouter une Ressource">
                            <i class="bi bi-plus-circle"></i>
                        </a>
                        <a href="ModifierTache?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>" class="icon-btn btn-modifier" title="Modifier la Tâche">
                            <i class="bi bi-pencil"></i>
                        </a>

                        <a href="SupprimerTache?tacheId=<%= tache.getId_tache() %>&projectId=<%= projet.getId_projet() %>"
                           class="icon-btn btn-supprimer"
                           title="Supprimer la Tâche"
                           onclick="return confirm('Voulez-vous supprimer cette tâche ?');">
                            <i class="bi bi-trash"></i>
                        </a>
                    </div>
                </div>
                <%--                <div class="task-resources">--%>
                <%--                    <h6>Ressources :</h6>--%>
                <%--                    <%--%>
                <%--                        List<Ressource> ressources = null;--%>
                <%--                        try {--%>
                <%--                            ressources = ressourceDao.getRessourcesByTacheId(tache.getIdTache());--%>
                <%--                        } catch (SQLException e) {--%>
                <%--                            request.setAttribute("errorMessage", "Erreur lors de la récupération des ressources : " + e.getMessage());--%>
                <%--                        }--%>
                <%--                        if (ressources == null || ressources.isEmpty()) {--%>
                <%--                    %>--%>
                <%--                    <p class="text-muted">Aucune ressource trouvée pour cette tâche.</p>--%>
                <%--                    <% } else { %>--%>
                <%--                    <ul class="list-group">--%>
                <%--                        <% for (Ressource ressource : ressources) { %>--%>
                <%--                        <li class="list-group-item d-flex justify-content-between align-items-center">--%>
                <%--                            <span><%= ressource.getName() %> (Type: <%= ressource.getType() %>, Quantité: <%= ressource.getQuantity() %>)</span>--%>
                <%--                            <div class="button-group">--%>
                <%--                                <a href="ModifierRessource.jsp?ressourceId=<%= ressource.getIdRessource() %>&tacheId=<%= tache.getIdTache() %>&projectId=<%= projet.getIdProjet() %>" class="icon-btn btn-modifier" title="Modifier la Ressource">--%>
                <%--                                    <i class="bi bi-pencil"></i>--%>
                <%--                                </a>--%>
                <%--                                <a href="RessourceServlet?action=delete&ressourceId=<%= ressource.getIdRessource() %>&tacheId=<%= tache.getIdTache() %>&projectId=<%= projet.getIdProjet() %>" class="icon-btn btn-supprimer" title="Supprimer la Ressource" onclick="return confirm('Voulez-vous supprimer cette ressource ?');">--%>
                <%--                                    <i class="bi bi-trash"></i>--%>
                <%--                                </a>--%>
                <%--                            </div>--%>
                <%--                        </li>--%>
                <%--                        <% } %>--%>
                <%--                    </ul>--%>
                <%--                    <% } %>--%>
                <%--                </div>--%>
            </li>
            <% } %>
            <% } %>
        </ul>
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
        <% } %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>