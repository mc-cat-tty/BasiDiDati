# Overview
Procedure e trigger possono sembrare molto simili, ma hanno paradigmi di invocazione diversi:
- le **procedure** devono essere invocate esplicitamente dal cliente (su PostGres sono chiamate `Function`)
- i **trigger** sono invocati implicitamente dal DBMS

Questo, insieme alla gestione degli errori (vincoli), permette di mantere il DB riutilizzabile e consistente.

Esempio progettazione: l'implementazione di trigger permette di applicare il principio di indipendenza del software, anche cambiando client (che accede al DB) si riescono a mantenere vincoli di integrità e funzioni di aggiornamento. Mentre le procedure spesso sono implementate o invocate lato client, quindi rendon l'uso del DBMS dipendente da esso.

# Vincoli di integrità
I vincoli di integrità devono restituire vero se le istanze sono legali, falso altrimenti.

Possono essere espressi in due modi:
- negli **schemi delle tabelle** con la clausola `CHECK(PREDICATO)`. Può essere associata sia ad ogni attributo che alla fine della dichiarazione della tabella.
- come **asserzioni separate**: `CREATE ASSERTION nome AS CHECK(PREDICATO)`

## Momenti dell'esecuzione
- deferred -> annullano la transazione
- immediate -> annullano l'ultima modifica

I vincoli sono di default immediati, ma si può cambiare il loro comportamento di default:
```sql
set constraints immediate
set constraints deferred
```

# Procedure
Due momenti:
1. DDL - dichiarazione
2. DML - invocazione

Le procedure sono invocate dal cliente, ma eseguite e memorizzate sul server.

Dichiarazione:
```sql
POCEDURE PRELIEVO(PROD INTEGER, QTA INTEGER);
```

Chiamata:
```sql
PRELIEVO(10, 20)
```

Contenuto:
1. Dichiarazione variabili
2. Lettura stato
3. Aggiornamento stato
4. ...

```sql
PROCEDURE PRELIEVO(PROD INTEGER, QTA INTEGER)
IS 
	Q1, Q2 INTEGER
	X EXCEPTION
BEGIN
	SELECT QTA-DISP, QTA-RIORD INTO Q1, Q2 FROM MAGAZZINO WHERE COD-PROD = PROD
	IF Q1 < QTA
		THEN RAISE(X);
	UPDATE MAGAZZINO
		SET QTA-DISP = QTA-DISP - QTA
		WHERE COD-PROD = PROD;
	IF Q1 - QTA < A2
		THEN INSERT INTO RIORDINO VALUES(PROD, SYSDATE, Q2)
END
```

#Attenzione : in Postgres serve terminare le condizioni con `END IF`

# Trigger
Non sono standardizzati da SQL2, esattamente come le procedure, ma supportati dai principali DBMS.

Seguono il paradigma:
1. evento
2. condizione
3. azione (eseguita solo se la condizione è soddisfatta)

## Tipologie di triger
- **Statement-level trigger** -> data un'azione viene eseguita una sola volta per evento. Spesso viene usato per mostrare messaggi all'utente
- **Row-level trigger** -> l'azione viene eseguita per ogni riga (tupla) coinvolta, allo scatenarsi dell'evento. Basta aggiungere `FOR EACH ROW`

```sql
CREATE TRIGGER name
AFTER INSERT ON table
[FOR EACH ROW]
BEGIN
...
END
```

## Variabili speciali
Sono presenti alcune variabili speciali inizializzate dal DBMS:
- `NEW`, di tipo record, contiene il nuovo valore per le operazioni di INSERT e UPDATE, è NULL per le DELETE
- `OLD`, di tipo record, contiene il vacchio valore della tupla per DELETE e UPDATE, è NULL per gli insert
