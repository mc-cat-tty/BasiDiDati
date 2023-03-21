La metodologia per il progetto concettuale è:
![[Screenshot_20230313_105111.png]]

- Requisiti funzionali = cosa devo farve con i dati (elaborazione)
- Requisiti applicativi = interazione con il DB (?)

Fin'ora ci siamo occupati solo del *progetto dei dati*

Vedi: DFD - Data Flow Diagram

# Trasformazioni primitive
#consiglio: costruzione incrementale dello schema ER -> si parte da una percezione della realtà e si raffina progressivamente

> **Primitive di raffinamento** trasformazioni che, applicate allo schema scheletro, producono lo schema finale

>**Strategie di progetto**: top down, bottom up, mixed

Insieme ci danno la **metodologia di progetto**

## Primitive per il progetto concettuale
Processo iterativo durante il quale si applicano **trasformazioni di schema**

Vedi: ![[ER6.pdf]]
#attenzione: in una gerarchia di generalizzazione, le entità specializzate acquisiscono tutti gli attributi dell'entità generalizzata

### Primitive top down
>Per definizione si scede di livello di astrazione


Si parte da un concetto semplice (schema scheletro) e si trasforma in un piccolo insieme di concetti (schema finale).

- un'entità viene trasforma in gerarchia di generalizzazione o sottoinsieme
![[Screenshot_20230320_095007.png]]

- un'associazione è trasformata in una o più associazioni tra le stesse entità ![[Screenshot_20230320_100232.png]]

- un'associazione è trasformata in un **cammino** di entità e associazioni (entrambe le cose) ->  equivale alla reificazione
![[Screenshot_20230320_102222.png]]

- vengono introdotti attributi in un'associazione o un'entità
![[Screenshot_20230320_102523.png]]

- generazione di entità o attributo

### Primitive bottom up
>Per definizione si sale di livello di astrazione

Introducono nuovi concetti e priprietà, non presenti nelle versioni precedenti dello schema.

Da scegliere quando si vuole integrare schemi differenti in uno schema più comprensivo: **integrazione di schemi**

## Strategie per il progetto concettuale
- top-down
- bottom-up
- mixed: si usano entrambe le strategie 

## Raffinamenti inside out
Come ad esempio la trasformazione di un attributo in entità, a cui si possono aggiungere ulteriori attributi.

## Progettazione dal linguaggio naturale
1. frasi del linguaggio naturale
2. analizzo il testo e filtro le ambiguità
3. estraggo concetti chiave
4. produco il glossario dei dati e lo schema scheletro
5. raffino lo schema scheletro con le primitive di progettazione concettuale
6. arrivo allo schema concettuale
7. verifico le operazioni (controllo di completezza)

## Caso studio: databse società sportiva
#TODO

### Navigazione
Operazioni sul DB:
- R - Read
- I - Insert
- U - Update
- D - Delete

Ricorda le frecce di navigazione

# Stime volumi
Obiettivo: 

TODO: finisci

#vedi: entity integrity

