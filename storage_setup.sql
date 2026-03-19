-- =============================================
-- HAIANA — Supabase Storage: Profile Photos
-- Jalankan di Supabase SQL Editor
-- =============================================

-- STEP 1: Buat bucket profile-photos
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'profile-photos',
  'profile-photos',
  true,                          -- Public: foto bisa diakses siapa saja via URL
  5242880,                       -- Max 5MB
  ARRAY['image/jpeg','image/jpg','image/png','image/webp']
)
ON CONFLICT (id) DO NOTHING;

-- STEP 2: Policy — user hanya bisa upload ke folder miliknya sendiri
DROP POLICY IF EXISTS "Users upload own photo" ON storage.objects;
CREATE POLICY "Users upload own photo"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'profile-photos'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- STEP 3: Policy — user bisa update/replace foto sendiri
DROP POLICY IF EXISTS "Users update own photo" ON storage.objects;
CREATE POLICY "Users update own photo"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'profile-photos'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- STEP 4: Policy — semua user bisa lihat foto (public bucket)
DROP POLICY IF EXISTS "Public read profile photos" ON storage.objects;
CREATE POLICY "Public read profile photos"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'profile-photos');

-- STEP 5: Policy — user bisa hapus foto sendiri
DROP POLICY IF EXISTS "Users delete own photo" ON storage.objects;
CREATE POLICY "Users delete own photo"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'profile-photos'
    AND auth.uid()::text = (storage.foldername(name))[1]
  );

-- =============================================
-- VERIFIKASI
-- =============================================
-- SELECT * FROM storage.buckets WHERE id = 'profile-photos';
