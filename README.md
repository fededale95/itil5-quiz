# ITIL 5 · Quiz di autoverifica

Quiz di 15 domande in stile esame ITIL Foundation (Version 5), usato nel corso interno Nimbus Reply.
Pagina statica, un solo file (`index.html`), nessuna dipendenza da installare: funziona da telefono e da PC.

## Pubblicazione su GitHub Pages

1. Crea un repository (es. `itil5-quiz`) e carica `index.html` e questo `README.md` nella root.
2. In **Settings → Pages**: *Source* = `Deploy from a branch`, branch `main`, cartella `/ (root)`.
3. Dopo un minuto il quiz è online su `https://<utente>.github.io/itil5-quiz/`.

Nota: GitHub Pages su un repository **privato** richiede un piano a pagamento (Pro, Team o Enterprise). Con un account gratuito il repository deve essere pubblico; il quiz non contiene dati di clienti.

## Modificare le domande

Le domande sono nell'array `QS` dentro `index.html`. Ogni domanda ha:

- `cat`: categoria mostrata come etichetta
- `q`: testo della domanda
- `list` (facoltativo): affermazioni numerate per le domande «quali due sono corrette»
- `o`: le 4 opzioni
- `a`: indice della risposta corretta (0 = A, 1 = B, 2 = C, 3 = D)
- `e`: spiegazione mostrata dopo la risposta

Se cambi il numero di domande, aggiorna anche `grid-template-columns: repeat(15, 1fr)` nella classe `.rail`.
