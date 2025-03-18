package GestionProjets.Servlet;
import GestionProjets.DAO.ProjetDao;
import GestionProjets.Model.Projet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ViewProjetServlet")
public class ViewProjetServlet extends HttpServlet {



        private ProjetDao projetDao;

        @Override
        public void init() throws ServletException {
            projetDao = new ProjetDao();
        }

        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String idParam = req.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                resp.sendRedirect("ProjectServlet?errorMessage=ID du projet invalide");
                return;
            }

            try {
                int id = Integer.parseInt(idParam);
                Projet projet = projetDao.getProjetById(id);

                if (projet != null) {
                    req.setAttribute("projet", projet);
                    req.getRequestDispatcher("DashboardProjet.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect("ProjectServlet?errorMessage=Aucun projet trouvé avec cet ID");
                }
            } catch (NumberFormatException e) {
                resp.sendRedirect("ProjectServlet?errorMessage=ID du projet invalide");
            }
        }
    }


