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
- `COUNT`

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
GROUP-BY grouping-cond
HAVING selection-cond
ORDER-BY sort-cond
```

`GROUP-BY` ritorna un record per ogni gruppo -> `HAVING` può agire su uno o più attributi del raggruppamento o mediante funzioni aggregate (che ritornano un unico valore per ogni gruppo)

