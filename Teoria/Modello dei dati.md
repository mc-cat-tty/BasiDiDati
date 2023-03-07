>Il **modello dei dati** è una collezione di strutture e regole che permettono di rappresentare la realtà di interesse

Si divide in **schema** (rappresentazione della realtà secondo un modello) e **istanza** (valori dei dati memorizzati).

Esistono due tipi di modelli:
- **concettuali**: descrizione indipendente dagli aspetti implementativi, come uno schema ER
- **logici**: descrizione supportata dal DBMS (tiene conto dell'implementazione). Es: reticolare, relazionale, gerarchico, a oggetti, a grafo

Nel '72 nascono i modelli concettuali, più ricchi del modello logico e soprattutto più flessibili. Indipendenti dal 

RDBMS - Relational Database Management System

# Modello relazionale
È un **modello logico** -> il + diffuso.

I dati sono mantenuti in tabelle, che possono essere relazionate tra loro -> *tabelle* e *relazioni*

Nome relazione + colonne coinvolte + tipo colonne costituiscono lo **schema**

Lo schema, ovvero il modello (impostazione delle colonne e relazioni), è praticamente **invariante** rispetto al tempo. Mentre l'istanza, ovvero le righe sono variano molto rispetto al tempo.

Le tabelle si dicono tra loro **correlate**.

Gli **oggetti aggregati** hanno spesso dei vincoli di integrità di esistenza. Se relaziono studente, insegnamento e voto preso, tutte queste entità devono esistere nel'istanza del DB.

## Esempio

![[relazione_esame.png]]

- Ogni studente ha un numero di matricola univoco (pallinino nero) e un cognome
- Ogni corso ha un nome univoco, mentre il docente non è univoco, infatti potrebbe avere più di un corso
- (0, N) è la cardinalità della relazione, scritta nella forma (MIN, MAX) -> ogni studente puà sostenere da 0 a N esami
- Con questo simbolo di associazione (rombo) ogni studente può sostenerte al massimo un esame per ogni corso. È un set, non una bag.

Tradotto in un modello logico:
![[relazione_esame_logica.png]]

Si perdono vincoli di integrità come le cardinalità e le relazioni, che si potrebbero specificare con una *foreign key* -> intestazione tabella sottolineata.

## Vincoli del modello
I dati che si vogliono rappresentare devono spesso rispettare dei **vincoli**. Nell'esempio del database POOC:
- ogni cassa ha un numero univoco
- ogni persona può essere associata al più ad una cassa
- il prezzo di un prodotto non deve variare durante il giorno

# DBMS
Un database management system è un software che gestisce un DB -> passiamo da un sistema informativo ad un sistema infromatico. Il DB in quanto collezione dei dati può esistenere senza ausilio di computer.

Per interagire con il DBMS si usa un linguaggio **dichiarativo** come l'SQL.

----
Nei linguaggi **dichiarativi** si DICHIARA quello che si vuole fare, senza specificare i passi da eseguire per arrivare all'obiettivo.

Nei linguaggi **procedurali** si definiscono i passi per arrivare alla soluzione. Che si dividono in ad oggetti, funzionali e logici.

---

Il codice SQL, dichiarativo, passa per un ottimizzatore.

# Indipendenza
Due tipi:
- dipendenza fisica -> **organizzazione fisica** che dipende da considerazioni legate all'efficienza, ma non deve avere effetti collaterali sui programmi applicativi. Il modo in cui il DBMS memorizza i dai è indipendente da DB e comportamento funzionale.
- dipendenza logica -> non è necesasario nè conveniente che ogni utente abbia una visione uniforme del DB. Lo schema logico è indipendente dalla sua implementazione.

![[struttura_tre_livelli.png]]

Il **livello esterno** definisce delle *viste* della base di dati, ovvero una porzione della base di dati di interesse.

# Implementazione di un RDBMS
```SQL
CREATE TABLE ESAME (
	MATRICOLA INTEGER NOT NULL,  -- Per inserire un esame la matricola DEVE essere assegnata
	NOME CHAR NOT NULL,  -- Il nome dello studente DEVE essere assegnato
	VOTO INTEGER,
	PRIMARY KEY (MATRICOLA, NOME)  -- Non posso inserire studenti con stesso numero di matricola e stesso nome
)
```


# Astrazione

> Uno **schema** è la rappresentazione di una realtà secondo un determinato modello. Se ad una porzione di realtà applico un modello logico posso ottenere ad esempio una descrizione SQL, se applico un modello concettuale ottengo uno schema ER.

L'astrazione è un processo mentale con cui si evidenziano solo alcune proprietà e caratteristiche fondamentali di un oggetto o di una realtà, escludendo quelle non rilevanti.

Le tre primitive di astrazione sono:
- **classificazione**: a partire da un insieme di oggetti con caratteristiche comuni, se ne estrae una classe. Esempi di classi sono: studenti di ing, studenti di inf, studenti del primo, secondo e terzo anno. L'idea 
- **aggregazione**: si definisce un entità a partire da sottoclassi/sottoparti. Es: `studente part of esame`, `insegnamento part of esame.`
- **generalizzazione**: si trova un padre alla gerarchia, che prenda sotto di sè più classi. Il concetto inverso è _is a_. Persona generalizza uomo e donna. `Uomo is a persona`, `Domna is a persona`. Viene stabilita una relazione tra gli elementi dalla superclasse e delle sottoclassi.


## Mapping tra classi - aggregazione binaria
Si usa l'**aggregazione binaria**: corrispondenza tra due classi, come esame esempio di aggragazione binaria tra corso e studente.

## Cardinalità
Data A aggragazione tra due classi C1 (corso) e C2 (studente):
- *cardinalità minima* di C1 in A -> min-card(C1, A) è il numero minimo di associazione che gli oggetti di C1 devono avere con gli oggetti di C2. Es: min-card(C1, A) = 1 obbliga ogni corso ad avere uno studente associato.
- *cardinalità massima* di C1 in A -> max-card(C1, A) è il numero massimo di elementi di C2 che possono essere asociati ad ogni elemento di C1. L'esame di ogni corso può essere sostenuto al massimo da tutti gli studenti (tutti elementi di C2)

### Corrispondenze
**One to one**: max_card(C1, A) = 1, max_card(C2, A) = 1
**One to many**: max_card(C1, A) = 1, max_card(C2, A) = N
**Many to one**: max_card(C1, A) = N, max_card(C2, A) = 1
**Many to many**: max_card(C1, A) = N, max_card(C2, A) = N

Nell'esempio corso, esame, studente:
- per ogni corso c'è stato almeno un esame -> min_card(CORSO, ESAME) = 1
- ogni corso ha avuto un numero di esami generico N -> max_card(CORSO, ESAME) = N
- alcuni studenti non hanno studenti non hanno sostenuto esami -> min_card(STUDENTE, ESAME) = 0
- ogni studente può aver sostenuto un numero variabile di esami -> max_card(STUDENTE, ESAME) = N

Una notazione più comoda potrebbe essere:
- card(CORSO, ESAME) = (1, N)
- card(STUDENTE, ESAME) = (0, N)

## Aggragazione n-arie
Aggrego tra loro N classi C1, ..., Cn secondo un'aggregazione A

Esempio: l'orario settimanale mette in relazione corso, aula, giorno (aggregazione ternaria)
Dove `card(CORSO, ORARIO_SETT) = (1, 5)` ("un corso si può tenere da una a 5 volte alla settimana, nello stesso giorno o in giorni diversi, nella stessa aula o in aule diverse"), `card(GIORNO, ORARIO_SETT) = (0, n)` ("posso avere corsi da da 0 a N volte alla settimana"), `card(AULA, ORARIO_SETT) = (0, 40)` ("ogni aula ospita al max 40 corsi alla settimana")

# Generalizzazione
Definisce il legame tra gli elementi di una classe *generalizzazione* e gli elementi delle classi generalizzate.

## Totale o parziale
- **t** - totale: ogni elemento della classe *generalizzazione* è in relazione con almeno 1 elemento delle classi generalizzate. La generalizzazione esaurisce gli elementi generalizzati
- **p** - parziale: alcuni elementi delle classi generalizzate, non sono mappate a nessun elemento della classe *generalizzazione*

## Sovrapposta o esclusiva
- **e** - esclusiva: ogni elemento della clase generalizzazione è in relazione con al massimo un elemento delle classi generalizzate (Es: Persona <- uomo, donna)
- **o** - sovrapposta (overlapping): alcuni elementi della classe generalizzazione possono essere in relazione con più di una (due o più) entità delle classi generalizzate (Es: )

![[generalizzazione_insiemi.png]]

## In forma matematica
