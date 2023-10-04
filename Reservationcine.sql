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

