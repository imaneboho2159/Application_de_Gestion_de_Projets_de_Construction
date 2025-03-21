package GestionTaches.Servlet;

import GestionTaches.DAO.TacheDao;
import GestionTaches.Model.Tache;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/")
public class SuppimerTache   extends HttpServlet {
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


    }


}
