# UAS Catfish - Aplikasi Manajemen Budidaya Ikan 

## Deskripsi Proyek

Aplikasi mobile berbasis Flutter yang dirancang untuk membantu petani ikan lele dalam mengelola operasional budidaya ikan secara efisien. Aplikasi ini menyediakan fitur-fitur komprehensif untuk monitoring dan manajemen kolam, inventori ikan, pemberian pakan, kesehatan ikan, serta data panen.

## Desain dan Visual

### Tema Warna (Catfish Farming Theme)
Aplikasi menggunakan color scheme yang konsisten dengan sistem web catfish-farming-php:

- **Primary Green** (#2E7D32) - Warna utama untuk AppBar dan tombol
- **Dark Green** (#1B5E20) - Warna gelap untuk emphasis
- **Light Green** (#66BB6A) - Warna cerah untuk aksen
- **Accent Green** (#4CAF50) - Warna secondary
- **Status Colors:**
  - Hijau (#4CAF50) - Sehat/Normal
  - Orange (#FFA726) - Moderat
  - Merah (#E53935) - Tidak Sehat

### Logo Aplikasi
Logo aplikasi menampilkan ikon ikan lele dalam lingkaran hijau yang merepresentasikan tema budidaya ikan. Logo ditampilkan di:
- Login Screen
- Splash Screen (opsional)
- About Section

## Fitur Utama

### 1. Dashboard Analytics
- Tampilan statistik real-time dengan grafik interaktif
- Ringkasan data penting (total kolam, inventori, pakan, dll.)
- Alert untuk kondisi abnormal
- Animasi yang smooth dan responsif

### 2. Manajemen Kolam
- Tambah, edit, dan hapus data kolam
- Monitoring status kolam (sehat, moderat, tidak sehat)
- Informasi dimensi kolam (panjang, lebar, kedalaman)
- Status badge dengan warna yang sesuai

### 3. Inventori Ikan
- Tracking jumlah dan berat rata-rata ikan per kolam
- Filter dan sorting data inventori
- Statistik inventori dengan summary cards
- Visualisasi data per kolam

### 4. Manajemen Pakan
- Monitoring stok pakan real-time
- Tracking konsumsi pakan
- Analitik penggunaan pakan
- Alert stok rendah

### 5. Monitoring Kesehatan
- Pencatatan parameter kesehatan ikan
- Status kesehatan per kolam dengan badge
- Alert untuk kondisi tidak normal
- Tracking historis kondisi kesehatan

### 6. Data Pemberian Pakan
- Scheduling pemberian pakan
- Tracking pemberian pakan harian
- Filter berdasarkan kolam
- Analitik konsumsi pakan

### 7. Data Panen
- Pencatatan hasil panen
- Forecasting produktivitas
- Analitik panen dengan grafik
- ROI calculation

## Teknologi yang Digunakan

- **Frontend**: Flutter (Dart) - Cross-platform mobile app
- **Backend**: Firebase (Authentication, Firestore)
- **State Management**: Provider pattern
- **UI Components**: Material Design 3 dengan custom theme
- **Charts**: fl_chart untuk visualisasi data
- **Date Formatting**: intl package
- **Database**: Cloud Firestore untuk data persistence

## Struktur Proyek

```
lib/
├── main.dart                    # Entry point aplikasi
├── theme/
│   └── app_theme.dart          # Tema aplikasi terpusat
├── widgets/
│   ├── app_logo.dart           # Widget logo aplikasi
│   └── common_widgets.dart     # Widget umum (badge, card, dll)
├── models/                      # Data models
│   ├── pond.dart               # Model kolam
│   ├── fish_inventory.dart     # Model inventori ikan
│   ├── feed.dart               # Model pakan
│   ├── health_monitoring.dart  # Model monitoring kesehatan
│   ├── feeding.dart            # Model pemberian pakan
│   └── harvest.dart            # Model panen
├── providers/                   # State management
│   ├── auth_provider.dart
│   ├── pond_provider.dart
│   ├── fish_inventory_provider.dart
│   ├── feed_provider.dart
│   ├── health_provider.dart
│   ├── feeding_provider.dart
│   └── harvest_provider.dart
├── screens/                     # UI screens
│   ├── dashboard_screen.dart    # Dashboard dengan analytics
│   ├── pond_list_screen.dart    # Manajemen kolam
│   ├── fish_inventory_screen.dart
│   ├── feed_management_screen.dart
│   ├── health_monitoring_screen.dart
│   ├── feeding_data_screen.dart
│   ├── harvest_data_screen.dart
│   ├── login_screen.dart        # Login dengan logo
│   └── monitoring_screen.dart
├── services/
│   └── firebase_service.dart    # Firebase integration
└── assets/
    └── logo.svg                 # Logo aplikasi

```

## Fitur Visual & UX

### Material Design 3
- Menggunakan Material Design 3 untuk tampilan modern
- Custom theme yang konsisten di seluruh aplikasi
- Smooth animations dan transitions

### Responsive Design
- Layout yang responsive untuk berbagai ukuran layar
- Adaptive widgets untuk tablet dan phone
- Proper padding dan spacing

### Color Consistency
- Konsistensi warna di semua screen
- Status badge dengan warna yang mudah dipahami
- Gradient background untuk visual appeal

## Persyaratan Sistem

- Flutter SDK (versi 3.0 atau lebih baru)
- Dart SDK (versi 3.0 atau lebih baru)
- Android Studio atau VS Code dengan Flutter plugin
- Akun Firebase untuk backend

## Instalasi dan Setup

### 1. Clone Repository
```bash
git clone <repository-url>
cd uas_catfish
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Firebase
1. Buat proyek baru di [Firebase Console](https://console.firebase.google.com)
2. Enable Authentication (Email/Password)
3. Enable Firestore Database
4. Download file konfigurasi `google-services.json` untuk Android
5. Letakkan di `android/app/`

### 4. Jalankan Aplikasi
```bash
flutter run
```

## Build

### APK (Android)
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Manfaat Aplikasi

1. **Efisiensi Operasional**: Mengurangi waktu pencatatan manual
2. **Monitoring Real-time**: Tracking kondisi kolam secara langsung
3. **Analitik Data**: Bantuan pengambilan keputusan berbasis data
4. **Manajemen Risiko**: Deteksi dini masalah kesehatan
5. **Peningkatan Produktivitas**: Optimasi pemberian pakan dan panen
6. **User Experience**: Interface yang intuitif dan mudah digunakan

## Konsistensi dengan Web Version

Aplikasi ini dirancang untuk konsisten dengan web version (catfish-farming-php):
- ✅ Color scheme yang sama (hijau untuk tema pertanian)
- ✅ Fitur-fitur yang setara
- ✅ Data synchronization melalui Firebase
- ✅ UX/UI yang similar namun adapted untuk mobile

## Testing

Jalankan unit tests:
```bash
flutter test
```

## Kesimpulan

Aplikasi UAS Catfish merupakan solusi digital untuk modernisasi budidaya ikan lele. Dengan integrasi teknologi mobile dan cloud, aplikasi ini membantu petani dalam mengelola operasional budidaya secara lebih efektif. Fitur-fitur komprehensif memungkinkan monitoring menyeluruh dari hulu ke hilir proses budidaya ikan.

## Tim Pengembang

- Universitas: [Nama Universitas]
- Mata Kuliah: [Nama Mata Kuliah - UAS]
- Project: Sistem Manajemen Budidaya Ikan Lele

## Lisensi

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Status**: ✅ Aplikasi sudah integrated dengan theme hijau dan logo ditampilkan di login screen.
