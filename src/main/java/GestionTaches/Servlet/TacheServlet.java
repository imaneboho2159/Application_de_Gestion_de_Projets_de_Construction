package GestionTaches.Servlet;

import GestionProjets.DAO.ProjetDao;
import GestionProjets.Model.Projet;
import GestionTaches.DAO.TacheDao;
import GestionTaches.Model.Tache;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/TacheServlet")
public class TacheServlet extends HttpServlet {
    private TacheDao tacheDao;
    private ProjetDao projetDao;

    @Override
    public void init() throws ServletException {
        try {
            tacheDao = new TacheDao();
            projetDao = new ProjetDao();
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String projetIdParam = request.getParameter("idProjet");
        if (projetIdParam == null || projetIdParam.isEmpty()) {
            request.setAttribute("errorMessage", "ID du projet manquant.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
            return;
        }

        int idProjet = Integer.parseInt(projetIdParam);
        Projet projet = projetDao.getProjetById(idProjet);
        if (projet == null) {
            request.setAttribute("errorMessage", "Aucun projet trouvé.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
            return;
        }

        List<Tache> taches = null;
        try {
            taches = tacheDao.getTachesByProjetId(idProjet);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("projet", projet);
        request.setAttribute("taches", taches);
        request.getRequestDispatcher("DashboardProjet.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            String projectIdStr = request.getParameter("projectId");
            String description = request.getParameter("taskDescription");
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");


            System.out.println("Ajout de tâche - projectId: " + projectIdStr + ", description: " + description +
                    ", startDate: " + startDateStr + ", endDate: " + endDateStr);


            if (projectIdStr == null || projectIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du projet manquant.");
                return;
            }
            int projectId = Integer.parseInt(projectIdStr);

            if (description == null || description.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Description requise.");
                return;
            }
            if (startDateStr == null || endDateStr == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dates requises.");
                return;
            }

            Date startDate = Date.valueOf(startDateStr);
            Date endDate = Date.valueOf(endDateStr);

            if (endDate.before(startDate)) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "La date de fin ne peut pas être avant la date de début.");
                return;
            }


            Tache tache = new Tache(projectId, description, startDate, endDate);
            tacheDao.ajouterTache(tache);


            System.out.println("Tâche ajoutée avec succès pour projectId: " + projectId);

            response.sendRedirect("/Application-de-Gestion-de-Projets-de-Construction/ViewProjetServlet?id_projet=" + projectId);

        } catch (SQLException e) {
            System.out.println("Erreur SQL lors de l'ajout de la tâche : " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur SQL : " + e.getMessage());
            request.getRequestDispatcher("AjouterTache.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Erreur inattendue : " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur inattendue : " + e.getMessage());
            request.getRequestDispatcher("AjouterTache.jsp").forward(request, response);
        }
    }
}