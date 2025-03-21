package GestionTaches.DAO;

import GestionTaches.Model.Tache;
import Util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacheDao {
    private final Connection connection;

    public TacheDao() throws SQLException {
        this.connection = DBConnection.getConnection();
    }

    public void ajouterTache(Tache tache) throws SQLException {
        String query = "INSERT INTO tache (id_projet, description, Date_De_Début, Date_De_Fin) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, tache.getId_projet());
            stmt.setString(2, tache.getDescription());
            stmt.setDate(3, tache.getDate_de_Début());
            stmt.setDate(4, tache.getDate_de_Fin());
            stmt.executeUpdate();
        }
    }

    public List<Tache> getTachesByProjetId(int projetId) throws SQLException {
        List<Tache> taches = new ArrayList<>();
        String query = "SELECT * FROM tache WHERE id_projet = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, projetId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Tache tache = new Tache(
                        rs.getInt("id_tache"),
                        rs.getInt("id_projet"), // Set id_projet correctly
                        rs.getString("description"),
                        rs.getDate("Date_de_Début"),
                        rs.getDate("Date_de_Fin")
                );
                taches.add(tache);
            }
        }
        return taches;
    }



    public Tache getTacheById(int idTache) throws SQLException {
        String query = "SELECT * FROM tache WHERE id_tache = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, idTache);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return new Tache(
                            resultSet.getInt("id_tache"),
                            resultSet.getInt("id_projet"),
                            resultSet.getString("description"),
                            resultSet.getDate("Date_de_Début"),
                            resultSet.getDate("Date_de_Fin")
                    );
                }
            }
        }
        return null;
    }

    public boolean updateTache(Tache tache) throws SQLException {
        String query = "UPDATE tache SET description = ?, Date_de_Début = ?, Date_de_Fin = ? WHERE id_tache = ? AND id_projet = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, tache.getDescription());
            preparedStatement.setDate(2, tache.getDate_de_Début());
            preparedStatement.setDate(3, tache.getDate_de_Fin());
            preparedStatement.setInt(4, tache.getId_tache());
            preparedStatement.setInt(5, tache.getId_projet());
            preparedStatement.executeUpdate();
        }
        return true;
    }

    public boolean deleteTache(int id) throws SQLException {
        String query = "DELETE FROM tache WHERE id_tache = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, id);
            return preparedStatement.executeUpdate() > 0;
        }
    }
}