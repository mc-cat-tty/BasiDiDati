Sviluppato da *Peter Chen* nel 1970 -> unificare la rappresentazione dei modelli su differenti DBMS.

# Elementi di base
- **entità** -> graficamente un **rettangolo**. Rappresenta uninsieme di oggetti con proprietà comuni.
- **associazione** -> inizialmente pensata per associazioni binarie. Rappresenta un legame logico tra due o più entità (entity-set). Graficamente un **rombo**

Sia l'associazione che l'entità possono avere degli attributi.
Es: voto e data sulla relazione studente - esame

Il pallino nero affianco ad un attributo significa che è univoco (può essere usato come chiave).

## Anello
> Associazione binaria tra entità e se stessa.

Il **ruolo** dell'entità è indicato tramite una label.

Già presente in Chen. Successivamente è stato introdotta la cardinalità.

![[anello.png]]

## Associazioni n-arie
Es: bibliotecario, libro, chi prende in prestito

Es: insegnamento, aula, giorno

![[associazione_n_arie.png]]


# Attributi
>**Dominio dell'attributo**: insieme dei valori legali dell'attributo.

Un attributo è **semplice** se definito su un solo dominio.

Data E associazione o entità; A attributo di E:
- cardinalità minima: numero minimo di valori dell'attributo associati a E
- cardinalità massima: massimio numero di valori dell'attributo associati a E
- 
- opzionale: min-card(A, E) = 0
- obbligatorio: min-card(A, E) = 1
- 
- valore singolo: max-card(A, E) = 1
- valore multiplo: max-card(A, E) > 1

Il valore di default è (1, 1)

Una cardinalità (0, N) sta ad indicare un attributo multiplo.

## Ereditarietà delle proprietà
>Tutte le proprietà (attributi, associazioni e generalizzazioni) dell'entità **generalizzate** sono **ereditate** dalle entità **generalizzate**. 

A differenza della OOP l'ereditarietà è stretta. Le proprietà ereditate possono assumere un insieme di valori (al massimo) ristretto rispetto all'insieme originale.

Attento: riportare gli attributi comuni (generalizzazione) sulle entità generalizzate è errato

## Subset
> Un **sottoinsieme** è una gerarchia di generalizzazione con una sola classe generalizzata. La sua copertura è parziale.

Vedi: logica parallela, logica comparatoria e definitoria

# Identificatori
> Un identificatore di una **entità E** (le associazioni non hanno identificatori) è una collezione di attributi e/o entità in associazione con E, che permette di individuare univocamente le istanze di E.

## Definizione formale
Data un'entità E:
- $A_1, ..., A_n$ sono gli attributi interni che compongono l'identificatore.
	- **a valore singolo**
	- **obbligatori**
	- ==> Cardinalità (1, 1)
- $E_1, ..., E_n$, ovviamente diverse da E, sono le entità esterne che compongono un identificatore.
	- Connesse a E da **associazioni binarie** (non n-arie)
	- **obbligatorie** (min_card = 1) e cardinalità massima **many to one** ==> cardinalità (1, 1)

## Requisiti minimi
I è identificatore E se:
1. Non esistono due istanze di E con lo stesso valore di I
2. Eliminando un elemento da I (sia $A_i$ che $E_j$), la prima proprietà non è valida (identificatore **minimale**)

## Classificazione
Numero di attributi interni ed entità esterne:
- **Semplice** n+m = 1
- **Composto** n + m > 1

Presenza di entità esterne:
- **Interno** m = 0
- **Esterno** n = 0
- **Misto** se n > 0 e m > 0

Attenzione: evita circolarità

## Entità forte ed entità debole
L'entità è **debole** se gli identificatori sono solo esterni -> solitamente disegnata con **doppio rettangolo**.

L'entità è **forte** se gli identificatori se sono solo interni.

## Esempio
### Persona
Attributi interni (entità forte):
- Codice Fiscale
- SPID

### Dipartimento
La matricola di un dipendente è unica all'interno del dipartimento:
- IMP -> entità impiegato
- DIP -> entità dipartimento

I = {MAT, DIP} -> si scrive intersecando gli attributi che contribuiscono all'identificatore

![[dipartimento.png]]

### Distinta d'ordine
Ogni linea d'ordine rappresenta: prodotto, costo, quantità

Descrizione in linugaggio naturale:
- ogni linea d'ordine è relativa ad un prodotto -> ogni prodotto è identificato in modo univoco dal numero di linea nella distinta
- il dettaglio d'ordine è identificato univocamente dal numero linea nella distinta

![[distinta.png]]

Il dettaglio d'ordine è identificato da prodotto e distinta d'ordine.
Il pallino di NUMERO_LINEA è vuoto perchè è un identificatore esterno.

# Attributo vs Associazione
Esempio: studente e facoltà

È da preferire l'opzione che aggiunge meno elementi allo schema concettuale, se non mi serve modellare la relazione tra le entità. ->  minimzzare la ridondanza

Dipende dall'entità su cui si vuole **predicare**

>Regola base: se l'entità ha un identificatore, oppure sono costretto a modellare gli attributi secondo vincoli, devo preferire entità e associazione rispetto all'attributo

Con entità:
![[studente_facoltà.png]]

Con attributi:
![[studente_attributi.png]]

Preferisco la seconda se lo schema è così semplice. Se aggiungessi l'attributo `CITTÀ_FACOLTÀ` a `FACOLTÀ` mi converrebbe il primo caso, pre diminuire la ridondanza.

# Vincoli di integrità
>Condizione che deve essere soddisfatta dalle istanze di una base di dati

## Tipi di vincoli ER esteso
- **vincoli di cardinalità**
- **vincoli di copertura** per generalizzazoine. Es: totale, parziale, overlapping, ecc
- **vincoli di identificazione**: definire un identificatore per un'identità implica una condizione di unicità dei valori coinvolti nell'identificatore

Esempio:
- entità *persona*
- attributi *data, persona, luogo*
- identificatore *(data, persona)*
=> limito il mio universo di possibili valori. Non può esistere (P1, D1, L1) e (P1, D1, L2) con L1 != L2
![[viaggio_attributi.png]]

Alternativa:
![[viaggio_entità.png]]

In questo modo perderei il vincolo, devo reintrodurlo tramite la **reificazione**

Possono esistere:
- (P1, L1)
- (P1, L2)
Ma non:
- (P1, L1)
- (P1, L1)
--> una persona non può andare nello stesso luogo

Perchè la relazione `Viaggio` costituisce un set

In una relazione ternaria le triple uguali tra loro non possono esistere.

------

Esempio:
![[loop_impiegato.png]]

In questo modello ER non è vietata l'esistenza della tupla (I1, I1)

Il set a cui dà vita la relazione Dirige ci indica che non possono esistere due tuple (Ii, Ij) uguali tra loro.

È come avere un insieme da cui si estraggono gli impiegati con rimpiazzo.

# Reificazione
>Rappresentare un'associazione tramite un'entità

Punto di partenza:
![[pre_reificazione_associazione.png]]

Voglio trasformare `A` in una entità:
![[reificazione1.png]]


Nel processo di reificazione la cardinalità tra R1 - A e R2 - A è (1, 1)
Le restanti cardinalità sono quelle che derivano dalle cardinalità originali tra E1, E2 e A

Ogni entità deve essere identificata da un identificatore.

Con l'associazione (secondo schema), non possono esistere due istanze di viaggio con persona e luogo analoghe, la data può variare a piacere.

Con la reificazione (primo schema), una persona può viaggiare verso un certo luogo una sola volta a parità di data. Genero il set (Persona, Data), usati come valore di confronto.

![[reificazione_con_id.png]]

