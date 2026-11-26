create table if not exists staff (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_at timestamptz default now()
);

create table if not exists schedule (
  id uuid primary key default gen_random_uuid(),
  day text not null,
  role text not null check (role in ('open','close')),
  staff_name text,
  updated_at timestamptz default now(),
  unique (day, role)
);

grant usage on schema public to anon, authenticated;
grant all on public.staff to anon, authenticated;
grant all on public.schedule to anon, authenticated;

alter table staff disable row level security;
alter table schedule disable row level security;
