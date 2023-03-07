Entità:
- **manifestazione**: descritta da codice e nome, *costituita* da due o più **spettacoli**
- ***spettacolo***: descritto da numero univoco all'interno della manifestazione e dall'ora di inizio; si *esibiscono* più **artisti**. Ogni spettagolo viene *ospitato* in un **luogo**.
- **artista**: descritto dal codice SIAE e dal nome d'arte; *necessita* di un artista sostitutio in caso di indisponibilità. Un artista può fare da sostituto per più artisti. Un artista si può esibire una sola volta durante lo stesso spettacolo.
- **luogo**: nome e indirizzo. In una certa data un luogo può ospitare al massimo 3 spettacoli, anche di manifestazioni diverse.

L'associazione *sostituisce* è un anello.

# Sviluppo
Hint: parti da schema scheletro

Attenzione: il numero di spettacolo non è univoco di per sè

L'identificatore Numero Spettacolo (attributo) + Manifestazione (entità) è mixed (composto)

Se fosse stato aggiunto il vincolo: _non possono esistere due o più vincoli con la stessa ora di inizio_ -> IDENTIFICATORE_SPETTACOLO = {MANIFESTAZIONE, NUMERO, ORA DI INZIO}

Per definizione in un attributo multivalore non può essere ripetuto più di una volta.

Attenzione: card(Esibizione, Artista) = (0, N) cioè un artista si può esibire a più spettacoli. Non può esibirsi più volte allo stesso spettacolo, ma questo deriva dalla natura dell'associazione (set) binario.
Se devi scegliere tra (0, N) e (1, N) preferisci il primo, perchè è il caso più generale.

Attenzione: in ER nulla mi assicura che un artista non possa essere sostituito da sè stesso

Attenzione: necessariamente == esattamente
![[Esercitazione1.png]]