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

alter table staff disable row level security;
alter table schedule disable row level security;

drop policy if exists "anon all staff" on staff;
create policy "anon all staff" on staff for all using (true) with check (true);

drop policy if exists "anon all schedule" on schedule;
create policy "anon all schedule" on schedule for all using (true) with check (true);
