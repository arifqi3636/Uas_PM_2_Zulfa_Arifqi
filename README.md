# UAS Pemrograman Mobile 2 - Aplikasi Manajemen Budidaya Ikan 🐟
(Demo Aplikasi)


https://github.com/user-attachments/assets/ea9574b4-dee2-4617-bb05-d77cfdc556c3



> Solusi digital komprehensif untuk manajemen akuakultur ikan lele dengan antarmuka yang intuitif dan fitur-fitur canggih.

## 📋 Deskripsi Proyek

**Catfish** adalah aplikasi mobile dan web berbasis **Flutter** yang dirancang khusus untuk membantu petani dan pembudidaya ikan lele dalam mengelola operasional budidaya ikan secara efisien dan terintegrasi. Aplikasi ini menggabungkan teknologi modern dengan kebutuhan praktis pengguna di lapangan.

### 🎯 Tujuan Aplikasi
- Memudahkan monitoring dan manajemen kolam ikan secara real-time
- Meningkatkan produktivitas dan efisiensi budidaya
- Memberikan data dan analitik untuk pengambilan keputusan yang lebih baik
- Mempermudah tracking kesehatan, pakan, dan produksi ikan

### 👥 Target Pengguna
- Petani ikan lele skala kecil hingga menengah
- Manajer budidaya ikan
- Pemilik usaha aquakultur
- Teknisi dan pekerja lapangan

## ✨ Fitur Utama

### 📊 1. Dashboard Analytics
Layar utama dengan visualisasi data real-time:
- 📈 **Grafik Interaktif** - Tracking panen dan kesehatan ikan
- 📋 **Summary Cards** - Statistik kolam, ikan, pakan, kesehatan
- ⚠️ **Alert System** - Notifikasi kondisi abnormal (kolam tidak sehat, stok pakan rendah)
- 📱 **Responsive Design** - Tampilan optimal di semua ukuran layar


### 🏊 2. Manajemen Kolam
Fitur lengkap untuk CRUD kolam:
- ➕ **Tambah Kolam** - Form dengan validasi data
- 📸 **Foto Kolam** - Upload foto dari gallery atau kamera
- 📝 **Edit Data** - Perubahan dimensi dan informasi kolam
- 🗑️ **Hapus Kolam** - Dengan konfirmasi
- 🎨 **Visual Status** - Badge warna status sehat/moderat/tidak sehat
- 📊 **Volume Calculator** - Otomatis hitung volume (P × L × D)

### 🐟 3. Inventori Ikan
Tracking inventori ikan per kolam:
- 📈 **Total Ikan** - Jumlah keseluruhan di semua kolam
- ⚖️ **Berat Rata-rata** - Tracking pertumbuhan ikan
- 📊 **Summary Cards** - Statistik per kategori
- 🔍 **Filter & Sort** - Berdasarkan kolam, tanggal, dll
- 📋 **List View** - Detail inventori setiap kolam
- 💾 **Penyimpanan** - Tersimpan di Firebase

### 🍔 4. Manajemen Pakan
Monitoring dan kontrol stok pakan:
- 📊 **Stok Pakan** - Total stok dan nilai inventory
- 💰 **Nilai Stok** - Tracking nilai finansial pakan
- 🎯 **Jenis Pakan** - Kategorisasi berbagai jenis pakan
- 💵 **Rata-rata Harga** - Per unit pakan
- 📈 **Trend Konsumsi** - Analitik penggunaan pakan
- 🔄 **Update Harga** - Tracking perubahan harga

### 💊 5. Monitoring Kesehatan
Pencatatan parameter kesehatan ikan:
- 🏥 **Status Kesehatan** - Normal, Baik, Buruk dengan badge warna
- 📋 **Parameter Monitor** - Suhu, pH, oksigen, dll
- 📝 **Catatan** - Pencatatan detail kondisi
- 📊 **Statistik Kesehatan** - Grafik trend kesehatan
- ⚠️ **Alert Otomatis** - Notifikasi kondisi buruk
- 🔍 **Filter Data** - Berdasarkan status dan tanggal

### 🍽️ 6. Data Pemberian Pakan
Tracking jadwal dan realisasi pemberian pakan:
- 📅 **Jadwal Pakan** - Planning pemberian pakan
- ✅ **Realisasi Pakan** - Pencatatan pemberian aktual
- 📍 **Per Kolam** - Tracking pemberian setiap kolam
- 💾 **Riwayat Lengkap** - Histori pemberian pakan
- 📊 **Analitik** - Rata-rata pakan per kolam
- 🔔 **Reminder** - Pengingat jadwal pemberian

### 🎣 7. Data Panen
Manajemen dan analitik hasil panen:
- 🐠 **Total Panen** - Berat hasil panen keseluruhan
- 💰 **Nilai Panen** - Perhitungan revenue dari panen
- 📈 **Forecasting** - Prediksi produktivitas kolam
- 📊 **Analitik Panen** - Grafik produktivitas per kolam
- 💹 **ROI Calculation** - Perhitungan keuntungan
- 🏆 **Ranking Kolam** - Top kolam berdasarkan produktivitas

### 👤 8. Profile & Pengaturan
Manajemen user account:
- 👨 **Profil User** - Informasi pengguna
- 🌓 **Dark/Light Mode** - Toggle tema terang/gelap
- 📱 **Responsive Settings** - Pengaturan sesuai preferensi
- 🚪 **Logout** - Keluar dari aplikasi dengan aman


## 📁 Struktur Proyek

```
lib/
├── main.dart                           # Entry point aplikasi
├── theme/
│   └── app_theme.dart                 # ✨ Tema terpusat (Warna, Typography)
├── widgets/
│   ├── app_logo.dart                  # 🎨 Widget logo aplikasi
│   └── common_widgets.dart            # 🎨 Reusable widgets (Badge, Card)
├── models/                             # 📦 Data models
│   ├── pond.dart                       # Struktur data kolam
│   ├── fish_inventory.dart             # Struktur inventori ikan
│   ├── feed.dart                       # Struktur data pakan
│   ├── feeding.dart                    # Struktur pemberian pakan
│   ├── health_monitoring.dart          # Struktur monitoring kesehatan
│   └── harvest.dart                    # Struktur data panen
├── providers/                          # 🔄 State Management
│   ├── auth_provider.dart              # Autentikasi
│   ├── theme_provider.dart             # ✨ Dark/Light mode
│   ├── pond_provider.dart              # Logika kolam
│   ├── fish_inventory_provider.dart    # Logika inventori
│   ├── feed_provider.dart              # Logika pakan
│   ├── health_provider.dart            # Logika monitoring kesehatan
│   ├── feeding_provider.dart           # Logika pemberian pakan
│   └── harvest_provider.dart           # Logika panen
├── screens/                            # 📱 UI Screens
│   ├── dashboard_screen.dart           # 📊 Dashboard utama dengan grafik
│   ├── pond_list_screen.dart           # 🏊 Daftar & manajemen kolam
│   ├── add_pond_screen.dart            # ➕ Tambah kolam baru
│   ├── fish_inventory_screen.dart      # 🐟 Inventori ikan
│   ├── feed_management_screen.dart     # 🍔 Manajemen pakan
│   ├── feeding_data_screen.dart        # 🍽️ Data pemberian pakan
│   ├── health_monitoring_screen.dart   # 💊 Monitoring kesehatan
│   ├── harvest_data_screen.dart        # 🎣 Data panen
│   ├── reports_screen.dart             # 📈 Laporan & analitik
│   ├── monitoring_screen.dart          # 📋 Monitoring overview
│   ├── login_screen.dart               # 🔐 Login (dengan logo)
│   ├── register_screen.dart            # 📝 Registrasi
│   └── profile_screen.dart             # 👤 Profile user
├── services/
│   ├── firebase_options.dart           # 🔧 Firebase configuration
│   └── api_service.dart                # 🌐 API calls
└── assets/
    └── logo.svg                        # 🎨 Logo aplikasi


   ```

## 📋 Panduan Penggunaan

### Login & Register
1. Buka aplikasi
2. Klik tombol "Register" untuk membuat akun baru
3. Masukkan email dan password
4. Klik "Daftar"
5. Login dengan kredensial Anda

### Dashboard
1. Setelah login, Anda akan masuk ke Dashboard
2. Lihat statistik real-time dengan grafik
3. Akses berbagai fitur melalui bottom navigation bar

### Tambah Kolam Baru
1. Buka "Daftar Kolam"
2. Tekan tombol ➕ (FAB)
3. Isi data kolam:
   - Nama kolam
   - Panjang, lebar, kedalaman (otomatis hitung volume)
   - Foto kolam (opsional)
4. Klik "Simpan"

### Input Data Inventori Ikan
1. Masuk ke menu "Inventori Ikan"
2. Tekan ➕ untuk tambah data
3. Pilih kolam tujuan
4. Masukkan jumlah ikan dan berat rata-rata
5. Klik "Simpan"

### Manajemen Pakan
1. Buka "Manajemen Pakan"
2. Lihat summary stok pakan
3. Tambah jenis pakan baru dengan ➕
4. Tracking stok dan harga pakan

### Monitoring Kesehatan
1. Buka "Monitoring Kesehatan"
2. Tambah record monitoring dengan ➕
3. Input parameter kesehatan:
   - Parameter (suhu, pH, dll)
   - Nilai
   - Status (Baik, Normal, Buruk)
4. Lihat trend kesehatan di grafik

### Input Data Panen
1. Buka "Data Panen"
2. Tekan ➕ untuk input panen baru
3. Pilih kolam yang dipanen
4. Masukkan berat panen dan harga per kg
5. Lihat analitik produktivitas

## 🔒 Keamanan

✅ **Firebase Authentication** - Email/password terenkripsi
✅ **Firestore Security Rules** - Hanya authenticated user
✅ **SSL/TLS Encryption** - Komunikasi aman ke server
✅ **No Password Storage** - Managed oleh Firebase
✅ **Session Management** - Auto logout jika idle


### Error saat login
- ✅ Pastikan email belum terdaftar
- ✅ Gunakan password minimal 6 karakter
- ✅ Check Firebase Authentication aktif

### Data tidak tersimpan
- ✅ Periksa koneksi internet
- ✅ Pastikan security rules di Firestore sudah benar
- ✅ Lihat Firebase Console untuk error logs

## 📊 Performance & Optimasi

- ✅ Lazy loading data dari Firestore
- ✅ Image compression untuk foto
- ✅ Efficient state management
- ✅ Smooth 60 FPS animations
- ✅ Minimal memory footprint


## 📝 Catatan Developer
```

### Model Struktur Data:
```dart
// Pond, Fish, Feed, Health, Feeding, Harvest
// Semua model memiliki factory.fromMap() dan toMap()
// untuk Firebase Firestore serialization
```


**Last Updated**: February 2026
**Version**: 1.0.0
**Status**: Ready ✅

