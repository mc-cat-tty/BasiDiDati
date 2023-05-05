create table CLIENTI(
	EMAIL CHAR(255) PRIMARY KEY,
	NOME CHAR(32) NOT NULL,
	COGNOME CHAR(32) NOT NULL,
	TELEFONO INTEGER NOT NULL
);

create table FILM(
	CODICE INTEGER PRIMARY KEY,
	TITOLO CHAR(255) NOT NULL,
	REGISTA VARCHAR(32),
	VOTO INTEGER CHECK (VOTO BETWEEN 1 AND 10),
	TRAMA VARCHAR(255)
);

create table VISIONI(
	CODICE_FILM INTEGER,
	EMAIL CHAR(255),
	DATA_VIS DATE,
	PRIMARY KEY(CODICE_FILM, EMAIL),
	FOREIGN KEY(CODICE_FILM) REFERENCES FILM(CODICE),
	FOREIGN KEY(EMAIL) REFERENCES CLIENTI
);


INSERT INTO CLIENTI VALUES('pippo.pluto@gmail.com', 'pippo', 'pluto', 333445567);
INSERT INTO CLIENTI VALUES('foo.azz@gmail.com', 'foo', 'azz', 111223345);
INSERT INTO CLIENTI VALUES('test@gmail.com', 'test', 'mail', 111223345);

INSERT INTO FILM VALUES(123, 'Pulp Fiction', 'Tarantino', 1, 'Trama non molto dettagliata che non conosco');
INSERT INTO FILM VALUES(456, 'Inception', NULL, 10, 'Surreale e intrippante');
INSERT INTO FILM VALUES(789, 'The Hobbit', NULL, 8, 'Mistico ed educativo');

INSERT INTO VISIONI VALUES(123, 'pippo.pluto@gmail.com', '05/05/2023')
INSERT INTO VISIONI VALUES(123, 'foo.azz@gmail.com', '05/05/2023')
INSERT INTO VISIONI VALUES(456, 'foo.azz@gmail.com', '05/05/2023');
INSERT INTO VISIONI VALUES(456, 'foo.azz@gmail.com', '05/05/2023');
INSERT INTO VISIONI VALUES(789, 'test@gmail.com', '05/05/2023');


INSERT INTO CLIENTI VALUES('pippo.pluto@gmail.com', NULL, 'pluto', 333445567);  -- Errato
INSERT INTO FILM VALUES(789, 'AAAAA', 'BBBBB', 11, 'Trama');  -- Errato
INSERT INTO FILM VALUES(789, 'AAAAA', 'BBBBB', 0, 'Trama');  -- Errato
INSERT INTO VISIONI VALUES(111, 'pippo.pluto@gmail.com', '05/05/2023');

UPDATE FILM SET VOTO = VOTO + 3 WHERE CODICE = 123;

-- PROJECT [CODICE] (SELECT [VOTO>5] FILM)
SELECT DISTINCT * FROM FILM WHERE VOTO > 5;

-- PROJECT [TELEFONO] (SELECT [NOME='pippo'] CLIENTI)
SELECT TELEFONO FROM CLIENTI WHERE NOME = 'pippo';

-- PROJECT [CODICE_FILM] (SELECT [MAIL = 'pippo.pluto@gmail.com'] CLIENTI) U
-- PROJECT [CODICE_FILM] (SELECT [MAIL = 'foo.azz@gmail.com'] CLIENTI)
SELECT DISTINCT CODICE
	FROM VISIONI AS VS
	JOIN CLIENTI AS C ON VS.EMAIL = C.EMAIL
	JOIN FILM AS F ON VS.CODICE_FILM = F.CODICE
	WHERE C.EMAIL IN ('pippo.pluto@gmail.com', 'foo.azz@gmail.com');