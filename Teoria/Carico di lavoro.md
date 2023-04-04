# Definizione
>Il carico di lavoro su un DB è rappresentato da: dimensione dei dati e operazioni più significative che si presume verranno eseguite sul DB

## Regola 20 - 80
Secondo una regola empirica il 20% delle operazioni produce l'80% del carico

## Struttura fisica
>La **struttura fisica** dei dati comprende la struttura logica e la memorizzazione fisica dei dati

## Tabella dei volumi
>Il **volume dei dati** è il numero medio di istanze di ogni entità e associazione + cardinalità e dimensione di ogni attributo + copertura delle gerarchie

Il volume dei dati ci indica quanti dati sono contenuti in un DBMS

La **tabella dei volumi** contiene:
 - concetto -> nome dell'entità o della relazione
 - tipo -> E/R
 - volume dei dati -> numero puro

#Hint: calcola le cardinalità medie con Volume relazione / volume entità associata

## Tabella delle operazioni
>Le operazioni possono essere **interattive** o **batch**. Ci interessa valutare la frequenza, ovvero il numero medio di accessi per una certa operazione. Lo schema di operazione o **schema di navigazione** influenza il numero di accessi, data una certa operazione.

La **tabella delle operazioni** contiene:
- concetto
- accessi
- tipo -> I/B

#Hint: metti frecce di navigazione per capire l'ordine di accesso a entità e associazioni. Questo è chiamato schema di navigazione.

Questa tabella si ricava da quella dei volumi. #Attenzione: ricorda che anche le associazioni (relationship) contribuiscono al numero degli accessi

# Accessi
Gli accessi il **lettura** pesano 1. Gli accessi in **scrittura** pesano 2.

#Nota: i volumi di una associazione sono facilmente ricavabili se ha almeno 1 cardinalità di tipo (1, 1) con l'associazione "più vicina".

#Nota: i costi in lettura di moltiplicano via via che si compila la tabella. I costi dipendono dalla direzione di navigazione: prima entità incontrata / associazione.

#TODO: riporta esercitazioni

## Nella gerarchia di generalizzazione
Ci vengon fornite le percentuali che determinano quante parti del padre sono i vari figli.

Es: spesa divisa in
- 30% pasti
- 25% viaggi
- 5% alloggi

