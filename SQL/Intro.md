> Nella select si possono inserire operazionim anche aritmetiche

## WHERE
- `BETWEEN 1 AND 10`
- `LIKE 'LOG%'` -> stringa arbitraria
- `LIKE 'TEST_'` -> carattere arbitrario

## SELECT
Con `DISTINCT` non abbiamo istante ripetute nel risultato della select

## Risultati dei confronti
- True
- False
- Unknown
	- restituito quando il confronto è del tipo `Citta = 'Milano'` ma `Citta` è `NULL`

V AND U = U
V OR U = V

F AND U = U
F OR U = U

NOT U = U

Il predicato di selezione non è soddisfatto dal risultato Unknown

## JOIN
Esistono due varianti:
- condizione su `ON`
- condizione su `WHERE`

Nei join ternari conviene sempre usare la condizione su WHERE
```sql
SELECT VOTO
FROM STUDENTE, CORSO, ESAME
WHERE STUDENTE.MATR = CORSO.MATR
AND CORSO.MATR = ESAME.MATR
```
#Nota: nell'algebra relazionale la proiezione è un predicato posizionale. Nell'SQK se più tabelle hanno lo stesso attributo, si genera ambiguità.

### Alias con AS
Dipendenti che hanno come manager _Giorgio_ (**self-join**):
```sql
SELECT X.NOME
FROM IMPIEGATO AS X, IMPIEGATO AS Y
WHERE X.MATR-MGR = Y.MATR
AND Y.MATR = 'Giorgio'
```

# Esercizio
Selezionare i tipi di progetto dove lavora Giovanni:
```sql
SELECT TIPO
FROM IMPIEGATO AS I, ASSEGNAMENTO AS A, PROGETTO AS P
WHERE I.NOME = "Giovanni"
AND I.MATR = A.MATR
AND A.NUM-PROG = P.NUM-PROG
```

Selezionare il manager di Piero:
```sql
SELECT Y.NOME
FROM IMPIEGATO AS Y, IMPIEGATO AS X
WHERE X.NOME = "Piero"
AND X.MATR-MGR = Y.MATR
```

Aggiornare il salario di Pietro a 3000 euro:
```sql
UPDATE IMPIEGATO SET SALARIO = 30000
WHERE NOME = "Pietro"
```

Aumentare il salario di Giorgio del 5%:
```sql
UPDATE IMPIEGATO
SET SALARIO = SALARIO * 1.05
WHERE NOME = "Giorgio"
```