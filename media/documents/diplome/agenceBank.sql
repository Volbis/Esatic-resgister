-- Création de la base de données
CREATE DATABASE Banque;
USE Banque;

-- Table AGENCE
CREATE TABLE AGENCE (
    Num_Agence INT PRIMARY KEY,
    Nom_Agence VARCHAR(50),
    Ville_Agence VARCHAR(50),
    Actif_Agence DECIMAL(15, 2)
);

-- Table CLIENT
CREATE TABLE CLIENT (
    Num_Client INT PRIMARY KEY,
    Nom_Client VARCHAR(50),
    Ville_Client VARCHAR(50)
);

-- Table COMPTE
CREATE TABLE COMPTE (
    Num_Compte INT PRIMARY KEY,
    Num_Agence INT,
    Num_Client INT,
    Solde DECIMAL(15, 2),
    FOREIGN KEY (Num_Agence) REFERENCES AGENCE(Num_Agence),
    FOREIGN KEY (Num_Client) REFERENCES CLIENT(Num_Client)
);

-- Table EMPRUNT
CREATE TABLE EMPRUNT (
    Num_Emprunt VARCHAR(10) PRIMARY KEY,
    Num_Agence INT,
    Num_Client INT,
    Montant DECIMAL(15, 2),
    FOREIGN KEY (Num_Agence) REFERENCES AGENCE(Num_Agence),
    FOREIGN KEY (Num_Client) REFERENCES CLIENT(Num_Client)
);



-- Insertion des données dans la table AGENCE
INSERT INTO AGENCE (Num_Agence, Nom_Agence, Ville_Agence, Actif_Agence) VALUES
(1, 'Abidjan-sud', 'ABIDJAN', 250000000),
(2, 'Abidjan-centre', 'ABIDJAN', 159006125),
(3, 'Abidjan-nord', 'ABIDJAN', 325000200),
(4, 'Bouaké-zone', 'BOUAKE', 900000000),
(5, 'Bouaké-Marché', 'BOUAKE', 89000780),
(6, 'Agence-Korhogo', 'KORHOGO', 120000000),
(7, 'Agence-Man', 'MAN', 111020550),
(8, 'Agence-Dabou', 'DABOU', 103000000);

-- Insertion des données dans la table CLIENT
INSERT INTO CLIENT (Num_Client, Nom_Client, Ville_Client) VALUES
(1001, 'YAVO Paul', 'ABIDJAN'),
(1003, 'KOUASI Yves', 'ABIDJAN'),
(2001, 'ADOU Aurore', 'ABIDJAN'),
(3001, 'SORO Rosalie', 'ABIDJAN'),
(5001, 'GBIZIE Rachel', 'BOUAKE'),
(6001, 'ATSE Richard', 'KORHOGO'),
(7001, 'TOURE Yao', 'MAN');

-- Insertion des données dans la table EMPRUNT
INSERT INTO EMPRUNT (Num_Emprunt, Num_Agence, Num_Client, Montant) VALUES
(9101, 1, 1001, 3000000),
(9102, 2, 2001, 5000000),
(9105, 5, 5001, 8000000),
(9108, 3, 3001, 1500000),
(9109, 7, 7001, 2000000);

INSERT INTO COMPTE (Num_Compte, Num_Agence, Num_Client, Solde) VALUES
(10001, 1, 1001, 1200060),
(10002, 2, 2001, 2369800),
(10003, 5, 5001, 753335),
(10004, 3, 3001, 658123),
(10005, 7, 7001, 4682330);




-- 1. Liste des agences ayant des comptes-clients
SELECT*
FROM AGENCE A, COMPTE C
WHERE A.Num_Agence = C.Num_Agence;

-- 2. Clients ayant un compte à "ABIDJAN"
SELECT*
FROM CLIENT Cl, AGENCE Ag, COMPTE Cpt
WHERE Cpt.Num_Client = Cl.Num_Client
  AND Cpt.Num_Agence = Ag.Num_Agence
  AND Ag.Ville_Agence = 'ABIDJAN';

-- 3. Clients ayant un compte OU un emprunt à "ABIDJAN"
SELECT *
FROM CLIENT Cl, COMPTE Cp, AGENCE Ag
WHERE Cl.Num_Client = Cp.Num_Client
  AND Cp.Num_Agence = Ag.Num_Agence
  AND Ag.Ville_Agence = 'ABIDJAN'
UNION
SELECT *
FROM CLIENT Cl, EMPRUNT Ep, AGENCE Ag
WHERE Cl.Num_Client = Ep.Num_Client
  AND Ep.Num_Agence = Ag.Num_Agence
  AND Ag.Ville_Agence = 'ABIDJAN';

-- 4. Clients ayant un compte ET un emprunt à "ABIDJAN"
SELECT *
FROM CLIENT Cl, COMPTE Cp, EMPRUNT Ep, AGENCE Ag
WHERE Cl.Num_Client = Cp.Num_Client
  AND Cl.Num_Client = Ep.Num_Client
  AND Cp.Num_Agence = Ag.Num_Agence
  AND Ep.Num_Agence = Ag.Num_Agence
  AND Ag.Ville_Agence = 'ABIDJAN';

-- 5. Clients ayant un compte ET pas d’emprunt à "ABIDJAN"
SELECT*
FROM CLIENT Cl, COMPTE Cp, AGENCE Ag
WHERE Cl.Num_Client = Cp.Num_Client
  AND Cp.Num_Agence = Ag.Num_Agence
  AND Ag.Ville_Agence = 'ABIDJAN'
  AND Cl.Num_Client NOT IN (
    SELECT Ep.Num_Client
    FROM EMPRUNT Ep, AGENCE Ag2
    WHERE Ep.Num_Agence = Ag2.Num_Agence
      AND Ag2.Ville_Agence = 'ABIDJAN'
  );

-- 6. Clients ayant un compte dans les agences où "ADOU Aurore" a un compte (avec EXISTS)
SELECT *
FROM CLIENT Cl, AGENCE Ag, COMPTE Cpt
WHERE Cl.Num_Client = Cpt.Num_Client
  AND Cpt.Num_Agence = Ag.Num_Agence
  AND EXISTS (
    SELECT *
    FROM CLIENT Cl2, COMPTE Cpt2, AGENCE Ag2
    WHERE Cl2.Num_Client = Cpt2.Num_Client
      AND Ag2.Num_Agence = Cpt2.Num_Agence
      AND Cl2.Nom_Client = 'ADOU Aurore'
      AND Ag2.Num_Agence = Ag.Num_Agence
  );

-- 7. Agences ayant un actif plus élevé que toute agence de "Abidjan-nord"
SELECT *
FROM AGENCE
WHERE Actif_Agence > ALL (
  SELECT Actif_Agence
  FROM AGENCE
  WHERE Nom_Agence = 'Abidjan-nord'
);

-- 8. Emprunteurs de l'agence "Abidjan-sud" classés par ordre alphabétique
SELECT *
FROM EMPRUNT Ep, AGENCE Ag, CLIENT Cl
WHERE Ep.Num_Agence = Ag.Num_Agence
  AND Ep.Num_Client = Cl.Num_Client
  AND Ag.Nom_Agence = 'Abidjan-sud'
ORDER BY Nom_Client ASC;

-- 9. Diminuer l'emprunt de tous les clients habitant "MAN" de 5%
UPDATE EMPRUNT
SET Montant = Montant * 0.95
WHERE Num_Client IN (
  SELECT Num_Client
  FROM CLIENT
  WHERE Ville_Client = 'MAN'
);

-- 10.Fermer les comptes de “ YAVO Paul 
DELETE FROM COMPTE
WHERE Num_Client IN (
    SELECT Num_Client
    FROM CLIENT
    WHERE Nom_Client = 'YAO Paul'
);
