-- Creazione database MOBILI
CREATE TABLE Categorie
(   Cat_Cod            CHAR(3),
    Cat_Descrizione    CHAR(40),
    PRIMARY KEY (Cat_Cod)
);

CREATE TABLE Laboratori
(   Lab_Cod            CHAR(4),
    Lab_Indirizzo      CHAR(40),
    Lab_Citta          CHAR(15),
    Lab_Telefono       CHAR(20),
    PRIMARY KEY (Lab_Cod)
);

CREATE TABLE Negozi
(   Neg_Cod            CHAR(4),
    Neg_Nome           CHAR(20),
    Neg_Indirizzo      CHAR(40),
    Neg_Citta          CHAR(15),
    Neg_Telefono       CHAR(20),
    PRIMARY KEY (Neg_Cod)
);

CREATE TABLE Articoli
(   Art_Cod            CHAR(4),
    Cat_Cod            CHAR(3) NOT NULL,
    Art_Descrizione    CHAR(40),
    Art_Prezzo         NUMERIC(9),
    Art_IVA            NUMERIC(3),
    Art_Spese_Trasporto NUMERIC(9),
    PRIMARY KEY (Art_Cod),
    FOREIGN KEY (Cat_Cod)
        REFERENCES Categorie (Cat_Cod)
        ON DELETE CASCADE
);

CREATE TABLE Componenti
(   Com_Cod            CHAR(4),
    Com_Descrizione    CHAR(40),
    Com_Costo          NUMERIC(9),
    Lab_Cod            CHAR(4),
    PRIMARY KEY (Com_Cod),
    FOREIGN KEY (Lab_Cod)
        REFERENCES Laboratori (Lab_Cod)
        ON DELETE CASCADE
);

CREATE TABLE CompArt
(   Art_Cod            CHAR(4),
    Com_Cod            CHAR(4),
    CompArt_Qta        NUMERIC(4) NOT NULL,
    PRIMARY KEY (Art_Cod, Com_Cod),
    FOREIGN KEY (Com_Cod)
        REFERENCES Componenti (Com_Cod),
    FOREIGN KEY (Art_Cod)
        REFERENCES Articoli (Art_Cod)
        ON DELETE CASCADE
);

CREATE TABLE Ordini
(   Ord_Cod            CHAR(6),
    Neg_Cod            CHAR(4) NOT NULL,
    Ord_Data           DATE,
    PRIMARY KEY (Ord_Cod),
    FOREIGN KEY (Neg_Cod)
        REFERENCES Negozi (Neg_Cod)
        ON DELETE CASCADE
);

CREATE TABLE OrdArt
(   Ord_Cod            CHAR(6),
    Art_Cod            CHAR(4),
    OrdArt_Qta         NUMERIC(4) NOT NULL,
    PRIMARY KEY (Art_Cod, Ord_Cod),
    FOREIGN KEY (Ord_Cod)
        REFERENCES Ordini (Ord_Cod),
    FOREIGN KEY (Art_Cod)
        REFERENCES Articoli (Art_Cod)
        ON DELETE CASCADE
);


-- Dati per database MOBILI
INSERT INTO Categorie VALUES ('L10','Libreria');
INSERT INTO Categorie VALUES ('M10','Mobile');
INSERT INTO Categorie VALUES ('M20','Armadio');
INSERT INTO Categorie VALUES ('T10','Tavolo');

INSERT INTO Laboratori VALUES ('0010','Via S. Lucia, 21','Firenze','055/13467998');
INSERT INTO Laboratori VALUES ('0020','Viale Redi, 3','Roma','06/2451899');
INSERT INTO Laboratori VALUES ('0030','Via Marino, 1','Lucca','0583/43451');
INSERT INTO Laboratori VALUES ('0040','Viale dei Tigli','Firenze','055/3379801');
INSERT INTO Laboratori VALUES ('0050','Via Bianchi, 3','Roma','06/6576804');
INSERT INTO Laboratori VALUES ('0060','Via dei Poggi, 456','Pisa','050/32391');

INSERT INTO Negozi VALUES ('0010','CompoLegno','Via S. Felice, 2','Firenze','055/3232100');
INSERT INTO Negozi VALUES ('0020','EcoMobili','Viale Olanda, 33','Roma','06/5989331');
INSERT INTO Negozi VALUES ('0030','F. Bianchi & C.','Via Circeo, 15/B','Lucca','0583/446690');
INSERT INTO Negozi VALUES ('0040','MobilMarket','L.go S. Severo, 11R','Firenze','055/3245781');
INSERT INTO Negozi VALUES ('0050','Micheli','Via Landi, 189','Roma','06/6936592');
INSERT INTO Negozi VALUES ('0060','Co.M.It.','Via dei Pini, 119','Trento',NULL);

INSERT INTO Articoli VALUES ('L100','L10','Libreria 100 cm x 120 cm',475,19,48);
INSERT INTO Articoli VALUES ('L200','L10','Libreria 200 cm x 120 cm',950,19,95);
INSERT INTO Articoli VALUES ('M_40','M20','Armadio 2 ante 200 cm x 120 cm',810,19,85);
INSERT INTO Articoli VALUES ('M_50','M20','Armadio 4 ante 200 cm x 240 cm',1495,NULL,150);
INSERT INTO Articoli VALUES ('M100','M10','Mobile 1 anta 100 cm x 60 cm',390,19,39);
INSERT INTO Articoli VALUES ('M200','M10','Mobile 2 ante 100 cm x 120 cm',720,19,72);
INSERT INTO Articoli VALUES ('M300','M10','Mobile 1 anta+cassetti 100 cm x 120 cm',785,19,0);
INSERT INTO Articoli VALUES ('T100','T10','Tavolo tondo',255,19,NULL);
INSERT INTO Articoli VALUES ('T200','T10','Tavolo quadrato',255,19,21);
INSERT INTO Articoli VALUES ('T300','T10','Tavolo rettangolare',390,19,35);
INSERT INTO Articoli VALUES ('T400','T10','Tavolino basso da salotto',196,19,19);

INSERT INTO Componenti VALUES ('0010','Montante laterale 100 cm',50,'0010');
INSERT INTO Componenti VALUES ('0020','Montante laterale 200 cm',100,'0010');
INSERT INTO Componenti VALUES ('0030','Ripiano 60 cm',50,'0050');
INSERT INTO Componenti VALUES ('0040','Piano tavolo tondo',120,'0050');
INSERT INTO Componenti VALUES ('0050','Piano tavolo quadrato',120,'0050');
INSERT INTO Componenti VALUES ('0060','Gamba tavolo 60 cm',20,'0020');
INSERT INTO Componenti VALUES ('0070','Gamba tavolo 40 cm',15,'0020');
INSERT INTO Componenti VALUES ('0080','Anta 100 cm',80,'0040');
INSERT INTO Componenti VALUES ('0090','Anta 200 cm',120,'0040');
INSERT INTO Componenti VALUES ('0100','Cassettiera da incasso',200,'0030');
INSERT INTO Componenti VALUES ('0110','Busta 10 tasselli',5,NULL);
INSERT INTO Componenti VALUES ('0120','Busta 10 viti',10,NULL);
INSERT INTO Componenti VALUES ('0130','Pomello anta/cassetti',5,'0060');
INSERT INTO Componenti VALUES ('0140','Bastone appendiabiti',15,'0060');
INSERT INTO Componenti VALUES ('0150','Pannello posteriore 100 cm x 60 cm',30,'0050');

INSERT INTO CompArt VALUES ('L100','0010',3);
INSERT INTO CompArt VALUES ('L100','0030',6);
INSERT INTO CompArt VALUES ('L100','0110',1);
INSERT INTO CompArt VALUES ('L100','0120',1);
INSERT INTO CompArt VALUES ('L200','0020',3);
INSERT INTO CompArt VALUES ('L200','0030',12);
INSERT INTO CompArt VALUES ('L200','0110',2);
INSERT INTO CompArt VALUES ('L200','0120',2);
INSERT INTO CompArt VALUES ('M_40','0020',2);
INSERT INTO CompArt VALUES ('M_40','0030',4);
INSERT INTO CompArt VALUES ('M_40','0090',2);
INSERT INTO CompArt VALUES ('M_40','0110',2);
INSERT INTO CompArt VALUES ('M_40','0120',2);
INSERT INTO CompArt VALUES ('M_40','0130',2);
INSERT INTO CompArt VALUES ('M_40','0150',4);
INSERT INTO CompArt VALUES ('M_50','0020',3);
INSERT INTO CompArt VALUES ('M_50','0030',8);
INSERT INTO CompArt VALUES ('M_50','0090',4);
INSERT INTO CompArt VALUES ('M_50','0110',3);
INSERT INTO CompArt VALUES ('M_50','0120',3);
INSERT INTO CompArt VALUES ('M_50','0130',4);
INSERT INTO CompArt VALUES ('M_50','0140',2);
INSERT INTO CompArt VALUES ('M_50','0150',4);
INSERT INTO CompArt VALUES ('M100','0010',2);
INSERT INTO CompArt VALUES ('M100','0030',3);
INSERT INTO CompArt VALUES ('M100','0080',1);
INSERT INTO CompArt VALUES ('M100','0110',1);
INSERT INTO CompArt VALUES ('M100','0120',1);
INSERT INTO CompArt VALUES ('M100','0130',1);
INSERT INTO CompArt VALUES ('M100','0150',1);
INSERT INTO CompArt VALUES ('M200','0010',3);
INSERT INTO CompArt VALUES ('M200','0030',6);
INSERT INTO CompArt VALUES ('M200','0080',2);
INSERT INTO CompArt VALUES ('M200','0110',2);
INSERT INTO CompArt VALUES ('M200','0120',2);
INSERT INTO CompArt VALUES ('M200','0150',2);
INSERT INTO CompArt VALUES ('M300','0010',3);
INSERT INTO CompArt VALUES ('M300','0030',5);
INSERT INTO CompArt VALUES ('M300','0080',1);
INSERT INTO CompArt VALUES ('M300','0100',1);
INSERT INTO CompArt VALUES ('M300','0110',2);
INSERT INTO CompArt VALUES ('M300','0120',1);
INSERT INTO CompArt VALUES ('M300','0130',5);
INSERT INTO CompArt VALUES ('M300','0150',1);
INSERT INTO CompArt VALUES ('T100','0040',1);
INSERT INTO CompArt VALUES ('T100','0060',4);
INSERT INTO CompArt VALUES ('T100','0110',1);
INSERT INTO CompArt VALUES ('T100','0120',1);
INSERT INTO CompArt VALUES ('T200','0050',1);
INSERT INTO CompArt VALUES ('T200','0060',4);
INSERT INTO CompArt VALUES ('T200','0110',1);
INSERT INTO CompArt VALUES ('T200','0120',1);
INSERT INTO CompArt VALUES ('T300','0050',2);
INSERT INTO CompArt VALUES ('T300','0060',4);
INSERT INTO CompArt VALUES ('T300','0110',2);
INSERT INTO CompArt VALUES ('T300','0120',2);
INSERT INTO CompArt VALUES ('T400','0050',1);
INSERT INTO CompArt VALUES ('T400','0070',4);
INSERT INTO CompArt VALUES ('T400','0110',1);
INSERT INTO CompArt VALUES ('T400','0120',1);

INSERT INTO Ordini VALUES ('001095','0040','2005-01-10');
INSERT INTO Ordini VALUES ('001595','0010','2005-01-13');
INSERT INTO Ordini VALUES ('003295','0060','2005-01-25');
INSERT INTO Ordini VALUES ('004095','0020','2005-02-02');

INSERT INTO OrdArt VALUES ('001095','L100',4);
INSERT INTO OrdArt VALUES ('001095','M200',2);
INSERT INTO OrdArt VALUES ('001595','L200',1);
INSERT INTO OrdArt VALUES ('001595','T400',1);
INSERT INTO OrdArt VALUES ('003295','T200',20);
INSERT INTO OrdArt VALUES ('003295','L100',2);
INSERT INTO OrdArt VALUES ('004095','T400',40);
INSERT INTO OrdArt VALUES ('004095','L100',1);

-- Interrogazioni
select * from negozi where neg_citta = 'Roma' order by neg_nome asc;
select * from componenti order by com_costo desc, com_cod;
select ord_cod, min(ordart_qta) as quantità_minima, max(ordart_qta) as quantità_massima from ordart group by ord_cod;  -- Quantità minima e massima PER OGNI ordine
select min(ordart_qta) as quantità_minima_assoluta, max(ordart_qta) as quantità_massima_assoluta from ordart;  -- Quantità minima e massima IN OGNI ordine
select avg(com_costo) from componenti where lab_cod is null;
select cat_cod, max(art_prezzo) from articoli group by cat_cod;
select lab_citta, count(*) from laboratori group by lab_citta having count(*) > 1;
select art_cod, sum(compart_qta) from compart group by art_cod having sum(compart_qta) >= 10;