<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="GestionProjets.DAO.ProjetDao, GestionProjets.Model.Projet, java.sql.Date" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert Services Solution</title>

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
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .content-wrapper {
            display: flex;
            max-width: 1000px;
            width: 100%;
            height: 80vh;
            margin: 0 auto;
        }

        .left-side {
            width: 50%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .right-side {
            width: 50%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            text-align: left;
            padding-left: 30px;
        }

        .image-container img {
            width: 100%;
            height: 100%;
            max-width: none;
            object-fit: cover;
            border-radius: 10px;
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
            color: #FFFFFF;
        }
    </style>
</head>

<body>
<div class="navbar">
    <a href="index.jsp" class="navbar-brand">Construction<span style="color: #D76C82;">Xpert</span></a>
    <div>
        <form action="ProjectServlet">
            <input name="action" type="hidden" value="list">
            <button type="submit" class="btn btn-custom">Projets</button>
        </form>
    </div>
</div>

<div class="container">
    <div class="content-wrapper">
        <div class="left-side">
            <div class="image-container">
                <img src="images/pexels-thirdman-5584052%20(1).jpg" alt="Image">
            </div>
        </div>

        <div class="right-side">
            <h2>Bienvenue sur ConstructionXpert</h2>
            <p>Une solution complète pour gérer vos projets de construction avec efficacité. Suivez l'avancement, organisez vos tâches et collaborez facilement avec votre équipe.</p>

            <a href="AjouterProjet.jsp" class="btn btn-custom">Ajouter un Projet</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>