# Ordinamento

```sql
SELECT * FROM ORDINE
WHERE IMPORTO < 10.000
ORDER BY DATA [ASC|DESC], [DATA [ASC|DESC]] ...
```

# Funzioni aggregate
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `COUNT` -> È valido `COUNT([ALL|DISTINCT] ...)`

> #Nota: i NULL sono esclusi dalle funzioni di aggregazione

## Esempi
```sql
SELECT MAX(IMPORT) AS MAX-IMP
FROM ORDINE
WHERE condizione
```

# Raggruppamento
Si usano `GROUP BY` e `HAVING` 

```SQL
SELECT attributes
FROM tables
WHERE conditions
GROUP BY grouping-cond
HAVING selection-cond
ORDER BY sort-cond
```

`GROUP-BY` ritorna un record per ogni gruppo -> `HAVING` può agire su uno o più attributi del raggruppamento o mediante funzioni aggregate (che ritornano un unico valore per ogni gruppo)

# Divisione
Presente in algebra relazionale, ma non in SQL:
> selezionare i dati degli ordini che contengono tutti gli i prodotti con prezzo superiore a 100

Si può riformulare come:
> selezionare i dati degli ordini che non contengono prodotti (non esiste alcun prodotto) di prezzo superiore a 100 che non sia contenuto in essi

In SQL:
```sql
SELECT * FROM ORDINE O WHERE NOT EXISTS (
	SELECT * FROM PRODOTTO
	WHERE P.PREZZO > 100
	AND NOT EXISTS (
		SELECT * FROM DETTAGLIO D
		WHERE P.COD-PROD = D.COD-PROD
		AND D.COD-ORD = O.COD-ORD
	)
)
```
