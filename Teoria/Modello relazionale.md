Introdotto da Codd nel '70

## Dominio
Insieme dei valori $D = {v_1, v_2, ..., v_k}$

# Tupla
# Prodotto cartesiano
Il prodotto cartesiano tra 
# Rappresentazione tabellare
L'insieme di tuple generato dal prodotto cartesiano fra due o più insiemi si può rappresentare come una tabella -> `CREATE TABLE ...`

# Schema ed istanza
## Attributo
>Quando viene dato un nome al dominio dei valori di una relazione.

Conseguenze:
- *indipendenza* dall'ordinamento dei domini
- acquisizione di *significato* per i valori del dominio

| Attr1 | Attr2 | Attr3 |
| ----- | ----- | ----- |
| v11   | v21   | v23   |
| v12   | v22   | v33   |
| ...   | ...   | ...   |
|       |       |       |

## Schema di relazione
>Uno *schema di relazione* è la coppia costituita dal nome della relazione R e dall'insieme di nomi degli attributi X = {$A_1, A_2, ..., A_n$}. Si indica con R(X)

## Istanza di relazione
>Un'istanza di relazione su uno schema R(A1, A2, ..., An) è un insieme di r tuple su (A1, A2, ..., An)

Nota: prime lettere dell'alfabeto per gli attributi semplici, ultime lettere per gli attributi composti

## Schema di base di dati
>Insieme di schemi di relazioni $R = {R_1(X_1), R_2(X_2), ..., R_n(X_n)}$

A livello concettuale tutti i nomi di relazione devono essere differenti. L'SQL non sarà consì strict. Nasce una differenza tra *tabelle* (DBMS) e *relazioni*

## Istanza di base di dati
>Dato lo schema di base di dati $R = {R_1(X_1), R_2(X_2), ..., R_n(X_n)}$ una sua istanza è una sua "realizzazione":
>insieme di relazioni $r = {r_1, r_2, ..., r_n}$ con $r_i \in R_i$ per i tra 1 e n

## Insieme degli attributi
*Dot notation*: un sottoinsieme di attributi $Y \subseteq X$ dello schema R(X) può essere indicato con R.Y

- A <- {A}
- XY <- {X} U {Y}

Presa una tupla _t_ su R(X) e $A \in X$:
- t\[A\] o t.A è il valore di t su A
- t\[Y\] è la sottotupla estratta da t considerando solo gli attributi di Y

## Esempio concreto
Schema di basi di dati *DB_UNIVERSITÀ*:
```SQL
DB_UNIVERSITÀ = {
	STUDENTE(MATR, NOME, CITTÀ, CORSO)
	CORSO(CODCOR, NOME, CODDOC)
	DOCENTE(CODDOC, CF, CITTÀ)
	FREQUENZA(MATR, CODCOR)
}
```

In questo caso:
- STUDENTE, CORSO, DOCENTE sono entità nel modello ER
- FREQUENZA è una associazione
- Tra DOCENTE e CORSO esiste una relazione implicita: CODDOC è una foreign key

## Chiavi
Nel modello relazionale non si parla di identificatori ma di **chiavi**

>Per chiave di una relazione si indende un sottinsieme dei suoi attributi che identifica in modo univoco ogni tupla della relazione stessa

Questa proprietà deve valere per qualsiasi variazione dei dati.

>Data la relazione R(X) e $K \in X$, essa è detta chiave della relazione R se e solo se per ogni relazione $r$ su R(X) valgono le seguenti proprietà:

### Proprietà
- **univocità**: $\forall t_1, t_2 \in r, t_1[K] = t_2[K] \implies t_1 = t_2$ due chiav
- **minimalità**: $\forall A_i \in K, K-A_i$ (tolto qualsiasi attributo da K) questo nuovo insieme non soddisfa la proprietà 1

### Superchiave
>Dato un sottoinsieme di attributi che contiene la chiave ($K \subset Y \subset X$), esso è detto superchiave della relazione R(X)

### Notazione
Nel modello relazionale le *chiavi candidate* vengono *sottolineate*, tra queste è scelta:
- una chiave **primaria**
- le restanti sono **chiavi alternative**

### Foreign key
![[2018-07-image9-min-14-1024x459.png]]

Notazione: `CORSO (CODICE, NOME, CODDOC) FK: CODDOC REFERENCES DOCENTE`

## Valori nulli
Ogni dominio di relazione può essere esteso con un **valore nullo** o `null`, che rappresenta assenza di informazione. Questo permette di inserire tuple il cui valore di alcuni attributi non è definito.

L'ANSI ha definito 14 diverse interpretazioni di questo valore.

https://en.wikipedia.org/wiki/Null_(SQL)

## Vincoli di integrità
Stabiliscono la correttezza delle informazioni presenti nella base di dati

### Entity integrity
Gli attributi che costituiscono la chiave primaria o alternativa di una relazione NON possono essere nulli

### Integrità referenziale
Assicura che quando in una tupla si usa il valore di un attributo per riferirsi ad un'altra tupla (foreign key) esso sia esistente.

Vedi: operazione `JOIN`

Nel modello ER le associazioni sono sempre implicitamente valide

Il vincolo di integrità referenziale viene specificato con:
- **foreign key** (chiave esterna): insieme degli attributi FK = {FK1, FK2, ..., FKn} dello schema di relazione $R_1 \in R$
- **chiave della relazione riferita**: schema $R_2 \in R$ non necessariamente distinto da $R_1$ con una chiave $K = {K_1, K_2, ..., K_m}$ con m = n

Definizione formale: $\forall t_1 \in r_1, \quad t_1[FK_i] = null \quad V \quad \exists t_2 \in r_2 \quad | \quad t_1[FK_i] = t_2[K_i], \quad \forall 1 \leq i \leq n$

Quando una relazione è costituita solamente da foreign key, ho l'equivalente di una associazione in ER.

# Gerarchia di generalizzazione nel modello relazionale
Il selettore serve a discriminare l'appartenenza di una entry ad una entità che la specializza.

#TODO: lezione sul collasso della gerarchia di generalizzazione

# Forme normali
Definiscono criteri di qualità e ci forniscono delle linee guida per evitare la ridondanza, sfruttando le **dipendenze funzionali**. Cosa sono?
>**Def. dipendenza funzionale**: dato lo schema relazioneale $R(X)$, una FD su R è un vincolo di integrità Y -> Z, dove Y è chiamato determinante e Z determinato.


#TODO: Seconda parte

## Dipendenze funzionali banali
Una chiave (o una superchiave) determina funzionalmente tutti gli attributi
>Se $Y \subseteq Z$, allora $Z \rightarrow Y$


#TODO: slide successiva

## Esempio: studente e corso
#TODO: immagine e traduzione

Le dipendenze funzionali hanno sul lato sinistro una chiave, se la traduzione è stata fatta correttamente.

Se sbaglio, #TODO: traduzione sbagliata, vedo che il determinante non è una chiave. Questo comporta ridondanza:
- anomalia di modifica: se un corso cambia docente non bisogna aggiornare una riga del database, ma tutte le entry che lo contengono
- anomalia di inserimento: un corso non può esistere senza almeno uno studente che lo segua
- anomalia di cancellazione: cancellando tutte le frequenze relative a un corso si perde docente

Una modellazione del genere infrange la 2NF - 2nd normal form

#Vedi: Data warehouse

### 2NF
Informalmente serve a definire schemi senza problemi dati dalla dipendenza parziale di un attributo dalla chiave.

#TODO: dipendenza completa

>Un **attributo primo** è un attributo che fa parte di almeno una chiave

#TODO: completa definzione
>Uno schema è in **2NF** se e solo se ...


### 3NF
>Uno schema è in **3NF** se e solo se per ogni dipendenza funzionale non banale (X -> A): o A è primo o X è superchiave

#Nota: $3NF \Rightarrow 2NF$

### BCNF - Boyce Codd normal Form
>Uno schema è in **BCNF** se e solo se per ogni dipendenza funzionale non banale (X -> A), X è superchiave..

# Esercizi
#TODO: recupera primo esercizio
## Vaccinazioni
#Nota: quando hai un subset di una entità riporta tutti gli attributi del padre nel figlio
#Nota: le associazioni con cardinalità (1, 1) possono essere inglobate

#TODO: svogli esercizio

## Modellazione: Tokyo
Entità:
- sedi con codice univoco
	- piscine: indirizzo, caratteristiche tecniche
	- acque libere: descrizione
- discipline: nome, genere, record olimpico e mondiale
- gara: relativa a una disciplina, si svolge in un certo slot temporale, in una solo sede + fase (qualificazione, semifinali, ecc). Più gare non si possono svolgere nello stesso slot temporale
- partecipante: codice univoco, singolo atleta o staffetta, può prendere parte a più gare
- atleta: identificatore, nome, cognome, data di nascita, luogo di nascita, nazionalità, sesso, allenatore che lo segue
- la staffetta ha un numero di atleti che varia da 4 a 8

#TODO: finisci diagramma

## Modellazione: Catalogo
#TODO: tutto

L'identificatore di turno è dipendente + data, in modo che non possa ripetere il turno più volte nella stessa data.

Chiave alternativa: codice macchinario, data, turno (se ho i turni di lavoro divisi su mattina e pomeriggio)

#Nota: fai tabellina per capire le chiavi alternative -> usate per creare vincoli


