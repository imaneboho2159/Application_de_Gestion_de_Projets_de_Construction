package GestionProjets.Servlet;

import GestionProjets.DAO.ProjetDao;
import GestionProjets.Model.Projet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
@WebServlet("/updateServlet")

public class ModifierServlet extends HttpServlet {

    public ProjetDao projetDao;
    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id_projet");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Projet projet = projetDao.getProjetById(id);
                req.setAttribute("projet", projet);
                req.getRequestDispatcher("EditeProjet.jsp").forward(req, resp);  // Affiche le formulaire d'édition
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre 'id_projet' manquant");
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id_projet");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                String nom = req.getParameter("nom");
                String description = req.getParameter("Description");
                Date dateDebut = java.sql.Date.valueOf(req.getParameter("date_debut"));
                Date dateFin = java.sql.Date.valueOf(req.getParameter("date_fin"));
                Double budget = Double.valueOf(req.getParameter("budget"));

                Projet projet = new Projet(nom, description, dateDebut, dateFin, budget);


                boolean isUpdated = projetDao.updateProjet(projet, id);
                if (isUpdated) {
                    resp.sendRedirect("ProjectServlet?id=" + id);  // Redirection après mise à jour réussie
                } else {
                    req.setAttribute("errorMessage", "La mise à jour a échoué !");
                    req.getRequestDispatcher("EditeProjet.jsp").forward(req, resp);
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre 'id_projet' manquant");
        }
    }}
