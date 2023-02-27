# Componenti del sistema informativo

>SI - Sistema informativo = componente di una organizzazione che ha lo scopi di **gestire** informazioni, utili per gli scopi dell'organizzazione stessa: acquisizione, elaborazione, distribuzione, conservazione, produzione (valenze della *gestione*).


## Definizione dato e informazione

Dato != informazione

>Informazione = bene di valore crescente necessaro per pianificare e controllare che l'attività di produzione sia efficace. Equivalente di una materia prima in un processo produttivo (trasforma i semilavorati in prodotti finiti).

I *dati grezzi* forniscono informazione solo se interpretati nel giusto contesto. In sè non costituiscono informazione.
Spesso legando una serie di dati con metadati si ottiene una *informazione*.

In ordine di "finezza", in una organizzazione, abbiamo: fonti informative primitive, informazioni selezionate, report, decisioni statistiche.

Fino a questo punto non abbiamo parlato di "computer". Questo è il **sistema informativo**.

Automatizzare la gestione del sistema informativo porta ad un **sistema informatico**.

>Base di dati - DB = chiamato anche database o data base è una collezione di dati che rappresentano **informazioni** di interesse per un'organizzazione. Il DB è una collezione di dati gestita informaticamente da un **DBMS** - Database Management System

# Modellazione di un DB
Parto da un sottodominio della realtà e cerco di modellarlo.
Il modello **entity-relationship** prevedi di usare un quadrato per l'entità e un rombo per l'associazione.

Il modello concettuale contiene **dati** e **vincoli** (vincoli di integrità).

Il DMBS memorizza il DB e i dati da esso contenuti su una memoria secondaria (memoria di massa).

## Struttura di un DBMS
1. **Parser**: linguaggio tipo SQL per la gestione del database relazionale
2. **Scheduler**: spesso e volentieri si desidera un dbms multi-utente
3. **Moduli di accesso**: regolano la memorizzazione su disco

## Estrazione informazioni
L'SQL è **imperativo**, non procedurale. Richiedo un'azione ed essa viene svolta dal DBMS

- Interrogazione -> `SELECT`
- Eliminazione -> `DELETE

Vedi: CRUD - Create, Read, Update, Delete

# Ruolo del DBMS
Da memorizzazione su filesystem a DBMS: al posto di avere file duplicati e potenzialmente inconsistenti su filesystem (magari proprietario) si preferisce avere un software gestore rispettando vincoli di integrità e consistenza.

Più applicazione utilizzano gli stessi dati. Spesso le informazioni necessarie al funzionamento di un'applicazione sono sempre le stesse.

Vedi: SAP/Sybase, fondata da 5 ex dipendenti IBM in Germania.

Prima del cloud (picco nel 2010) si ha un boom di vendite DBMS Oracle -> modello _on premise_.
Quando la migrazione verso il cloud si fa sentire, Oracle scende; salgono invece Google e Microsoft.

Vedi: Gartner quarter chart

Vedi: Mongo, Postgre, Elasticsearch, Redis

DBPaaS - Database platform as a service

