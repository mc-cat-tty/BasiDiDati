> Accesso al DB mediante Java Database Connection.

Java mette a disposizione `java.sql.Driver` (così come `Connection`,  `Statement`, etc.) a cui viene bindato il driver specifico per il DBMS in uso.

`Driver` mette a disposizione un'astrazione: l'API di JDBC

# Configurazione
```java
Class.forName("org.postegresql.Driver");  // Just load the driver to bind it to java.sql.Driver
auto c = DriverManager.getConnection(url, username, password);
```

L'url è nella forma: `jdbc:SUBPROTOCOL:SOURCE`:
- `SUBPROTOCOL`:
	- odbc
	- mysql
	- postgresql
- `SOURCE`
	- `host:port/database`

# ResultSet
Restituito dall'esecuzione sulla query:
```java
ResultSet executeQuery(String query);  // query must resturn a single result set
int executeUpdate(String query);  // INSERT, UPDATE, DELETE statements
boolean execute(String query);  // Execute a query statement that may return multiple results
```

`ResultSet` fornisce l'accesso ai dati di tabelle generati dall'esecuzione di `Statement`; uno solo può essere aperto alla volta. Questo oggetto mantiene un puntatore alla riga corrente dei dati.

Il metodo `next()` sposta il cursore avanti di una riga, ma non si può tornare indietro mediante l'iteratore. Ritorna un booleano che indica se la riga successiva è stata trovata (disponibile).

Il metodo `close()` chiude il `ResultSet`.

## getType
Si utilizza per ottenere il tipo di dato di una colonna. Restituisce `Type`:
- Type getType(int idx)
- Type getType(String name)
- int findColumn(String columnName)

Per ogni tipo di dato:
- getString(idx)
- getByte(idx)
- ...

```
# PreparedStatement
Scenario: eseguire la seguente query:
```sql
SELECT * FROM videogame WHERE piattaforma = 'Amiga';
```

Immaginiamo di voler eseguire questa query molteplici volte, senza la necessità di doverla ricompilare ad ogni diverso valore di _piattaforma_. Con una query standard abbiamo la necessità di ricompilarla ogni volta. Con i `PreparedStatement` possiamo sostituire 'Amiga' con un placeholder (ovvero `?`).

Una seconda motivazione è la sanificazione dell'ingresso, che andrà sostituito con il placeholder. I `PreparedStatement` non permettono di concatenare query in sostituzione al placeholder. Evita attacchi di tipo SQL injection.

#Attenzione: i placeholder non possono essere usati al posto della tabella, in quanto la query è precompilata.

