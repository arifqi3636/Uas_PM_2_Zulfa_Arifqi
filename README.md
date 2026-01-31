# UAS Catfish - Aplikasi Manajemen Budidaya Ikan Lele 🐟

> Solusi digital komprehensif untuk manajemen akuakultur ikan lele dengan antarmuka yang intuitif dan fitur-fitur canggih.

## 📋 Deskripsi Proyek

**UAS Catfish** adalah aplikasi mobile dan web berbasis **Flutter** yang dirancang khusus untuk membantu petani dan pembudidaya ikan lele dalam mengelola operasional budidaya ikan secara efisien dan terintegrasi. Aplikasi ini menggabungkan teknologi modern dengan kebutuhan praktis pengguna di lapangan.

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

## 🎨 Desain dan Visual

### Palet Warna Profesional
Aplikasi menggunakan color scheme yang modern, menarik, namun tetap profesional:

| Komponen | Warna | Kode Hex | Fungsi |
|----------|-------|----------|--------|
| Primary Green | Hijau Cerah | #27AE60 | AppBar, Primary Button, Tema Utama |
| Primary Green Dark | Hijau Gelap | #1E8449 | Emphasis, Dark Mode |
| Primary Green Light | Hijau Muda | #52BE80 | Aksen, Hover States |
| Accent Blue | Biru | #3498DB | Ikan & Data Air |
| Accent Orange | Orange | #E67E22 | Pakan & Supplies |
| Accent Yellow | Kuning | #F1C40F | Panen & Produksi |
| Accent Brown | Cokelat | #8B6F47 | Elemen Tanah |

### Status Colors
- 🟢 **Sehat/Healthy** (#27AE60) - Kondisi optimal
- 🟠 **Moderat/Moderate** (#E67E22) - Perlu perhatian
- 🔴 **Tidak Sehat/Unhealthy** (#E74C3C) - Kondisi kritis

### Logo & Brand
Logo aplikasi menampilkan ikon ikan lele dalam lingkaran hijau yang merepresentasikan tema budidaya ikan berkelanjutan. Ditampilkan di:
- 🔐 Login & Register Screen
- 📱 Dashboard Header
- ℹ️ About Section

## ✨ Fitur Utama
- Alert stok rendah

## ✨ Fitur Utama

### 📊 1. Dashboard Analytics
Layar utama dengan visualisasi data real-time:
- 📈 **Grafik Interaktif** - Tracking panen dan kesehatan ikan
- 📋 **Summary Cards** - Statistik kolam, ikan, pakan, kesehatan
- ⚠️ **Alert System** - Notifikasi kondisi abnormal (kolam tidak sehat, stok pakan rendah)
- 📱 **Responsive Design** - Tampilan optimal di semua ukuran layar
- ✨ **Smooth Animations** - Animasi masuk yang elegan

**Warna Card**:
- 🟢 Kolam Sehat (Hijau) | 🟠 Kolam Moderat (Orange) | 🔴 Kolam Tidak Sehat (Merah)
- 🔵 Total Ikan (Biru) | 🟡 Panen (Kuning) | 🟠 Pakan (Orange)

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

## 🛠️ Teknologi yang Digunakan

| Layer | Teknologi | Fungsi |
|-------|-----------|--------|
| **Frontend** | Flutter 3.0+ | Framework cross-platform |
| **Language** | Dart | Bahasa pemrograman |
| **UI Kit** | Material Design 3 | Design system |
| **State Management** | Provider | Manajemen state aplikasi |
| **Backend** | Firebase | Cloud services |
| **Authentication** | Firebase Auth | Login & security |
| **Database** | Firestore | Real-time database |
| **Charts** | fl_chart | Visualisasi data |
| **Image Picker** | image_picker | Upload foto |
| **Date Handling** | intl | Format tanggal |
| **Local Storage** | SharedPreferences | Preferensi user |

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

## 🎨 Desain dan UX

### Material Design 3
✅ Modern dan konsisten
✅ Responsive di berbagai ukuran
✅ Dark mode support
✅ Smooth animations & transitions

### Color Psychology
- 🟢 **Hijau** (Pertanian/Kesehatan) - Primary warna
- 🔵 **Biru** (Air/Ikan) - Untuk data ikan
- 🟠 **Orange** (Energi/Pakan) - Untuk manajemen pakan
- 🟡 **Kuning** (Hasil/Panen) - Untuk data produksi
- 🔴 **Merah** (Alert) - Untuk kondisi kritis

## 🚀 Persyaratan Sistem

### Minimum Requirements
- **Flutter SDK**: 3.0 atau lebih baru
- **Dart SDK**: 3.0 atau lebih baru  
- **Android**: API level 21+ (untuk Android)
- **iOS**: iOS 11.0+ (untuk iOS)
- **RAM**: 2GB minimum
- **Storage**: 500MB free space

### Development Tools
- **IDE**: Android Studio, VS Code, atau IntelliJ IDEA
- **Flutter Plugin**: Untuk IDE pilihan Anda
- **Git**: Untuk version control
- **Firebase Account**: Gratis di https://firebase.google.com

## 📥 Instalasi dan Setup

### Step 1: Clone Repository
```bash
git clone https://github.com/arifqi3636/Uas_PM.git
cd uas_catfish
```

### Step 2: Install Dependencies Flutter
```bash
flutter pub get
```

### Step 3: Setup Firebase

#### Untuk Android:
1. Buat proyek baru di [Firebase Console](https://console.firebase.google.com)
2. Tambahkan aplikasi Android:
   - Package name: `com.example.uas_catfish`
   - SHA-1 Certificate: Dapatkan dari `flutter run`
3. Download `google-services.json`
4. Letakkan file di `android/app/`

#### Untuk iOS:
1. Download `GoogleService-Info.plist`
2. Letakkan di `ios/Runner/`

#### Setup Firestore & Authentication:
3. Di Firebase Console:
   - ✅ Enable "Email/Password" authentication
   - ✅ Enable Firestore Database dengan security rules:
   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```

### Step 4: Run Aplikasi
```bash
# Untuk Android
flutter run

# Untuk iOS
flutter run -d ios

# Untuk Web
flutter run -d chrome

# Untuk Windows
flutter run -d windows
```

## 🔨 Build & Release

### Build APK (Android Debug)
```bash
flutter build apk --debug
```

### Build APK Release
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web --release
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

## 🎓 Fitur Pembelajaran

Proyek ini memdemonstrasikan:
- ✅ MVVM Architecture Pattern
- ✅ State Management dengan Provider
- ✅ Firebase Integration (Auth + Firestore)
- ✅ Responsive UI Design
- ✅ Chart & Data Visualization
- ✅ Form Validation
- ✅ Error Handling
- ✅ Image Picker Integration

## 🐛 Troubleshooting

### Aplikasi tidak connect ke Firebase
- ✅ Pastikan `google-services.json` di tempat yang benar
- ✅ Periksa SHA-1 certificate di Firebase Console
- ✅ Pastikan internet connection aktif

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

## 🤝 Kontribusi

Jika ingin berkontribusi:
1. Fork repository
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

## 📝 Catatan Developer

### Warna untuk berbagai kategori:
```dart
// lib/theme/app_theme.dart
static const Color primaryGreen = Color(0xFF27AE60);      // Tema utama
static const Color accentBlue = Color(0xFF3498DB);        // Ikan & Air
static const Color accentOrange = Color(0xFFE67E22);      // Pakan
static const Color statusHealthy = Color(0xFF27AE60);     // Sehat (Hijau)
static const Color statusModerate = Color(0xFFE67E22);    // Moderat (Orange)
static const Color statusUnhealthy = Color(0xFFE74C3C);   // Tidak Sehat (Merah)
```

### Model Struktur Data:
```dart
// Pond, Fish, Feed, Health, Feeding, Harvest
// Semua model memiliki factory.fromMap() dan toMap()
// untuk Firebase Firestore serialization
```

## 📞 Support & Feedback

Untuk pertanyaan atau feedback:
- 📧 Email: [your-email]
- 🐛 Issues: GitHub Issues
- 💬 Discussions: GitHub Discussions

## 📄 Lisensi

Proyek ini dilisensikan di bawah **MIT License** - lihat file [LICENSE](LICENSE) untuk detail.

---

## 🎉 Status Project

| Aspek | Status |
|-------|--------|
| Core Features | ✅ Completed |
| Firebase Integration | ✅ Completed |
| UI/UX Design | ✅ Completed |
| Dark/Light Theme | ✅ Completed |
| Analytics & Charts | ✅ Completed |
| Mobile Build | ✅ Ready |
| Web Build | ✅ Ready |
| Documentation | ✅ Complete |

## 📚 Referensi

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io)
- [Dart Language](https://dart.dev)

---

**Last Updated**: February 2026
**Version**: 1.0.0
**Status**: Production Ready ✅

Terima kasih telah menggunakan **UAS Catfish**! Semoga aplikasi ini membantu optimalisasi budidaya ikan lele Anda. 🐟🌾
