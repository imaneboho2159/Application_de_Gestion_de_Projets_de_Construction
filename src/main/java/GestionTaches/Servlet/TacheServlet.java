package GestionTaches.Servlet;

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

@WebServlet("/TacheServlet")
public class TacheServlet extends HttpServlet {
    private TacheDao tacheDao;

    @Override
    public void init() throws ServletException {
        try {
            tacheDao = new TacheDao();
        } catch (SQLException e) {
            throw new RuntimeException("Erreur de connexion à la base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            String projectIdStr = req.getParameter("projectId");
            if (projectIdStr == null || projectIdStr.trim().isEmpty() || !projectIdStr.matches("\\d+")) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "L'ID du projet est requis et doit être un nombre valide.");
                return;
            }
            int projectId = Integer.parseInt(projectIdStr);


            if (!tacheDao.projetExiste(projectId)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Le projet spécifié n'existe pas.");
                return;
            }


            String description = req.getParameter("taskDescription");
            if (description == null || description.trim().isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "La description de la tâche est requise.");
                return;
            }


            String startDateStr = req.getParameter("startDate");
            String endDateStr = req.getParameter("endDate");

            if (startDateStr == null || startDateStr.isEmpty() || endDateStr == null || endDateStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Les dates de début et de fin sont requises.");
                return;
            }

            Date dateDeDebut = Date.valueOf(startDateStr);
            Date dateDeFin = Date.valueOf(endDateStr);

            if (dateDeFin.before(dateDeDebut)) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "La date de fin ne peut pas être avant la date de début.");
                return;
            }

            // Debugging (affiche les valeurs dans la console)
            System.out.println("Project ID: " + projectId);
            System.out.println("Description: " + description);
            System.out.println("Start Date: " + dateDeDebut);
            System.out.println("End Date: " + dateDeFin);

            // Créer et ajouter la tâche
            Tache tache = new Tache(projectId, description, dateDeDebut, dateDeFin);
            tacheDao.AjouterTache(tache);

            // Rediriger vers la liste des tâches avec le bon projectId
            resp.sendRedirect("ListTache.jsp?projectId=" + projectId);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Format d'ID de projet invalide.");
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Erreur lors de l'ajout de la tâche : " + e.getMessage());
            req.getRequestDispatcher("/AjouterTache.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Une erreur est survenue : " + e.getMessage());
            req.getRequestDispatcher("/AjouterTache.jsp").forward(req, resp);
        }
    }

}
