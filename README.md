# ITIL 5 · Quiz di autoverifica

Quiz di 15 domande in stile esame ITIL Foundation (Version 5), usato nel corso interno Nimbus Reply.
Pagina statica, nessuna dipendenza da installare: funziona da telefono e da PC.

| File | Cosa fa |
|---|---|
| `index.html` | Il quiz. All'inizio chiede il nome; a fine quiz salva il risultato su Supabase. |
| `admin.html` | Dashboard dei risultati, protetta da email e password (Supabase Auth). |
| `config.js` | URL del progetto Supabase e anon key, usati da entrambe le pagine. |
| `supabase/setup.sql` | Tabella `quiz_results` e permessi (RLS): il quiz può solo scrivere, solo gli admin leggono. |

## Configurare Supabase (una volta)

1. Crea un progetto su [supabase.com](https://supabase.com).
2. **SQL Editor** → incolla ed esegui `supabase/setup.sql`.
3. **Authentication → Sign In / Providers**: disattiva *Allow new users to sign up*.
4. **Authentication → Users → Add user → Create new user**: la tua email e una password, con *Auto Confirm User* attivo.
5. **SQL Editor** → rendi admin quell'utente:
   ```sql
   insert into public.quiz_admins (user_id) select id from auth.users where email = 'LA-TUA-EMAIL';
   ```
6. **Project Settings → API**: copia *Project URL* e la chiave *anon public* in `config.js`, poi fai commit e push.

La dashboard è su `https://<utente>.github.io/itil5-quiz/admin.html`.
Senza la configurazione in `config.js` il quiz funziona lo stesso, ma non salva i risultati.
La anon key è pubblica per scelta di Supabase: chi la conosce può solo inserire risultati, non leggerli.

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
