--Un corpo di Polizia Municipale intende creare un database per la gestione delle contravvenzioni ed i relativi
--pagamenti.
--Il database dovrà gestire un’anagrafica clienti, una entità per contenere i tipi di violazioni contestate ed un’altra per
--annotare ed archiviare il verbale.

--In virtù di quanto sopra creare le seguenti entità.
--ANAGRAFICA (idanagrafica, Cognome, Nome, Indirizzo, Città, CAP, Cod_Fisc);
--TIPO VIOLAZIONE (idviolazione, descrizione);
--VERBALE (idverbale, DataViolazione, IndirizzoViolazione, Nominativo_Agente, DataTrascrizioneVerbale, Importo,
--DecurtamentoPunti);

--1. Inserire in modo appropriato i campi per effettuare le relative relazioni,
--2. Gestire in modo appropriato i tipi di campi, chiavi primarie, chiavi esterne per ogni campo di ogni tabella,
--3. Creare le corrette relazioni alle tabelle,
--4. Popolare le tabelle manualmente con dati a piacimento.

CREATE TABLE Anagrafica (
	ID_Anagrafica INT PRIMARY KEY NOT NULL IDENTITY,
	Cognome NVARCHAR(20) NOT NULL,
	Nome NVARCHAR(20) NOT NULL,
	Indirizzo NVARCHAR(40) NOT NULL,
	Citta NVARCHAR(20) NOT NULL,
	CAP CHAR(5) NOT NULL,
	CodiceFiscale CHAR(16) NOT NULL UNIQUE
)

CREATE TABLE TipoViolazione (
	ID_Violazione INT PRIMARY KEY NOT NULL IDENTITY,
	Descrizione NVARCHAR(200) NOT NULL
)

CREATE TABLE Verbale (
	ID_Verbale INT PRIMARY KEY NOT NULL IDENTITY,
	DataViolazione DATETIME NOT NULL,
	IndirizzoViolazione NVARCHAR(20) NOT NULL,
	DataTrascrizioneVerbale DATETIME NOT NULL,
	Importo MONEY NOT NULL,
	DecurtamentoPunti TINYINT NOT NULL,
	ID_Violazione INT NOT NULL,
	ID_Anagrafica INT NOT NULL,

	CONSTRAINT FK_Verbale_TipoViolazione FOREIGN KEY (ID_Violazione) REFERENCES TipoViolazione (ID_Violazione),
	CONSTRAINT FK_Verbale_Anagrafica FOREIGN KEY (ID_Anagrafica) REFERENCES Anagrafica (ID_Anagrafica)
)





INSERT INTO Anagrafica VALUES ('Stano', 'Bruno', 'Piazza A. De Ferraris 9', 'Brindisi', '72100', 'STNBRN94R14B180W')
INSERT INTO Anagrafica VALUES ('De Gregorio', 'Francesco', 'Via De Gregoio', 'Roma', '01023', 'DGRFRN94R14B180W')
INSERT INTO Anagrafica VALUES ('Lerra', 'Nicola', 'Viale della Liberta', 'Novasiri', '21200', 'LRRNCL94R14B180W')
INSERT INTO Anagrafica VALUES ('Aliotta', 'Cristiano', 'Piazza Dei Cristiani 1', 'Catania', '99100', 'LTTCRS94R14B180W')
INSERT INTO Anagrafica VALUES ('Di Pisa', 'Giuseppe', 'Via che pesa', 'Brindisi', '09090', 'DPSGSP94R14B180W')
INSERT INTO Anagrafica VALUES ('Lazuka', 'Dimitri', 'Via dei Mitri 2', 'Rimini', '11100', 'LZKDMT94R14B180W')
INSERT INTO Anagrafica VALUES ('Di Filippo', 'Daniela', 'Via dei Filippini', 'Salerno', '29120', 'DFLDNL94R14B180W')
INSERT INTO Anagrafica VALUES ('Savignano', 'Andrea', 'Piazza Savi Gnano', 'Salerno', '29100', 'SVGNDR94R14B180W')
INSERT INTO Anagrafica VALUES ('Pourbjan', 'Aras', 'Place Aux Vives', 'Roma', '90909', 'ARSPRB94R14B180W')
INSERT INTO Anagrafica VALUES ('Gennari', 'Marina', 'Via de Gennaro', 'Brindisi', '72100', 'GNNMRN94R14B180W')

INSERT INTO TipoViolazione VALUES ('Spionaggio informatico')
INSERT INTO TipoViolazione VALUES ('Parcheggio non autorizzato')
INSERT INTO TipoViolazione VALUES ('Eccesso di velocita')
INSERT INTO TipoViolazione VALUES ('Guida in stato di ebrezza')
INSERT INTO TipoViolazione VALUES ('Guida pericolosa')
INSERT INTO TipoViolazione VALUES ('Violazione privacy')
INSERT INTO TipoViolazione VALUES ('Violazione di domicilio')
INSERT INTO TipoViolazione VALUES ('Spaccio di sostanze illecite')
INSERT INTO TipoViolazione VALUES ('Frode informatica')

INSERT INTO Verbale VALUES ('20091009 09:00','Via dei belli 9', '20091012 12:00', 120, 3, 1, 8)
INSERT INTO Verbale VALUES ('20120211 09:34','Via dei Filippini 91', '20120213 10:23', 321, 2, 3, 3)
INSERT INTO Verbale VALUES ('20011223 12:00','Via dei Croccanti 1', '20011229 12:25', 126.50, 5, 4, 2)
INSERT INTO Verbale VALUES ('20131130 12:34','Via dei Brutti 2', '20131210 12:13', 100.20, 3, 5, 5)
INSERT INTO Verbale VALUES ('19901009 22:11','Via dei bugiardi 3', '19901029 16:12', 235.11, 2, 5, 1)
INSERT INTO Verbale VALUES ('19981120 13:22','Via dei benestanti', '19991121 15:23', 500.12, 1, 6, 3)
INSERT INTO Verbale VALUES ('20070209 05:03','Via dei citrulli 2', '20070212 14:13', 2300, 6, 7, 4)
INSERT INTO Verbale VALUES ('20090219 23:00','Via dei burzoni 4', '20090228 13:23', 1230, 2, 1, 2)
INSERT INTO Verbale VALUES ('20081109 12:11','Via delle fiabe', '20081117 11:28', 56.23, 1, 4, 5)
INSERT INTO Verbale VALUES ('20221023 12:00','Via della mamma 2', '20221028 10:29', 89.00, 2, 2, 6)


--Successivamente, creare le seguenti query per interrogare il database:
--1. Conteggio dei verbali trascritti,
SELECT COUNT(*) AS TotaleVerbaliTrascritti FROM Verbale
--2. Conteggio dei verbali trascritti raggruppati per anagrafe,
SELECT Cognome, Nome, COUNT(ID_Verbale) AS TotaleVerbaliTrascritti
		FROM Verbale JOIN Anagrafica 
		ON Verbale.ID_Anagrafica = Anagrafica.ID_Anagrafica 
		GROUP BY Nome, Cognome
--3. Conteggio dei verbali trascritti raggruppati per tipo di violazione,
SELECT Descrizione, COUNT(ID_Verbale) AS TotaleVerbaliTrascritti
		FROM Verbale JOIN TipoViolazione
		ON Verbale.ID_Violazione = TipoViolazione.ID_Violazione
		GROUP BY Descrizione
--4. Totale dei punti decurtati per ogni anagrafe,
SELECT Cognome, Nome, SUM(DecurtamentoPunti) AS TotalePuntiDecurtati 
		FROM Verbale JOIN Anagrafica 
		ON Verbale.ID_Anagrafica = Anagrafica.ID_Anagrafica 
		GROUP BY Nome, Cognome
--5. Cognome, Nome, Data violazione, Indirizzo violazione, importo e punti decurtati per tutti gli anagrafici
--residenti a Palermo,
SELECT Cognome, Nome, DataViolazione, IndirizzoViolazione, Importo, DecurtamentoPunti
		FROM Anagrafica JOIN Verbale
		ON Anagrafica.ID_Anagrafica = Verbale.ID_Anagrafica
		WHERE Citta = 'Roma' --Ho messo Roma al posto di Palermo.
--6. Cognome, Nome, Indirizzo, Data violazione, importo e punti decurtati per le violazioni fatte tra il febbraio
--2009 e luglio 2009,
SELECT Cognome, Nome, Indirizzo, DataViolazione, Importo, DecurtamentoPunti
		FROM Anagrafica JOIN Verbale
		ON Anagrafica.ID_Anagrafica = Verbale.ID_Anagrafica
		WHERE DataViolazione BETWEEN '20090201' AND '20090701'
--7. Totale degli importi per ogni anagrafico,
SELECT  Cognome, Nome, SUM(Importo) AS ImportoTotale
		FROM Verbale JOIN Anagrafica
		ON Verbale.ID_Anagrafica = Anagrafica.ID_Anagrafica
		GROUP BY Cognome, Nome
--8. Visualizzazione di tutti gli anagrafici residenti a Palermo,
SELECT * FROM Anagrafica WHERE Citta = 'Roma'
--9. Query parametrica che visualizzi Data violazione, Importo e decurtamento punti relativi ad una certa data,
--SI TROVA ALL'INTERNO DELLA STOREPROCEDURE -> dbo.VisualizzaViolazioneTramiteData
--10. Conteggio delle violazioni contestate raggruppate per Nominativo dell’agente di Polizia,
ALTER TABLE Verbale ADD NominativoAgente NVARCHAR(40)
UPDATE Verbale SET NominativoAgente = 'Agente Rocco' WHERE ID_Verbale = 25
UPDATE Verbale SET NominativoAgente = 'Agente Climatico' WHERE ID_Verbale = 26
UPDATE Verbale SET NominativoAgente = 'Agente Climatico' WHERE ID_Verbale = 27
UPDATE Verbale SET NominativoAgente = 'Agente Immobiliare' WHERE ID_Verbale = 28
UPDATE Verbale SET NominativoAgente = 'Agente Roger' WHERE ID_Verbale = 29
UPDATE Verbale SET NominativoAgente = 'Agente Rocco' WHERE ID_Verbale = 30
UPDATE Verbale SET NominativoAgente = 'Agente Patogeno' WHERE ID_Verbale = 31
UPDATE Verbale SET NominativoAgente = 'Agente Alfa' WHERE ID_Verbale = 32
UPDATE Verbale SET NominativoAgente = 'Agente Patogeno' WHERE ID_Verbale = 33
UPDATE Verbale SET NominativoAgente = 'Agente Climatico' WHERE ID_Verbale = 34

SELECT NominativoAgente, COUNT(ID_Violazione) AS ViolazioniContestate
	FROM Verbale
	GROUP BY NominativoAgente
--11. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino il
--decurtamento di 5 punti,
SELECT Cognome, Nome, Indirizzo, DataViolazione, Importo, DecurtamentoPunti
	FROM Anagrafica JOIN Verbale
	ON Anagrafica.ID_Anagrafica = Verbale.ID_Anagrafica
	WHERE DecurtamentoPunti > 5
--12. Cognome, Nome, Indirizzo, Data violazione, Importo e punti decurtati per tutte le violazioni che superino
--l’importo di 400 euro.
SELECT Cognome, Nome, Indirizzo, DataViolazione, Importo, DecurtamentoPunti
	FROM Anagrafica JOIN Verbale
	ON Anagrafica.ID_Anagrafica = Verbale.ID_Anagrafica
	WHERE Importo > 400

--Infine si vogliono creare le seguenti storedProcedure:
--1) Una SP parametrica che, ricevendo in input un anno, visualizzi l’elenco delle contravvenzioni effettuate in un
--quel determinato anno,
--2) Una SP parametrica che, ricevendo in input una data, visualizzi il totale dei punti decurtati in quella
--determinata data,
--3) Una SP che consenta di eliminare un determinato verbale identificandolo con il proprio identificativo.