create database GestionDeProjets;
use GestionDeProjets;

create table projet(
                       id_projet int primary key auto_increment ,
                       nom varchar(100),
                       description varchar (500),
                       Date_de_Début  Date,
                       Date_de_Fin  Date,
                       Budget decimal
);

create table tache(
                      id_tache int primary key auto_increment,
                      id_projet int,
                      description varchar (500),
                      Date_de_Début  Date,
                      Date_de_Fin  Date,

                      foreign key (id_projet) references projet(id_projet)
);

create table ressorce (
                          id_ressorce int primary key auto_increment,
                          id_tache int ,
                          name varchar(100),
                          type varchar (100),
                          quantity int,

                        foreign key (id_tache) references tache(id_tache)

);