package GestionProjets.Servlet;

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
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ViewProjetServlet")
public class ViewProjetServlet extends HttpServlet {
    private ProjetDao projetDao;
    private TacheDao tacheDao;

    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();
        try {
            tacheDao = new TacheDao();
        } catch (SQLException e) {
            throw new ServletException("Erreur de connexion à la base de données : " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("ProjectServlet?errorMessage=ID du projet manquant");
            return;
        }

        try {
            int projectId = Integer.parseInt(idParam);
            Projet projet = projetDao.getProjetById(projectId);
            if (projet == null) {
                response.sendRedirect("ProjectServlet?errorMessage=Aucun projet trouvé");
                return;
            }

            // Fetch and log tasks
            List<Tache> taches = tacheDao.getTachesByProjetId(projectId);
            System.out.println("Projet ID: " + projectId + ", Nombre de tâches trouvées: " +
                    (taches != null ? taches.size() : "null"));

            // Log task details if any
            if (taches != null && !taches.isEmpty()) {
                for (Tache t : taches) {
                    System.out.println("Tâche: " + t.getDescription() + ", Début: " + t.getDate_de_Début() +
                            ", Fin: " + t.getDate_de_Fin());
                }
            }

            request.setAttribute("projet", projet);
            request.setAttribute("taches", taches);
            request.getRequestDispatcher("DashboardProjet.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("ProjectServlet?errorMessage=ID du projet invalide");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}