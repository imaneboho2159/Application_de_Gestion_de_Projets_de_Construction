package GestionProjets.Servlet;

import GestionProjets.DAO.ProjetDao;
import GestionProjets.Model.Projet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.Date;
import java.util.List;


@WebServlet("/ProjectServlet")
public class ProjetServlet extends HttpServlet {
    public ProjetDao projetDao;

    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();

    }

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Projet> projets = projetDao.getProjetList();
        request.setAttribute("projets", projets);
        System.out.println("Nombre de projets récupérés: " + projets.size());
        RequestDispatcher dispatcher = request.getRequestDispatcher("ListProjet.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            String Nom = req.getParameter("projectName");
            String description = req.getParameter("projectDescription");
            Date Date_de_Debut = java.sql.Date.valueOf(req.getParameter("startDate"));
            Date Date_de_Fin = java.sql.Date.valueOf(req.getParameter("endDate"));
            Double Budget = Double.parseDouble(req.getParameter("budget"));
            if (Nom == null || description == null || Date_de_Debut == null || Date_de_Fin == null || Budget == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Veuillez remplir tous les champs");
                return;
            }


            Projet projet = new Projet(Nom, description, Date_de_Debut, Date_de_Fin, Budget);
            projetDao.AjouterProjet(projet);
            resp.sendRedirect("ProjectServlet");


        } catch (Exception e) {
            req.setAttribute("errorMessage", "Erreur lors de l'ajout du projet : " + e.getMessage());
            req.getRequestDispatcher("/AjouterProjet.jsp").forward(req, resp);
        }


    }}


