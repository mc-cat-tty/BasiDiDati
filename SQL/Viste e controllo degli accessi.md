# Indici
Utili per un accesso efficiente ai dati. Si usano le primitive `CREATE INDEX` e `CREATE UNIQUE INDEX`:

```sql
CREATE INDEX DATA-IDX ON ORDINI(DATA)
CREATE UNIQUE INDEX ORD-KEY ON ORDINI(ORD-COD)
```

L'indice verrà creato sulla colonna specificata, rendendo più veloce l'accesso ad essa.

# Modifica degli schemi
Le operazioni di modifica che si possono effettuare su una base di dati sono:
- creazione - CREATE
- modifica - ALTER
- eliminazione - DROP

## Eliminazione
Si possono eliminare tabelle, indici, viste, asserzioni, ecc.

```sql
DROP TABLE ORDINI
DROP INDEX DATA-IDX
```

Con i modificatori `RESTRICT` e `CASCADE` è possibile variare il comportamento di `DROP`:
- `CASCADE` -> rimuove a cascata tutti gli oggetti che dipendono da quello che si sta eliminando
- `RESTRICT` comportamento di default del drop -> si rifiuta di eliminare la tabella se un oggetto dipende da essa

## Modifica
```sql
ALTER TABLE ORDINI ADD COLUMN COD CHAR(6)
ALTER TABLE ORDINI ALTER COLUMN COD ADD DEFAULT 0
ALTER TABLE ORDINI DROP COLUMN COD
```


# Viste
> Le viste relazionali offrono la visione di tabelle virtuali (schemi esterni) ovvero tabelle ottenute dall'aggregazione di dati provenienti da più tabelle diverse. Possono essere semplici - se filtrano i valori di una sola tabella - o complesse - se creano nuove tabelle aggregando, unendo o facendo altro su più tabelle della base di dati.

```sql
CREATE VIEW <NAME> AS <QUERY>
CREATE VIEW <NAME>(<ATTRIBUTES>) AS <QUERY>
```

Le query specificate nelle view possono a loro volta fare uso di altre view specificate in precedenza.

```sql
CREATE VIEW ORDINI-PRINCIPALI AS SELECT * FROM ORDINI WHERE IMPORTO > 1000
CREATE VIEW CLI-PROD (CLIENTE, PRODOTTO) AS SELECT COD-CLI, COD-PROD FROM ORDINE JOIN DETTAGLIO WHERE ORDINE.COD-ORD = DETTAGLIO.COD-ORD
```

Non è possibile fare `UPDATE` selle viste per via dell'ambiguità.

# Autorizzazioni

Privatezza selettiva della base di dati, per garantire il controllo degli accessi.
Ogni utente è identificato da username e password. Gli utenti possono essere divisi in gruppi.

```sql
GRANT <PRIVILEGI> ON <RISORSE> TO <UTENTI>
```

Privilegi disponibili:
- ALL PRIVILEGES
- UPDATE(\<ATTRIBUTES\>)
- SELECT(\<ATTRIBUTES\>)
- DELETE
- INSERT

L'utente creatore di una risorsa continua ad avere tutti i privilegi su di essa; solitamente è il `DATABASE ADMINISTRATOR`. Esso può concederlo `WITH GRANT OPTION`, ovvero con la possibilità di concederlo a sua volta.

La revoca dei privilegi può essere fatta come segue:
```sql
REVOKE <PRIVILEGI> ON <RISORSA> FROM <UTENTE> CASCADE
```

Il DBMS mantiene in memoria una timeline di quando e da chi sono stati concessi i diritti ad un determinato utente. Revocare uno o più diritti ad un utente Y da parte di un altro X significa rimuovere solo quelli assegnati a Y da X, ma non revocare quelli assegnati a Y da altri utenti.

Inoltre se vengono revocati dei diritti ad Y, inseriti ad un certo timestamp e Y aveva a sua volta concesso dei diritti a Z, essi verranno rimossi anche a Z, a meno che non abbia gli stessi diritti provenienti da altri utenti (diversi da Y).

Di fatto viene mantenuta una tabella dei diritti con user, grantor e un timestamp per ogni diritto.

## Viste e accesso
> Le viste vengono utilizzate come unità di autorizzazione: permettono una gestione granulare della privatezza.

