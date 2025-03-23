<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.DAO.ProjetDao, GestionProjets.Model.Projet, java.util.List, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Projets</title>
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
        }

        .navbar .btn-ajouter {
            border: 2px solid #7d6b57;
            color: #7d6b57;
            font-size: 16px;
            font-weight: bold;
            padding: 8px 16px;
            background-color: transparent;
            border-radius: 5px;
            text-decoration: none;
        }

        .navbar .btn-ajouter:hover {
            background-color: #7d6b57;
            color: #FFFFFF;
        }

        .main-content {
            display: flex;
            flex: 1;
        }

        .container-content {
            flex: 1;
            padding: 20px;
        }

        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .project-card {
            background: #d9d0b4;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        /* Updated button style: No border, simplified */

        .icon-btn {
            font-size: 16px;
            padding: 8px 12px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: #7d6b57;
            /* Text color */
            background-color: transparent;
            /* Transparent background */
            border: none;
            /* No border */
        }

        .icon-btn:hover {
            color: #7d6b57;
            background-color: rgba(125, 107, 87, 0.1);
            /* Subtle background on hover */
        }

        .button-group {
            display: flex;
            align-items: center;
            gap: 10px;
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
    <a href="AjouterProjet.jsp" class="btn-ajouter">Ajouter un Projet</a>
</div>

<div class="container-content">
    <div class="project-header">
        <h4>Projets</h4>
    </div>

    <%
        List<Projet> projets = (List<Projet>) request.getAttribute("projets");
        String successMessage = request.getParameter("successMessage");
        String errorMessage = request.getParameter("errorMessage");

        if (projets == null || projets.isEmpty()) {
    %>
    <div class="alert alert-warning" role="alert">Aucun projet trouvé.</div>
    <% } else { %>
    <div class="row">
        <% for (Projet projet : projets) { %>
        <div class="col-md-6">
            <div class="project-card">
                <div class="d-flex justify-content-between align-items-center">
                    <h5>
                        <%= projet.getNom() %>
                    </h5>
                    <div class="button-group">
                        <a href="ViewProjetServlet?id_projet=<%= projet.getId_projet() %>" class="icon-btn" title="Voir">
                            <i class="bi bi-eye"></i>
                        </a>
                        <a href="updateServlet?id_projet=<%= projet.getId_projet() %>" class="icon-btn" title="Modifier">
                            <i class="bi bi-pencil"></i>
                        </a>
                        <a href="supprimerServlet?id_projet=<%= projet.getId_projet() %>" class="icon-btn" title="Supprimer" onclick="return confirm('Voulez-vous supprimer ce projet ?');">
                            <i class="bi bi-trash"></i>
                        </a>
                    </div>
                </div>
                <p>📅
                    <%= projet.getDate_de_Début() %> -
                    <%= projet.getDate_de_Fin() %>
                </p>
                <p>💰 Budget:
                    <%= projet.getBudget() %> DH</p>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>

    <% if (successMessage != null) { %>
    <div class="alert alert-success" role="alert">
        <%= successMessage %>
    </div>
    <% } else if (errorMessage != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= errorMessage %>
    </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>