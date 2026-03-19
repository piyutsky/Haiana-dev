-- =============================================
-- HAIANA PLATFORM — Seed Data Dummy
-- 3 Ikhwan + 3 Akhwat
-- Jalankan di Supabase SQL Editor (bukan anon key)
-- =============================================

-- STEP 1: Pastikan kolom gender ada
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS gender text;

-- STEP 2: Tambah RLS policy untuk Discovery
-- (izinkan user melihat profil completed milik user lain)
DROP POLICY IF EXISTS "Users can view completed profiles of others" ON profiles;
CREATE POLICY "Users can view completed profiles of others"
  ON profiles FOR SELECT
  USING (completed = true AND (user_id IS NULL OR user_id != auth.uid()));

-- STEP 3: Insert 6 profil dummy
-- user_id menggunakan random UUID (bukan auth user sungguhan)
-- Untuk testing lokal tanpa auth, sementara disable RLS:
-- ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;

INSERT INTO profiles (
  user_id, session_id, completed, gender,
  fullname, nickname, date_of_birth,
  domicile, ethnicity, marital_status, sibling_order,
  weight_kg, height_cm,
  occupation, occupation_history, salary_range,
  education_status, education_major, certification,
  illness, sport_physical_activities,
  hobby_interest, character_liked, character_disliked,
  whatsapp_number, email, social_media_profile,
  parent_marital_status, parent_ethnicity,
  mother_education_status, father_education_status, siblings_education_status,
  mother_occupation, father_occupation, family_social_status,
  family_is_multireligion,
  parent_islamic_manhaj, islamic_nurture_from_parent, parent_islamic_organization,
  pray_wajib_description, sunnah_routine, favorite_preacher, islamic_manhaj,
  wealth_management_habit, investment_instruments, monthly_spending_avg,
  household_economy_plan, monthly_liabilities, has_receivable,
  marriage_goal, marriage_goal_steps, marriage_essential_aspect,
  marriage_destructive_aspect, strategy_for_sakinah,
  okay_with_widow, spouse_education_preference, has_guardian_permission,
  plan_after_marriage, childcare_preference
) VALUES

-- =============================================
-- IKHWAN 1: Ahmad Faisal
-- =============================================
(
  NULL, 'seed-ikhwan-1', true, 'laki-laki',
  'Ahmad Faisal', 'Faisal', '1996-03-14',
  'Surabaya, Jawa Timur', 'Jawa', 'Belum menikah', 'Anak 1 dari 3 bersaudara',
  72, 174,
  'Dokter Spesialis Penyakit Dalam (PPDS)', 'Koas RS Saiful Anwar 2021, PPDS sejak 2023', '10-20 juta',
  'S1 Kedokteran (Profesi Dokter)', 'Pendidikan Dokter', 'UKMPPD, Sertifikat ACLS',
  'Tidak ada riwayat penyakit serius', 'Gym 3x seminggu, renang akhir pekan',
  'Membaca buku sejarah Islam, traveling ke tempat bersejarah', 'Sabar, jujur, komunikatif, tidak banyak menuntut', 'Sombong dan tidak menghargai orang lain',
  '081234560001', 'faisal@seed.haiana', '@faisal.dokter',
  'Masih menikah', 'Jawa', 'S1', 'S2 Manajemen', 'Rata-rata S1',
  'Guru SD', 'Dosen', 'Menengah ke atas',
  false,
  'Ahlussunnah wal Jamaah', 'Pesantren kilat & pengajian keluarga rutin', 'NU',
  'Shalat 5 waktu berjamaah di masjid, jarang terlewat', 'Dhuha & Tahajjud rutin, tilawah ba''da Subuh', 'Ustadz Adi Hidayat, Ustadz Khalid Basalamah', 'Ahlussunnah',
  'Catat pemasukan/pengeluaran, tabung 20% gaji', ARRAY['Reksa Dana Syariah', 'Sukuk'], '3-5 juta',
  'Suami nafkah utama, istri fokus rumah tangga & pengembangan diri', ARRAY['KPR rumah tinggal'], false,
  'Membangun keluarga sakinah mawaddah wa rahmah yang taat beribadah dan bermanfaat bagi masyarakat',
  'Perbaiki diri, ajukan ke wali, proses singkat & serius, nikah sederhana tapi bermakna',
  'Komitmen agama yang sejajar dan komunikasi yang terbuka',
  'Perselingkuhan dan tidak adanya rasa saling menghormati',
  'Shalat berjamaah tiap hari, tausiyah mingguan, liburan keluarga',
  false, 'Minimal S1', true,
  'Istri di rumah, boleh bisnis kecil online jika mau', 'Diasuh sendiri, dibantu keluarga dekat'
),

-- =============================================
-- IKHWAN 2: Muhammad Rizki
-- =============================================
(
  NULL, 'seed-ikhwan-2', true, 'laki-laki',
  'Muhammad Rizki Ramadhan', 'Rizki', '1998-07-22',
  'Jakarta Selatan, DKI Jakarta', 'Betawi', 'Belum menikah', 'Anak 2 dari 4 bersaudara',
  68, 170,
  'Software Engineer (Remote)', 'Intern Gojek 2020, Tokopedia 2021-2023, Freelance 2023-sekarang', '15-25 juta',
  'S1 Teknik Informatika', 'Informatika', 'AWS Certified Developer, Google Cloud Associate',
  'Tidak ada', 'Badminton 2x seminggu, jogging pagi',
  'Coding side project, mentoring junior dev, review gadget halal', 'Produktif, sederhana, mau belajar & terbuka', 'Egois dan tidak mau menerima feedback',
  '081234560002', 'rizki@seed.haiana', '@rizki.dev',
  'Masih menikah', 'Betawi & Jawa', 'S1 Ekonomi', 'S1 Teknik', 'Rata-rata D3-S1',
  'Ibu Rumah Tangga', 'Wirausahawan', 'Menengah',
  false,
  'Ahlussunnah wal Jamaah', 'Kajian masjid dekat rumah sejak SMA', 'Muhammadiyah',
  'Shalat 5 waktu, diusahakan berjamaah', 'Dhuha, puasa Senin-Kamis', 'Ustadz Hanan Attaki, Buya Yahya', 'Wasathiyah',
  'Budgeting pakai aplikasi, tabung 30% gaji rutin', ARRAY['Saham Syariah', 'Deposito Syariah'], '4-6 juta',
  'Suami nafkah utama, istri boleh berkarir remote dari rumah', ARRAY['Tidak ada hutang'], false,
  'Keluarga yang hangat dan saling mendukung impian dalam koridor agama',
  'Ikut kajian pra-nikah, berkenalan resmi via perantara, khitbah dalam 3 bulan',
  'Kepercayaan dan dukungan emosional satu sama lain',
  'Finansial tidak transparan dan tidak satu visi ke depan',
  'Weekly check-in, doa bersama, family meeting bulanan',
  true, 'Minimal SMA, yang penting mau terus belajar', true,
  'Kerja remote dari rumah atau buka usaha sendiri sesuai minat', 'Diasuh sendiri, nanny hanya saat ada kebutuhan mendesak'
),

-- =============================================
-- IKHWAN 3: Harits Naufal
-- =============================================
(
  NULL, 'seed-ikhwan-3', true, 'laki-laki',
  'Harits Naufal Azzam', 'Harits', '1994-11-05',
  'Bandung, Jawa Barat', 'Sunda', 'Belum menikah', 'Anak 1 dari 2 bersaudara',
  75, 176,
  'Pengacara / Legal Consultant', 'Associate firma hukum Bandung 2018-2021, buka kantor sendiri 2022', '20-35 juta',
  'S1 Ilmu Hukum', 'Ilmu Hukum', 'Advokat (PERADI), Ahli Hukum Perdata',
  'Asam lambung ringan', 'Futsal seminggu sekali, hiking bulanan',
  'Kajian fiqh muamalah, menulis artikel hukum Islam, memasak untuk keluarga', 'Tegas tapi lembut, bertanggung jawab, humoris', 'Manipulatif dan tidak konsisten antara kata dan perbuatan',
  '081234560003', 'harits@seed.haiana', '@harits.azzam',
  'Bercerai', 'Sunda', 'SMA', 'S2 Hukum', 'Rata-rata SMA-S1',
  'Pedagang', 'Pensiunan PNS', 'Menengah ke atas',
  false,
  'Ahlussunnah wal Jamaah', 'Dayah/pesantren kilat, pengajian rutin semasa muda', 'NU',
  'Shalat 5 waktu, tidak pernah terlewat sejak SMP', 'Tahajjud, tilawah Al-Quran ba''da Subuh setiap hari', 'Ustadz Felix Siauw, Ustadz Adi Hidayat', 'Ahlussunnah',
  'Rekening terpisah: kebutuhan, tabungan, investasi, sedekah', ARRAY['Properti', 'Sukuk Negara', 'Emas'], '5-8 juta',
  'Suami sebagai pencari nafkah utama, istri manajer rumah tangga', ARRAY['Cicilan ruko kantor'], false,
  'Membangun keluarga yang harmonis berdasarkan Al-Quran dan sunnah Rasulullah',
  'Taaruf formal via perantara wali yang dipercaya, khitbah dalam 1-2 bulan',
  'Kesamaan visi hidup dan komitmen menjalankan agama bersama',
  'Komunikasi yang tertutup dan rasa saling curiga',
  'Shalat berjamaah tiap hari, kajian keluarga mingguan, liburan tahunan islami',
  true, 'Minimal S1, lebih utama yang punya kemandirian sikap', true,
  'Istri fokus mendidik anak, bekerja opsional jika tidak mengorbankan keluarga', 'Diasuh sendiri, dibantu ibu mertua jika ada'
),

-- =============================================
-- AKHWAT 1: Fathimah Zahra
-- =============================================
(
  NULL, 'seed-akhwat-1', true, 'perempuan',
  'Fathimah Zahra Aulia', 'Fathimah', '1999-04-18',
  'Malang, Jawa Timur', 'Jawa', 'Belum menikah', 'Anak 3 dari 4 bersaudara',
  52, 158,
  'Guru Matematika SMA Swasta', 'Guru honorer 2021-2022, Guru tetap sejak 2022', '3-5 juta',
  'S1 Pendidikan Matematika', 'Pendidikan Matematika', 'Sertifikat Pendidik (PPG Prajabatan)',
  'Tidak ada', 'Senam 2x seminggu, jalan pagi',
  'Membaca buku parenting Islam, berkebun, memasak masakan Jawa', 'Sabar, telaten, perhatian terhadap detail', 'Tidak menghargai usaha orang lain yang sudah berusaha maksimal',
  '081234560004', 'fathimah@seed.haiana', '@fathimah.z',
  'Masih menikah', 'Jawa', 'SMA', 'S1 Pertanian', 'Rata-rata SMA',
  'Ibu Rumah Tangga', 'Wirausahawan Kecil (dagang)', 'Menengah',
  false,
  'Ahlussunnah wal Jamaah', 'TPA sejak kecil, pengajian rutin bersama ibu', 'NU',
  'Shalat 5 waktu tepat waktu, tidak pernah qadha', 'Dhuha, tilawah minimal 1 halaman per hari, yasinan Jumat', 'Ustadz Adi Hidayat, Ustadzah Halimah Alaydrus', 'Ahlussunnah',
  'Menabung dari sisa gaji, ikut arisan keluarga', ARRAY['Tabungan Syariah'], '1,5-2,5 juta',
  'Suami kepala keluarga, istri mendukung dan mengelola keuangan rumah tangga', ARRAY['Tidak ada hutang'], false,
  'Keluarga sakinah yang mendidik anak menjadi generasi Qurani dan bermanfaat',
  'Dikenalkan orang tua atau guru terpercaya, proses tidak perlu terlalu lama',
  'Kesamaan akidah dan komitmen mendidik anak secara Islami',
  'Tidak saling menghormati dan lupa bersyukur atas yang ada',
  'Shalat berjamaah, baca Quran bersama anak, saling mengingatkan dengan lembut',
  false, 'Minimal S1, lebih diutamakan memiliki wawasan agama yang baik', true,
  'Ibu rumah tangga penuh, mengajar paruh waktu jika kondisi memungkinkan', 'Diasuh sendiri, tidak memakai nanny'
),

-- =============================================
-- AKHWAT 2: Khadijah Nur
-- =============================================
(
  NULL, 'seed-akhwat-2', true, 'perempuan',
  'Khadijah Nur Rahmawati', 'Khadijah', '1997-09-30',
  'Yogyakarta, DIY', 'Jawa', 'Belum menikah', 'Anak 1 dari 3 bersaudara',
  55, 162,
  'Apoteker (Klinik Pratama)', 'Magang RS Sardjito 2020, Apoteker praktek sejak 2021', '5-8 juta',
  'S1 Farmasi (Profesi Apoteker)', 'Farmasi Klinis', 'STRA (Surat Tanda Registrasi Apoteker)',
  'Alergi debu ringan (terkontrol)', 'Yoga 3x seminggu, bersepeda sore',
  'Memasak resep baru, menulis jurnal harian, ikut kajian muslimah online', 'Mandiri, rapi, terbuka terhadap perbedaan pendapat', 'Terlalu perfeksionis hingga sulit menerima ketidaksempurnaan orang lain',
  '081234560005', 'khadijah@seed.haiana', '@khadijah.apoteker',
  'Masih menikah', 'Jawa', 'S1 Keperawatan', 'S1 Teknik Sipil', 'Rata-rata S1',
  'Apoteker', 'Kontraktor Swasta', 'Menengah ke atas',
  false,
  'Ahlussunnah wal Jamaah', 'Pesantren kilat tiap Ramadhan, kajian keluarga bulanan', 'Muhammadiyah',
  'Shalat 5 waktu, diusahakan tidak terlewat', 'Dhuha, puasa Senin-Kamis, tilawah rutin', 'Ustadz Hanan Attaki, Ustadzah Oki Setiana Dewi', 'Wasathiyah',
  'Tracking pengeluaran bulanan, investasi dari gaji rutin', ARRAY['Reksa Dana Syariah', 'Emas'], '2-4 juta',
  'Kedua pasangan bisa berkontribusi finansial, dengan suami sebagai pemimpin', ARRAY['Tidak ada'], false,
  'Keluarga yang harmonis, saling mendukung, anak besar dengan nilai-nilai Islam',
  'Taaruf terstruktur melalui perantara yang dipercaya keluarga',
  'Rasa saling menghormati dan kejujuran sebagai fondasi',
  'Ego tak terkontrol, komunikasi tertutup, dan tidak saling percaya',
  'Libatkan Allah di setiap keputusan, quality time mingguan tanpa gadget',
  false, 'Minimal S1, yang penting satu visi ke depan', true,
  'Tetap bekerja paruh waktu, tidak meninggalkan tanggung jawab rumah tangga', 'Diasuh sendiri saat di rumah, nanny saat jam kerja'
),

-- =============================================
-- AKHWAT 3: Aisyah Rahmah
-- =============================================
(
  NULL, 'seed-akhwat-3', true, 'perempuan',
  'Aisyah Rahmah Salsabila', 'Aisyah', '2000-01-12',
  'Surabaya, Jawa Timur', 'Jawa', 'Belum menikah', 'Anak 2 dari 2 bersaudara',
  48, 155,
  'Data Analyst (Tech Startup)', 'Internship fintech 2022, Data Analyst full-time sejak 2023', '6-10 juta',
  'S1 Statistika', 'Statistika', 'Google Data Analytics Certificate, Tableau Desktop Specialist',
  'Tidak ada', 'Lari pagi 3x seminggu, pilates online',
  'Traveling halal, fotografi alam, membaca novel sastra Islam', 'Kreatif, ceria, pendengar yang baik, tidak mudah menghakimi', 'Kadang ceroboh saat terburu-buru dan moody saat lelah',
  '081234560006', 'aisyah@seed.haiana', '@aisyahrs',
  'Masih menikah', 'Jawa & Madura', 'SMA', 'S1 Ekonomi', 'Rata-rata S1',
  'Pegawai Swasta', 'Wirausahawan Sembako', 'Menengah',
  false,
  'Ahlussunnah wal Jamaah', 'Dari ibu yang aktif ikut majelis taklim kampung', 'NU',
  'Shalat 5 waktu, kadang jamak bukan qashar saat lembur', 'Dhuha, tilawah minimal 3 ayat per hari, ikut majelis taklim online', 'Ustadz Adi Hidayat, Ustadz Khalid Basalamah', 'Ahlussunnah',
  'Pisahkan rekening kebutuhan dan tabungan sejak terima gaji pertama', ARRAY['Saham Syariah', 'Tabungan Emas'], '3-5 juta',
  'Suami sebagai tiang keluarga, istri berkontribusi sesuai kemampuan dan kondisi', ARRAY['Tidak ada hutang'], false,
  'Punya keturunan yang shalih shalihah dan keluarga yang menjadi teladan di sekitarnya',
  'Kenalan via orang terpercaya, niat jelas dari awal, proses singkat tapi bermakna',
  'Kesamaan prinsip hidup dan kesiapan lahir batin masing-masing',
  'Tidak ada kepercayaan dan kebiasaan komunikasi yang buruk',
  'Musyawarah dalam setiap masalah, saling memaafkan sebelum tidur malam',
  false, 'Bebas, lebih utama yang berwawasan luas dan growth mindset', true,
  'Kerja remote dari rumah, tetap aktif berkarir dengan batasan yang sehat', 'Diasuh bersama keluarga, nanny opsional sesuai kebutuhan'
);

-- =============================================
-- VERIFIKASI
-- =============================================
-- SELECT fullname, gender, domicile, occupation, completed FROM profiles ORDER BY created_at DESC LIMIT 10;
