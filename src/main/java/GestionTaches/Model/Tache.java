package GestionTaches.Model;


import java.sql.Date;

public class Tache {
    private int id_tache;
    private int id_projet;
    private String description;
    private Date Date_de_Début;
    private Date Date_de_Fin ;


    public Tache(int id_tache, int id_projet, String description, Date date_de_Début, Date date_de_Fin) {
        this.id_tache = id_tache;
        this.id_projet = id_projet;
        this.description = description;
        Date_de_Début = date_de_Début;
        Date_de_Fin = date_de_Fin;
    }

    public Tache(int id_projet, String description, Date date_de_Début, Date date_de_Fin) {
        this.id_projet = id_projet;
        this.description = description;
        Date_de_Début = date_de_Début;
        Date_de_Fin = date_de_Fin;
    }

    public Tache(String description, java.sql.Date dateDeDébut, java.sql.Date dateDeFin) {
    }

    public Tache(int idTache) {
    }

    public void setId_tache(int id_tache) {
        this.id_tache = id_tache;
    }

    public void setId_projet(int id_projet) {
        this.id_projet = id_projet;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDate_de_Début(Date date_de_Début) {
        Date_de_Début = date_de_Début;
    }

    public void setDate_de_Fin(Date date_de_Fin) {
        Date_de_Fin = date_de_Fin;
    }

    public int getId_tache() {
        return id_tache;
    }

    public int getId_projet() {
        return id_projet;
    }

    public String getDescription() {
        return description;
    }

    public java.sql.Date getDate_de_Début() {
        return Date_de_Début;
    }

    public java.sql.Date getDate_de_Fin() {
        return Date_de_Fin;
    }

    @Override
    public String toString() {
        return "Tache{" +
                "id_tache=" + id_tache +
                ", id_projet=" + id_projet +
                ", description='" + description + '\'' +
                ", Date_de_Début=" + Date_de_Début +
                ", Date_de_Fin=" + Date_de_Fin +
                '}';
    }
}
