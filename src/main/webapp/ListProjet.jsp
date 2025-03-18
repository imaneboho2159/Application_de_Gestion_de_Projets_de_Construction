<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.DAO.ProjetDao, GestionProjets.Model.Projet, java.util.List, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert - Projets</title>
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

        .main-content {
            display: flex;
            flex: 1;
        }

        .sidebar {
            width: 250px;
            background-color: #FFFFFF;
            border-right: 2px solid #B03052;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
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

        .project-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .project-card {
            background: #FFFFFF;
            padding: 15px;
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

        .icon-btn[title]:hover:after {
            content: attr(title);
            position: absolute;
            background-color: #333;
            color: #fff;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            z-index: 1;
            white-space: nowrap;
            margin-top: 10px;
        }

        .icon-btn[title]:hover:before {
            content: "";
            position: absolute;
            width: 0;
            height: 0;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            border-bottom: 5px solid #333;
            margin-top: 0px;
            margin-left: -5px;
        }

        .alert {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div class="button-group">

        <a href="AjouterProjet.jsp" class="icon-btn btn-custom" title="Nouveau Projet"><i class="bi bi-plus-circle"></i></a>
    </div>
</div>

<div class="main-content">

    <div class="sidebar">

        <a href="index.jsp">🏠 Accueil</a>
        <a href="projects.jsp">📋 Projets</a>
        <a href="Logout">🚪 Déconnexion</a>
    </div>

    <div class="container-content">
        <div class="project-header">
            <h4>Projects Overview</h4>
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
                        <h5><%= projet.getNom() %></h5>
                        <div class="button-group">
                            <a href="DashboardProjet.jsp<%= projet.getId_projet() %>" class="icon-btn btn-custom" title="Voir"><i class="bi bi-eye"></i></a>
                            <a href="EditeProjet.jsp?id=<%= projet.getId_projet() %>" class="icon-btn btn-modifier" title="Modifier"><i class="bi bi-pencil"></i></a>
                            <a href="ListProjet.jsp?id=<%= projet.getId_projet() %>" class="icon-btn btn-supprimer" title="Supprimer" onclick="return confirm('Voulez-vous supprimer ce projet ?');"><i class="bi bi-trash"></i></a>
                        </div>
                    </div>
                    <p>📅 <%= projet.getDate_de_Début() %> - <%= projet.getDate_de_Fin() %></p>
                    <p>💰 Budget: <%= projet.getBudget() %> DH</p>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
        <% if (successMessage != null) { %>
        <div class="alert alert-success" role="alert"><%= successMessage %></div>
        <% } else if (errorMessage != null) { %>
        <div class="alert alert-danger" role="alert"><%= errorMessage %></div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>