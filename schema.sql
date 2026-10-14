-- 觀察員卡：匿名只能新增與讀取（無個資）
create table if not exists public.obs_cards (
  id bigserial primary key,
  event text not null,
  lens int not null check (lens between 1 and 4),
  grp int not null check (grp between 1 and 4),
  round int not null check (round in (1,2)),
  good text not null default '' check (char_length(good) <= 200),
  better text not null default '' check (char_length(better) <= 200),
  home text not null default '' check (char_length(home) <= 200),
  created_at timestamptz not null default now()
);
alter table public.obs_cards enable row level security;
create policy obs_anon_insert on public.obs_cards for insert to anon with check (true);
create policy obs_anon_select on public.obs_cards for select to anon using (true);
alter publication supabase_realtime add table public.obs_cards;
