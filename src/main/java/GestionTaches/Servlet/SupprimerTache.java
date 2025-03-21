package GestionTaches.Servlet;

import GestionTaches.DAO.TacheDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/SupprimerTache")
public class SupprimerTache extends HttpServlet {
    private TacheDao tacheDao;

    @Override
    public void init() throws ServletException {
        try {
            tacheDao = new TacheDao();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("tacheId");
        String projectId = req.getParameter("projectId");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int tacheId = Integer.parseInt(idParam);
                if (tacheDao.deleteTache(tacheId)) {
                    resp.sendRedirect("/Application-de-Gestion-de-Projets-de-Construction/ViewProjetServlet?id="+projectId);
                } else {
                    req.setAttribute("errorMessage", "Tâche non supprimée ou inexistante");
                    req.getRequestDispatcher("/Application-de-Gestion-de-Projets-de-Construction/ViewProjetServlet?id="+projectId).forward(req, resp);
                }
            } catch (Exception e) {
                req.setAttribute("errorMessage", "Erreur : " + e.getMessage());
                req.getRequestDispatcher("/Application-de-Gestion-de-Projets-de-Construction/ViewProjetServlet?id="+projectId).forward(req, resp);
            }
        } else {
            req.setAttribute("errorMessage", "ID tâche manquant");
            req.getRequestDispatcher("/Application-de-Gestion-de-Projets-de-Construction/ViewProjetServlet?id="+projectId).forward(req, resp);
        }
    }
    }
