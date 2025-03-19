package GestionTaches.DAO;

import GestionTaches.Model.Tache;
import Util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TacheDao {

    public Connection connection;

    public TacheDao() throws SQLException {
        connection = DBConnection.getConnection();
    }

    public void AjouterTache(Tache tache) throws SQLException {

        String query = "INSERT INTO tache(description,Date_de_Début,Date_de_Fin ) values(?,?,?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, tache.getDescription());
            preparedStatement.setDate(2, tache.getDate_de_Début());
            preparedStatement.setDate(3, tache.getDate_de_Fin());
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public List<Tache> getTachesList() throws SQLException {
        List<Tache> taches = new ArrayList<>();
        String query = "SELECT * FROM tache ";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Tache tache = new Tache(resultSet.getInt("id_tache") ,resultSet.getInt("id_projet"),   resultSet.getString("description "), resultSet.getDate("Date_de_Début"), resultSet.getDate("Date_de_Fin "));
                taches.add(tache);
            }

        }
        return taches;}


    public Tache getTacheById(int id) throws SQLException {

        Tache tache = null;
        String query = "SELECT * FROM tache WHERE id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                 tache =new Tache(
                resultSet.getInt("id_tache"),
                resultSet.getInt("id_projet"),
                resultSet.getString("description "),
                resultSet.getDate("Date_de_Début"),
                resultSet.getDate("Date_de_Fin"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tache;
    }



    public boolean updateTache(Tache tache) throws SQLException {
         String query = " UPDATE tache set description = ? ,Date_de_Début=? ,Date_de_Fin=? where id_tache = ?";
         try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             preparedStatement.setString(1, tache.getDescription());
             preparedStatement.setDate(2,tache.getDate_de_Début());
             preparedStatement.setDate(3, tache.getDate_de_Fin());
             preparedStatement.setInt(4, tache.getId_tache());
             preparedStatement.executeUpdate();


         }catch (SQLException e) {
             e.printStackTrace();
         }
        return true;
    }

    public boolean deleteTache(int id) throws SQLException {
        String query = "DELETE FROM tache WHERE id_tache = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

        }catch (SQLException e) {
            e.printStackTrace();

        }
        return true;
    }

}

