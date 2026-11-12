-- Black Bull scoreboard: paste into Supabase > SQL Editor > Run.
-- Anyone can read the board and add a run; nobody can edit or delete runs except you (dashboard).
create table if not exists public.scores (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  nick text not null check (char_length(nick) between 1 and 16),
  pts integer not null check (pts between 0 and 15000),
  streak integer not null default 0 check (streak between 0 and 1000),
  level integer not null default 1 check (level between 1 and 8),
  won boolean not null default false
);
alter table public.scores enable row level security;
create policy "public read" on public.scores for select to anon using (true);
create policy "public add run" on public.scores for insert to anon with check (true);
create index if not exists scores_pts_idx on public.scores (pts desc);
