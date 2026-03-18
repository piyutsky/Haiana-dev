-- =============================================
-- STEP 1: Tambah user_id ke tabel profiles
-- Jalankan ini di Supabase SQL Editor
-- =============================================

-- Tambah kolom user_id yang link ke auth.users
alter table profiles
  add column if not exists user_id uuid references auth.users(id) on delete cascade;

-- Tambah index biar query by user_id cepat
create index if not exists profiles_user_id_idx on profiles(user_id);

-- =============================================
-- STEP 2: Update RLS — hapus policy lama,
--         ganti dengan yang proper
-- =============================================

-- Hapus policy lama yang "allow all"
drop policy if exists "Allow all for now" on profiles;

-- User hanya bisa lihat profil miliknya sendiri
create policy "Users can view own profile"
  on profiles for select
  using (auth.uid() = user_id);

-- User hanya bisa insert profil untuk dirinya sendiri
create policy "Users can insert own profile"
  on profiles for insert
  with check (auth.uid() = user_id);

-- User hanya bisa update profil miliknya sendiri
create policy "Users can update own profile"
  on profiles for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- N8N pakai service_role key (bypass RLS) — tidak perlu policy khusus
-- Pastikan di N8N pakai: Authorization: Bearer SERVICE_ROLE_KEY
-- (bukan anon key) untuk insert/update dari webhook

-- =============================================
-- STEP 3: Function auto-buat profil kosong
--         saat user baru register
-- =============================================
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (user_id, session_id, email)
  values (
    new.id,
    new.id::text,
    new.email
  );
  return new;
end;
$$ language plpgsql security definer;

-- Trigger: jalankan function di atas setiap ada user baru
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- =============================================
-- VERIFIKASI
-- Jalankan ini untuk cek hasilnya
-- =============================================
-- select id, user_id, email, created_at from profiles limit 10;
