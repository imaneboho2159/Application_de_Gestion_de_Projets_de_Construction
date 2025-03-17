package GestionProjets.DAO;

import GestionProjets.Model.Projet;
import Util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjetDao {


public void AjouterProjet(Projet projet) {
    String query= "insert into projets values(?,?,?,?,?)";
    try (Connection connection = DBConnection.getConnection();
    PreparedStatement preparedStatement = connection.prepareStatement(query)){
        preparedStatement.setString(1,projet.getNom());
        preparedStatement.setString(2,projet.getDescription());
        preparedStatement.setString(3, String.valueOf(projet.getDate_de_Début()));
        preparedStatement.setString(4, String.valueOf(projet.getDate_de_Fin()));
        preparedStatement.setDouble(5,projet.getBudget());
        preparedStatement.executeUpdate();



    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
}

public  Projet getProjetById(int id) throws SQLException {
    Projet projet = null;
    String query = "select * from projet where id =?";
    try (Connection connection = DBConnection.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query)) {
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()){
            projet= new Projet(resultSet.getInt("id_projet"),
                    resultSet.getString("nom"),
                    resultSet.getString("description "),
                    resultSet.getDate("Date_de_Début"),
                    resultSet.getDate("Date_de_Fin"),
                    resultSet.getDouble("Budget"));

        }

    }
    return projet;
}
public List<Projet> getProjetList() throws SQLException {
    List<Projet> projets = new ArrayList<>();
    String query ="select * from projet";
    try(Connection connection = DBConnection.getConnection();
    PreparedStatement preparedStatement = connection.prepareStatement(query)){
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
           Projet projet= new Projet( resultSet.getInt("id_projet"),
            resultSet.getString("nom"),
            resultSet.getString("description"),
            resultSet.getDate("Date_de_Début"),
            resultSet.getDate("Date_de_Fin"),
            resultSet.getDouble("Budget"));
          projets.add(projet);

        }
    }
return projets;
}

public void updateProjet(Projet projet) throws SQLException {
    String query = "update projet set nom=?,description=?,Date_de_Début?,Date_de_Fin?,Budget=? where id_projet=?";
    try(Connection connection = DBConnection.getConnection();
    PreparedStatement preparedStatement= connection.prepareStatement(query);){
        preparedStatement.setString(1,projet.getNom());
        preparedStatement.setString(2,projet.getDescription());
        preparedStatement.setDate(3,projet.getDate_de_Début());
        preparedStatement.setDate(4,projet.getDate_de_Fin());
        preparedStatement.setDouble(5,projet.getBudget());
        preparedStatement.executeUpdate();

    }
}

public void deleteProjet(int id) throws SQLException {
    String query="delete from projet where id_projet =?";
    try(Connection connection = DBConnection.getConnection();
    PreparedStatement preparedStatement= connection.prepareStatement(query)){
        preparedStatement.setInt(1,id);
        preparedStatement.executeUpdate();

    }
}

}
