-- ITIL 5 quiz: tabella risultati + permessi.
-- Da eseguire una volta nel SQL Editor di Supabase.
--
-- Chi può fare cosa:
--   * chiunque abbia la anon key (il quiz pubblico) può solo INSERIRE un risultato;
--   * solo gli utenti elencati in quiz_admins possono LEGGERE o CANCELLARE i risultati (la dashboard).

create table if not exists public.quiz_results (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  quiz_id     text        not null check (char_length(quiz_id) between 1 and 40),
  name        text        not null check (char_length(name) between 2 and 80),
  score       smallint    not null check (score >= 0),
  total       smallint    not null check (total between 1 and 100),
  pct         smallint    not null check (pct between 0 and 100),
  shuffled    boolean     not null default false,
  answers     jsonb       not null default '[]'::jsonb check (jsonb_typeof(answers) = 'array'),
  constraint score_le_total check (score <= total)
);

create index if not exists quiz_results_created_at_idx on public.quiz_results (created_at desc);

create table if not exists public.quiz_admins (
  user_id uuid primary key references auth.users (id) on delete cascade
);

alter table public.quiz_results enable row level security;
alter table public.quiz_admins  enable row level security;

-- Il quiz (ruolo anon) può solo inserire; created_at e id li mette il database.
drop policy if exists "quiz can insert results" on public.quiz_results;
create policy "quiz can insert results"
  on public.quiz_results for insert
  to anon, authenticated
  with check (true);

-- Solo gli admin leggono e cancellano.
drop policy if exists "admins read results" on public.quiz_results;
create policy "admins read results"
  on public.quiz_results for select
  to authenticated
  using (exists (select 1 from public.quiz_admins a where a.user_id = auth.uid()));

drop policy if exists "admins delete results" on public.quiz_results;
create policy "admins delete results"
  on public.quiz_results for delete
  to authenticated
  using (exists (select 1 from public.quiz_admins a where a.user_id = auth.uid()));

-- Un admin può vedere solo la propria riga in quiz_admins (serve alla dashboard per capire se è admin).
drop policy if exists "admins see themselves" on public.quiz_admins;
create policy "admins see themselves"
  on public.quiz_admins for select
  to authenticated
  using (user_id = auth.uid());

-- Permessi di tabella: il quiz non può leggere, aggiornare o cancellare.
revoke all on public.quiz_results from anon, authenticated;
grant insert (quiz_id, name, score, total, pct, shuffled, answers) on public.quiz_results to anon, authenticated;
grant select, delete on public.quiz_results to authenticated;
revoke all on public.quiz_admins from anon, authenticated;
grant select on public.quiz_admins to authenticated;

-- ---------------------------------------------------------------------------
-- DOPO aver creato il tuo utente (Authentication → Users → Add user),
-- rendilo admin con questa riga, sostituendo l'email:
--
--   insert into public.quiz_admins (user_id)
--   select id from auth.users where email = 'LA-TUA-EMAIL';
-- ---------------------------------------------------------------------------
