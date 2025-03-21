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
    <style>
        /* Votre CSS reste inchangé */
    </style>
</head>

<body>
<!-- Navbar -->
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div>
        <a href="ProjectServlet" class="btn btn-custom">Retour aux Projets</a>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger" role="alert">
            <%= errorMessage %>
        </div>
        <% } else { %>
        <h4>Modifier le Projet</h4>
        <form action="updateServlet" method="post">
            <input type="hidden" name="id_projet" value="<%= projet.getId_projet() %>">

            <div class="mb-2">
                <label for="project-name" class="form-label">Nom</label>
                <input type="text" class="form-control" id="project-name" name="nom"
                       value="<%= projet.getNom() %>" required>
            </div>

            <div class="mb-2">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3" required><%= projet.getDescription() %></textarea>
            </div>

            <div class="mb-2">
                <label for="start-date" class="form-label">Début</label>
                <input type="date" class="form-control" id="start-date" name="date_debut"
                       value="<%= projet.getDate_de_Début() %>" required>
            </div>
            <div class="mb-2">
                <label for="end-date" class="form-label">Fin</label>
                <input type="date" class="form-control" id="end-date" name="date_fin"
                       value="<%= projet.getDate_de_Fin() %>" required>
            </div>
            <div class="mb-2">
                <label for="budget" class="form-label">Budget (DH)</label>
                <input type="number" class="form-control" id="budget" name="budget"
                       step="0.01" value="<%= projet.getBudget()%>" required>
            </div>
            <button type="submit" class="btn btn-custom">Valider</button>
        </form>
        <% } %>
    </div>
</div>

<script>
    /* Votre JavaScript reste inchangé */
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>