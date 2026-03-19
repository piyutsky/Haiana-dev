-- =============================================
-- INTERESTS TABLE
-- Run this in Supabase SQL Editor
-- Requires: profiles.user_id already exists (auth_update.sql)
-- =============================================

-- Create table
create table if not exists interests (
  id                  uuid default gen_random_uuid() primary key,
  created_at          timestamptz default now(),
  updated_at          timestamptz default now(),

  -- Sender: auth user + their profile row
  sender_user_id      uuid references auth.users(id) on delete cascade not null,
  sender_profile_id   uuid references profiles(id) on delete set null,

  -- Receiver: the profile being expressed interest in
  receiver_profile_id uuid references profiles(id) on delete cascade not null,

  -- Status lifecycle: pending → accepted | rejected
  status              text not null default 'pending'
                        check (status in ('pending', 'accepted', 'rejected')),

  -- Optional message from sender
  note                text
);

-- Auto-update updated_at (reuses function from supabase_schema.sql)
create trigger interests_updated_at
  before update on interests
  for each row execute function update_updated_at();

-- Prevent duplicate interest from same sender to same receiver
create unique index if not exists interests_unique_pair
  on interests(sender_user_id, receiver_profile_id);

-- Index for fast lookup of received interests
create index if not exists interests_receiver_idx
  on interests(receiver_profile_id);

-- Index for fast lookup of sent interests
create index if not exists interests_sender_idx
  on interests(sender_user_id);

-- =============================================
-- ROW LEVEL SECURITY
-- =============================================
alter table interests enable row level security;

-- Sender can insert their own interests
create policy "Sender can insert own interests"
  on interests for insert
  with check (auth.uid() = sender_user_id);

-- Sender can view their own sent interests
create policy "Sender can view sent interests"
  on interests for select
  using (auth.uid() = sender_user_id);

-- Receiver can view interests sent to them
create policy "Receiver can view received interests"
  on interests for select
  using (
    receiver_profile_id in (
      select id from profiles where user_id = auth.uid()
    )
  );

-- Receiver can update status (accept / reject)
create policy "Receiver can update interest status"
  on interests for update
  using (
    receiver_profile_id in (
      select id from profiles where user_id = auth.uid()
    )
  )
  with check (
    receiver_profile_id in (
      select id from profiles where user_id = auth.uid()
    )
  );

-- =============================================
-- VERIFICATION
-- =============================================
-- select
--   i.id, i.status, i.created_at,
--   sp.fullname as sender_name,
--   rp.fullname as receiver_name
-- from interests i
-- left join profiles sp on sp.id = i.sender_profile_id
-- left join profiles rp on rp.id = i.receiver_profile_id
-- order by i.created_at desc;
