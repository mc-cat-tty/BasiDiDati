# Testo
Portale a cui possono accedere:
- agenzie di viaggio
- utenti online

Il sistema memorizza:
- dati degli utenti: username, nome, cognome, data di nascita
- dati agenzie di viaggio: codice, nome, città
- tour operator: nome, rosa di villaggi vacanze
- villaggio: nome univoco per tour operator, serie di ristoranti (con cucina diversa), serie di piscine (con diversa profondità max)

Ogni villaggio ha da 50 a 200 alloggi (di cui è memorizzata la disponibilità):
- stanze (small, large)
- appartamenti
- suite

Agenzie e utenti possono prenotare. La richiesta prevede:
- periodo del pernottamento (data inizio e fine)
- data prenotazione
- lista degli ospiti (per le agenzie)

Gli utenti possono effettuare una sola richiesta per una certa data, mentre le agenzie non hanno limite.

Come identificare il ristorante? se usiamo il tipo come id, il ristorante si potrà ripetere su più villaggi -> card_max = N

## Villaggi con piscina e/o ristorante
Gerarchia generalizzazione parziale e sovrapposta

Vedi: identificatore semantico

## Relazione agenzia, utente, alloggio
Usando una relazione binaria _richiede_ tra utente e alloggio e tra agenzia e alloggio, un'agenzia non può fare più prenotazioni verso lo stesso alloggio all'interno della stagione

Nota: nelle gerarchie di generalizzazione posso ripetere gli attributi delle entità "specializzate", in più posso avere un id per l'entità generalizzata e uno per l'entità specializzata

# Soluzione finale

![[Esercitazione 2.png]]