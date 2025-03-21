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

@WebServlet("/ModifierTache")
public class ModifierTache extends HttpServlet {
    private TacheDao tacheDao;

    @Override
    public void init() throws ServletException {
        try {
            tacheDao = new TacheDao();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tacheIdStr = req.getParameter("tacheId");
        String projectId = req.getParameter("projectId");

        if (tacheIdStr == null || tacheIdStr.isEmpty() || projectId == null || projectId.isEmpty()) {
            throw new ServletException("Missing required parameters");
        }

        int tacheId = Integer.parseInt(tacheIdStr); // Line 34
        try {
            Tache tache = tacheDao.getTacheById(tacheId);
            req.setAttribute("tache", tache);
            req.setAttribute("projectId", projectId);
            req.getRequestDispatcher("EditeTache.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("update".equals(action)) {
            try {
                int idTache = Integer.parseInt(req.getParameter("tacheId"));
                int idProjet = Integer.parseInt(req.getParameter("projectId"));
                String description = req.getParameter("taskDescription");
                Date dateDeDebut = Date.valueOf(req.getParameter("startDate"));
                Date dateDeFin = Date.valueOf(req.getParameter("endDate"));

                Tache tache = new Tache(idTache, idProjet, description, dateDeDebut, dateDeFin);
                tacheDao.updateTache(tache);
                resp.sendRedirect("ViewProjetServlet?id=" + idProjet);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        }
    }
}
