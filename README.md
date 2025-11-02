🧊 ColdStorage WMS (WMS Mini App)

Deskripsi
Aplikasi Flutter mini untuk Warehouse Management System (Cold Storage), terdiri dari 3 layar:
Dashboard — Menampilkan suhu 3 ruang pendingin secara real-time (polling).
Inbound (Barang Masuk) — Form untuk input SKU, Batch, Expiry, Qty, dan Location.
Inventory List — Daftar stok hasil inbound, dapat dicari dan menampilkan peringatan near-expiry.
Semua data disimulasikan dari mock API lokal (in-memory).

Cara Menjalankan
1. Persiapan
Pastikan sudah terinstal:
Flutter SDK 3.x (Null Safety aktif)
Dart >= 3.x

2. Clone Repository
   git clone https://github.com/<username>/cold_storage_wms.git
   cd cold_storage_wms
3. Install Dependencies
   flutter pub get
4. Jalankan Aplikasi
   flutter run

🧠 Mock API & Data Simulation

Aplikasi ini tidak terhubung ke backend sungguhan.
Semua data berasal dari class MockApi di folder:
lib/data/repositories/mock_api.dart

Simulasi Endpoint:
Endpoint	Keterangan
GET /temperatures	Menghasilkan suhu 3 ruang pendingin acak (polling setiap 5 detik).
GET /locations	Menghasilkan daftar lokasi aktif (dengan flag “penuh”).
POST /inbound	Disimulasikan sebagai penyimpanan lokal ke state Riverpod.
Polling dihentikan otomatis saat pengguna keluar dari halaman Dashboard.

🧩 Arsitektur Proyek
Struktur folder mengikuti pendekatan feature-first dengan layering (data/domain/presentation) agar mudah dikembangkan:

lib/
├── core/                # Helper umum
│    ├── utils/          # Constants, extensions
│    └── widgets/        # Widget reusable (badge, dsb)
│
├── data/
│    ├── models/         # Data model (Temperature, Location, Inventory)
│    └── repositories/   # Mock API & state repository
│
├── presentation/        # UI dan logic per feature
│    ├── dashboard/      # Dashboard suhu real-time
│    ├── inbound/        # Form input barang masuk
│    └── inventory/      # Daftar stok lokal
│
└── main.dart            # Entry point + route

⚙️ State Management
Menggunakan: Riverpod
Alasan Pemilihan:
Reactive & declarative — cocok untuk data yang berubah real-time (polling).
AutoDispose → polling otomatis berhenti ketika keluar halaman.
Mudah di-test karena provider dapat dioverride.
Struktur lebih terpisah antara state & UI dibandingkan setState.