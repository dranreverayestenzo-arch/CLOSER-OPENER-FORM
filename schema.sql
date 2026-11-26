-- Opener & Closer — Supabase schema
-- Run this in: Supabase Dashboard -> SQL Editor -> New query

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

-- Row Level Security: allow anonymous (publishable key) read/write
alter table staff enable row level security;
alter table schedule enable row level security;

drop policy if exists "anon all staff" on staff;
create policy "anon all staff" on staff
  for all using (true) with check (true);

drop policy if exists "anon all schedule" on schedule;
create policy "anon all schedule" on schedule
  for all using (true) with check (true);
