package GestionProjets.DAO;

import GestionProjets.Model.Projet;
import Util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjetDao {

    public void AjouterProjet(Projet projet) {
        String query = "INSERT INTO projet (nom, description, Date_de_Début, Date_de_Fin, Budget) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, projet.getNom());
            preparedStatement.setString(2, projet.getDescription());
            preparedStatement.setDate(3, new java.sql.Date(projet.getDate_de_Début().getTime()));
            preparedStatement.setDate(4, new java.sql.Date(projet.getDate_de_Fin().getTime()));
            preparedStatement.setDouble(5, projet.getBudget());

            preparedStatement.executeUpdate();
            System.out.println("Projet ajouté avec succès.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Projet getProjetById(int id) {
        Projet projet = null;
        String query = "SELECT * FROM projet WHERE id_projet = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                projet = new Projet(
                        resultSet.getInt("id_projet"),
                        resultSet.getString("nom"),
                        resultSet.getString("description"),  // Removed extra space
                        resultSet.getDate("Date_de_Début"),
                        resultSet.getDate("Date_de_Fin"),
                        resultSet.getDouble("Budget")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projet;
    }

    public List<Projet> getProjetList() {
        List<Projet> projets = new ArrayList<>();
        String query = "SELECT * FROM projet";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Projet projet = new Projet(
                        resultSet.getInt("id_projet"),
                        resultSet.getString("nom"),
                        resultSet.getString("description"),
                        resultSet.getDate("Date_de_Début"),
                        resultSet.getDate("Date_de_Fin"),
                        resultSet.getDouble("Budget")
                );
                projets.add(projet);
            }
            System.out.println("Projects retrieved from DB: " + projets.size()); // Debugging line

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projets;
    }


    public boolean updateProjet(Projet projet,int id) {
        String query = "UPDATE projet SET nom=?, description=?, Date_de_Début=?, Date_de_Fin=?, Budget=? WHERE id_projet=?";
        boolean result = false;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, projet.getNom());
            preparedStatement.setString(2, projet.getDescription());
            preparedStatement.setDate(3, new java.sql.Date(projet.getDate_de_Début().getTime()));
            preparedStatement.setDate(4, new java.sql.Date(projet.getDate_de_Fin().getTime()));
            preparedStatement.setDouble(5, projet.getBudget());
            preparedStatement.setInt(6, id);

            preparedStatement.executeUpdate();
            result = true;


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    public boolean deleteProjet(int id) {
        String query = "DELETE FROM projet WHERE id_projet = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            int rowsAffected = preparedStatement.executeUpdate(); // Get affected rows

            return rowsAffected > 0; // If at least one row was deleted, return true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;}
    }
