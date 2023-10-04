--script pour creer la base de donnée et insertion des données

CREATE DATABASE CinemaDB;
USE CinemaDB;

CREATE TABLE Cinema (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Nom VARCHAR(255) NOT NULL,
  Adresse VARCHAR(255) NOT NULL
);

CREATE TABLE Salle (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Numero INT NOT NULL,
  Capacite INT NOT NULL,
  IdCinema INT,
  FOREIGN KEY (IdCinema) REFERENCES Cinema(Id)
);

CREATE TABLE Seance (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Date DATE NOT NULL,
  Heure TIME NOT NULL,
  IdCinema INT,
  FOREIGN KEY (IdCinema) REFERENCES Cinema(Id)
);

CREATE TABLE Film (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Titre VARCHAR(255) NOT NULL
);

CREATE TABLE Tarif (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Libelle VARCHAR(255) NOT NULL,
  Montant DECIMAL(6, 2) NOT NULL
);

CREATE TABLE Statut (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Libelle VARCHAR(255) NOT NULL
);

CREATE TABLE Utilisateur (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Nom VARCHAR(255) NOT NULL,
  Prenom VARCHAR(255) NOT NULL,
  IdStatut INT,
  FOREIGN KEY (IdStatut) REFERENCES Statut(Id)
);

CREATE TABLE Reservation (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  Date DATE NOT NULL,
  Paiement VARCHAR(255) NOT NULL,
  IdSeance INT,
  IdUtilisateur INT,
  FOREIGN KEY (IdSeance) REFERENCES Seance(Id),
  FOREIGN KEY (IdUtilisateur) REFERENCES Utilisateur(Id)
);

CREATE TABLE Tarification (
  Id INT AUTO_INCREMENT PRIMARY KEY,
  IdTarif INT,
  IdFilm INT,
  IdSeance INT,
  FOREIGN KEY (IdTarif) REFERENCES Tarif(Id),
  FOREIGN KEY (IdFilm) REFERENCES Film(Id),
  FOREIGN KEY (IdSeance) REFERENCES Seance(Id)
);

CREATE TABLE Administrateur (
  IdUtilisateur INT,
  FOREIGN KEY (IdUtilisateur) REFERENCES Utilisateur(Id)
);

INSERT INTO Cinema (Nom, Adresse)
VALUES
  ('Cinema du Centre', '123 Rue de la Liberté, 75001 Paris'),
  ('Cinema Lumière', '456 Avenue des Arts, 37000 Tours');

INSERT INTO Salle (Numero, Capacite, IdCinema)
VALUES
  (1, 100, 1),
  (2, 150, 2),
  (3, 120, 2);

INSERT INTO Seance (Date, Heure, IdCinema)
VALUES
  ('2023-10-01', '18:00', 1),
  ('2023-10-01', '18:00', 2),
  ('2023-10-02', '20:00', 1),
  ('2023-10-02', '18:00', 2);

INSERT INTO Film (Titre)
VALUES
  ('Naruto: La Légende du Ninja'),
  ('Film Mystère');

INSERT INTO Tarif (Libelle, Montant)
VALUES
  ('Plein tarif', 9.20),
  ('Étudiant', 7.60),
  ('Moins de 14 ans', 5.90);

INSERT INTO Statut (Libelle)
VALUES
  ('Étudiant'),
  ('Adulte'),
  ('Administrateur');

INSERT INTO Utilisateur (Nom, Prenom, IdStatut)
VALUES
  ('Akim', 'Akim', 1),
  ('Daniel', 'Daniel', 2),
  ('Remi', 'Remi', 2),
  ('Stessy', 'Stessy', 3);

INSERT INTO Reservation (Date, Paiement, IdSeance, IdUtilisateur)
VALUES
  ('2023-09-30', 'En ligne', 1, 1),
  ('2023-09-30', 'Sur place', 2, 2),
  ('2023-09-30', 'Sur place', 2, 3);

INSERT INTO Tarification (IdTarif, IdFilm, IdSeance)
VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 2, 4);

INSERT INTO Administrateur (IdUtilisateur)
VALUES
  (4);

-- REQUETE A FAIRE APRES LE BACKUP DE LE BASE DE DONNEE AVEC LA COMMANDE  mysql -u username -p password DBNAME < script.sql
-- affiche les utilisateurs qui ont reservé et le montant 
SELECT U.Nom, U.Prenom, TF.Montant, R.Paiement
FROM Reservation AS R
JOIN Utilisateur AS U ON R.IdUtilisateur = U.Id
JOIN Tarification AS T ON R.IdSeance = T.IdSeance
JOIN Tarif AS TF ON T.IdTarif = TF.Id;


-- affiche  les seances prévues et dans quelles salles elles auront lieu

SELECT S.Date, S.Heure, F.Titre AS Film, C.Nom AS Cinema, C.Adresse AS Lieu, CONCAT('Salle ', Sa.Numero) AS Salle
FROM Seance AS S
JOIN Cinema AS C ON S.IdCinema = C.Id
JOIN Tarification AS T ON S.Id = T.IdSeance
JOIN Film AS F ON T.IdFilm = F.Id
JOIN Salle AS Sa ON S.IdCinema = Sa.IdCinema;


-- affiche les utilisateurs et leurs statut

SELECT U.Nom, U.Prenom, S.Libelle AS Statut
FROM Utilisateur AS U
JOIN Statut AS S ON U.IdStatut = S.Id;

-- affiche les utilisateurs qui ont reservé et leur méthode de paiement 
SELECT U.Nom, U.Prenom, R.Paiement
FROM Reservation AS R
JOIN Utilisateur AS U ON R.IdUtilisateur = U.Id;

