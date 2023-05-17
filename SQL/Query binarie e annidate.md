# Query binarie
Possono essere costruite a partire da altre query, applicando operazioni insiemistiche (UNION, INTERSECT, EXCEPT) al risultato dell'interrogazione. Si sta lavorando con dei set, quindi i duplicati verranno rimossi.

# Subquery
> Si ottengono quando il predicato di where lavora sul risultato di un'altra query: si stanno concatenando due query diverse nel suddetto predicato

Operatori:
- Appartenenza: `[NOT] IN`
- Quantificatori: `ANY, ALL`
- Esistenza: `[NOT] EXISTS`
- comparatori (segni di disuguaglianza) tradizionali

Esempi:
```sql
WHERE <ATTR> <OPERATORE> [ANY|ALL] (<SUBQUERY>)
```
- ANY -> vero se la condizione è soddisfatta da almeno uno dei risultati della subquery
- ALL -> vero se la condizione è soddisfatta da tutti i risultati dellasubquery

```sql
WHERE [NOT] EXISTS (<SUBQUERY>)
```
- EXISTS -> vero se il set ritornato da SUBQUERY è non vuoto
- NOT EXISTS -> vero se il set è vuoto

# Riduzione query annidate
Query riducibili a query elementari/semplici:
- IN
- ANY con un operatore di confronto
- EXISTS con subquery correlata

Query non riducibili:
- NOT IN
- ALL
- NOT EXISTS

