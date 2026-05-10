-- ATUALIZAÇÃO: função de CONTA PAGA
-- Execute tudo no Supabase em: SQL Editor > New query > Run

create extension if not exists "pgcrypto";

create table if not exists ganhos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  data date not null,
  descricao text not null,
  valor numeric(12,2) not null,
  categoria text not null,
  status text not null default 'pendente',
  created_at timestamptz default now()
);

create table if not exists gastos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  data date not null,
  descricao text not null,
  valor numeric(12,2) not null,
  categoria text not null,
  created_at timestamptz default now()
);

create table if not exists investimentos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  data date not null,
  descricao text not null,
  valor numeric(12,2) not null,
  categoria text not null,
  created_at timestamptz default now()
);

create table if not exists metas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  mes text not null,
  valor numeric(12,2) not null default 0,
  created_at timestamptz default now(),
  unique(user_id, mes)
);

alter table gastos add column if not exists status text not null default 'pendente';

alter table ganhos enable row level security;
alter table gastos enable row level security;
alter table investimentos enable row level security;
alter table metas enable row level security;

drop policy if exists "ganhos_select" on ganhos;
drop policy if exists "ganhos_insert" on ganhos;
drop policy if exists "ganhos_update" on ganhos;
drop policy if exists "ganhos_delete" on ganhos;

create policy "ganhos_select" on ganhos for select using (auth.uid() = user_id);
create policy "ganhos_insert" on ganhos for insert with check (auth.uid() = user_id);
create policy "ganhos_update" on ganhos for update using (auth.uid() = user_id);
create policy "ganhos_delete" on ganhos for delete using (auth.uid() = user_id);

drop policy if exists "gastos_select" on gastos;
drop policy if exists "gastos_insert" on gastos;
drop policy if exists "gastos_update" on gastos;
drop policy if exists "gastos_delete" on gastos;

create policy "gastos_select" on gastos for select using (auth.uid() = user_id);
create policy "gastos_insert" on gastos for insert with check (auth.uid() = user_id);
create policy "gastos_update" on gastos for update using (auth.uid() = user_id);
create policy "gastos_delete" on gastos for delete using (auth.uid() = user_id);

drop policy if exists "investimentos_select" on investimentos;
drop policy if exists "investimentos_insert" on investimentos;
drop policy if exists "investimentos_update" on investimentos;
drop policy if exists "investimentos_delete" on investimentos;

create policy "investimentos_select" on investimentos for select using (auth.uid() = user_id);
create policy "investimentos_insert" on investimentos for insert with check (auth.uid() = user_id);
create policy "investimentos_update" on investimentos for update using (auth.uid() = user_id);
create policy "investimentos_delete" on investimentos for delete using (auth.uid() = user_id);

drop policy if exists "metas_select" on metas;
drop policy if exists "metas_insert" on metas;
drop policy if exists "metas_update" on metas;
drop policy if exists "metas_delete" on metas;

create policy "metas_select" on metas for select using (auth.uid() = user_id);
create policy "metas_insert" on metas for insert with check (auth.uid() = user_id);
create policy "metas_update" on metas for update using (auth.uid() = user_id);
create policy "metas_delete" on metas for delete using (auth.uid() = user_id);
