// Configurazione Supabase condivisa da index.html (quiz) e admin.html (dashboard).
// La "anon key" è pensata per stare nel browser: i permessi veri li decidono le policy RLS in supabase/setup.sql.
// Finché i due valori sono vuoti il quiz funziona lo stesso, ma non salva nulla.
window.QUIZ_CONFIG = {
  supabaseUrl: "https://vmmcrgstnwgnrgufbhug.supabase.co",
  supabaseAnonKey: "sb_publishable_5jnfgy9QKI2WD8nKATzDlQ_EcvXiq4K",  // publishable key: sicura nel browser
  quizId: "itil5-parte1"
};
