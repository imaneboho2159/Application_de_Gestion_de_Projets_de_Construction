package GestionProjets.Model;

import java.util.Date;

public class Projet {
    private int id_projet;
    private String Nom;
    private String Description;
    private Date Date_de_Début;
    private Date Date_de_Fin;
    private  Double Budget;

    public Projet(int id_projet, String nom, String description, Date date_de_Début, Date date_de_Fin, Double budget) {
        this.id_projet = id_projet;
        Nom = nom;
        Description = description;
        Date_de_Début = date_de_Début;
        Date_de_Fin = date_de_Fin;
        Budget = budget;
    }

    public Projet(String nom, String description, Date date_de_Début, Date date_de_Fin, Double budget) {
        Nom = nom;
        Description = description;
        Date_de_Début = date_de_Début;
        Date_de_Fin = date_de_Fin;
        Budget = budget;
    }

    public Projet() {
    }

    public int getId_projet() {
        return id_projet;
    }

    public void setId_projet(int id_projet) {
        this.id_projet = id_projet;
    }

    public String getNom() {
        return Nom;
    }

    public void setNom(String nom) {
        Nom = nom;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public java.sql.Date getDate_de_Début() {
        return Date_de_Début;
    }

    public void setDate_de_Début(Date date_de_Début) {
        Date_de_Début = date_de_Début;
    }

    public java.sql.Date getDate_de_Fin() {
        return Date_de_Fin;
    }

    public void setDate_de_Fin(Date date_de_Fin) {
        Date_de_Fin = date_de_Fin;
    }

    public Double getBudget() {
        return Budget;
    }

    public void setBudget(Double budget) {
        Budget = budget;
    }
}
