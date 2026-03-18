-- =============================================
-- TAARUF PLATFORM — Supabase Schema
-- Generated from Profile_User CSV
-- =============================================

-- Drop existing table if any
drop table if exists profiles;

-- =============================================
-- PROFILES TABLE
-- =============================================
create table profiles (
  -- System
  id                          uuid default gen_random_uuid() primary key,
  session_id                  text unique,
  created_at                  timestamptz default now(),
  updated_at                  timestamptz default now(),
  completed                   boolean default false,

  -- BASIC INFO
  fullname                    text,
  nickname                    text,
  date_of_birth               date,
  whatsapp_number             text,                          -- Private
  social_media_profile        text,                          -- Private
  email                       text,                          -- Private
  domicile                    text,                          -- Public (kota/kab/provinsi)
  occupation                  text,                          -- Public
  salary_range                text,                          -- On Permission (Dropdown)
  ethnicity                   text,                          -- Public
  sibling_order               text,                          -- e.g. "2 of 4 siblings"
  marital_status              text,                          -- Public (Dropdown)
  weight_kg                   decimal,                       -- Public
  height_cm                   decimal,                       -- Public
  hobby_interest              text,                          -- On Permission
  photo_url                   text,                          -- On Permission (file upload)
  photo_family_url            text,                          -- On Permission (file upload)

  -- WELLNESS
  illness                     text,                          -- On Permission
  sport_physical_activities   text,                          -- On Permission

  -- CHARACTER
  character_liked             text,                          -- On Permission
  character_disliked          text,                          -- On Permission

  -- EDUCATION
  education_status            text,                          -- On Permission (Dropdown)
  education_major             text,                          -- On Permission
  certification               text,                          -- On Permission
  occupation_history          text,                          -- On Permission

  -- PARENT INFORMATION
  parent_marital_status       text,                          -- Dropdown: Married/Divorced/Widow/All passed
  parent_ethnicity            text,
  parent_islamic_manhaj       text,
  islamic_nurture_from_parent text,
  mother_education_status     text,                          -- Dropdown
  father_education_status     text,                          -- Dropdown
  siblings_education_status   text,                          -- Dropdown
  mother_occupation           text,
  father_occupation           text,
  family_social_status        text,                          -- Dropdown: Menengah kebawah/Menengah/Menengah keatas
  family_is_multireligion     boolean,
  multireligion_description   text,
  parent_islamic_organization text,                          -- Dropdown: Muhammadiyah/NU/Salaf/PKS/others

  -- SPIRITUAL ROUTINE
  pray_wajib_description      text,
  sunnah_routine              text,
  favorite_preacher           text,
  islamic_manhaj              text,                          -- Muhammadiyah/NU/Salaf/PKS/others

  -- ECONOMY
  wealth_management_habit     text,
  investment_instruments      text[],                        -- Multichoice: Reksadana, Sukuk, etc
  monthly_spending_avg        text,
  household_economy_plan      text,
  monthly_liabilities         text[],                        -- Multichoice: Hutang, cicilan, PDAM, etc
  has_receivable              boolean,                       -- someone owes them money
  receivable_amount_scale     text,                          -- Dropdown: big/small

  -- MARRIAGE MINDSET
  marriage_goal               text,
  marriage_goal_steps         text,
  marriage_essential_aspect   text,
  marriage_destructive_aspect text,
  strategy_for_sakinah        text,

  -- MARRIAGE PREFERENCE
  okay_with_widow             boolean,
  spouse_education_preference text,
  has_guardian_permission     boolean,
  plan_after_marriage         text,                          -- work or stay home
  childcare_preference        text,                          -- nanny or self-care

  -- METADATA
  raw_conversation            jsonb,                         -- full N8N chat history
  visibility_overrides        jsonb                          -- per-field custom visibility if needed
);

-- =============================================
-- AUTO-UPDATE updated_at
-- =============================================
create or replace function update_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger profiles_updated_at
  before update on profiles
  for each row execute function update_updated_at();

-- =============================================
-- ROW LEVEL SECURITY
-- =============================================
alter table profiles enable row level security;

-- Allow insert/update via service role (N8N uses anon key with this policy)
-- Adjust this policy once you add auth
create policy "Allow all for now"
  on profiles
  for all
  using (true)
  with check (true);

-- =============================================
-- VISIBILITY ENUM REFERENCE (for frontend use)
-- Public       = visible to all verified users
-- On Permission = visible after interest accepted
-- Private      = only visible to the user themselves
-- =============================================
comment on column profiles.fullname               is 'visibility: On Permission';
comment on column profiles.nickname               is 'visibility: On Permission';
comment on column profiles.date_of_birth          is 'visibility: On Permission';
comment on column profiles.whatsapp_number        is 'visibility: Private';
comment on column profiles.social_media_profile   is 'visibility: Private';
comment on column profiles.email                  is 'visibility: Private';
comment on column profiles.domicile               is 'visibility: Public';
comment on column profiles.occupation             is 'visibility: Public';
comment on column profiles.salary_range           is 'visibility: On Permission';
comment on column profiles.ethnicity              is 'visibility: Public';
comment on column profiles.marital_status         is 'visibility: Public';
comment on column profiles.weight_kg              is 'visibility: Public';
comment on column profiles.height_cm              is 'visibility: Public';
comment on column profiles.photo_url              is 'visibility: On Permission';
