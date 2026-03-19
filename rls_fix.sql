-- =============================================
-- RLS FIX #1: Allow authenticated users to view
-- all completed profiles (needed for Discovery
-- and Inbox Terkirim profile lookups)
-- =============================================
create policy "Authenticated users can view completed profiles"
  on profiles for select
  using (
    auth.role() = 'authenticated'
    and completed = true
  );

-- =============================================
-- RLS FIX #2: Drop and recreate interests SELECT
-- policies using auth.uid() properly
-- =============================================

-- Drop old policies if they exist
drop policy if exists "Sender can view sent interests" on interests;
drop policy if exists "Receiver can view received interests" on interests;

-- Allow users to SELECT their own sent interests (using auth.uid())
create policy "Users can select own sent interests"
  on interests for select
  using (sender_user_id = auth.uid());

-- Allow users to SELECT interests addressed to their profile
create policy "Users can select received interests"
  on interests for select
  using (
    receiver_profile_id in (
      select id from profiles where user_id = auth.uid()
    )
  );

-- =============================================
-- VERIFY
-- =============================================
-- select count(*) from interests;
-- select count(*) from profiles where completed = true;

