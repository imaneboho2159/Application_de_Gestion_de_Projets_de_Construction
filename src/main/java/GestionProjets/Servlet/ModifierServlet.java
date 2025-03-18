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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id_projet"));
        String nom = req.getParameter("nom");
        String Description = req.getParameter("Description");
        Date Date_de_Début = java.sql.Date.valueOf(req.getParameter("date_debut"));
        Date Date_de_Fin = java.sql.Date.valueOf(req.getParameter("date_fin"));
        Double Budget = Double.valueOf(req.getParameter("budget"));

        Projet projet = new Projet(nom,Description,Date_de_Début,Date_de_Fin,Budget);

        boolean isUpdated = projetDao.updateProjet(projet,id);
        if (isUpdated) {
            resp.sendRedirect("ProjectServlet?id=" +id);
        } else {
            resp.sendRedirect("EditeProjet.jsp?id=" +id);
        }


    }
}