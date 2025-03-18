package GestionProjets.Servlet;

import GestionProjets.DAO.ProjetDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/supprimerServlet")
public class SupprimerServlet extends HttpServlet {
    private ProjetDao projetDao;

    @Override
    public void init() throws ServletException {
        projetDao = new ProjetDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id_projet");

        if (idParam == null || idParam.isEmpty()) {
            resp.sendRedirect("ProjectServlet?errorMessage=ID du projet invalide");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            boolean deleted = projetDao.deleteProjet(id);

            if (deleted) {
                resp.sendRedirect("ProjectServlet?successMessage=Projet supprime avec succes");
            } else {
                resp.sendRedirect("ProjectServlet?errorMessage=Aucun projet trouvé avec cet ID");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect("ProjectServlet?errorMessage=ID du projet invalide");
        }
    }
}
