# UAS Catfish - Aplikasi Manajemen Budidaya Ikan 

## Deskripsi Proyek

Aplikasi mobile berbasis Flutter yang dirancang untuk membantu petani ikan lele dalam mengelola operasional budidaya ikan secara efisien. Aplikasi ini menyediakan fitur-fitur komprehensif untuk monitoring dan manajemen kolam, inventori ikan, pemberian pakan, kesehatan ikan, serta data panen.

## Fitur Utama

### 1. Dashboard Analytics
- Tampilan statistik real-time
- Grafik interaktif untuk tracking performa
- Ringkasan data penting (total kolam, inventori, pakan, dll.)

### 2. Manajemen Kolam
- Tambah, edit, dan hapus data kolam
- Monitoring status kolam (sehat, moderat, tidak sehat)
- Informasi dimensi kolam (panjang, lebar, kedalaman)

### 3. Inventori Ikan
- Tracking jumlah dan berat rata-rata ikan per kolam
- Filter dan sorting data inventori
- Statistik inventori

### 4. Manajemen Pakan
- Monitoring stok pakan
- Tracking konsumsi pakan
- Analitik penggunaan pakan

### 5. Monitoring Kesehatan
- Pencatatan parameter kesehatan ikan
- Status kesehatan per kolam
- Alert untuk kondisi tidak normal

### 6. Data Pemberian Pakan
- Scheduling pemberian pakan
- Tracking pemberian pakan harian
- Filter berdasarkan kolam

### 7. Data Panen
- Pencatatan hasil panen
- Forecasting produktivitas
- Analitik panen

## Teknologi yang Digunakan

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Authentication, Firestore)
- **State Management**: Provider
- **UI Components**: Material Design 3
- **Charts**: fl_chart
- **Date Formatting**: intl
- **Database**: Cloud Firestore

## Struktur Proyek

```
lib/
├── main.dart                    # Entry point aplikasi
├── models/                      # Data models
│   ├── pond.dart               # Model kolam
│   ├── fish_inventory.dart     # Model inventori ikan
│   ├── feed.dart               # Model pakan
│   ├── health_monitoring.dart  # Model monitoring kesehatan
│   ├── feeding.dart            # Model pemberian pakan
│   └── harvest.dart            # Model panen
├── providers/                   # State management providers
│   ├── pond_provider.dart
│   ├── fish_inventory_provider.dart
│   ├── feed_provider.dart
│   ├── health_provider.dart
│   ├── feeding_provider.dart
│   └── harvest_provider.dart
├── screens/                     # UI screens
│   ├── dashboard_screen.dart
│   ├── pond_list_screen.dart
│   ├── fish_inventory_screen.dart
│   ├── feed_management_screen.dart
│   ├── health_monitoring_screen.dart
│   ├── feeding_data_screen.dart
│   ├── harvest_data_screen.dart
│   └── login_screen.dart
└── services/                    # Firebase services
    └── firebase_service.dart
```

## Persyaratan Sistem

- Flutter SDK (versi 3.0 atau lebih baru)
- Dart SDK
- Android Studio atau VS Code
- Akun Firebase

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
1. Buat proyek baru di Firebase Console
2. Enable Authentication dan Firestore
3. Download file konfigurasi `google-services.json` untuk Android
4. Download file konfigurasi untuk iOS jika diperlukan
5. Letakkan file konfigurasi di folder yang sesuai

### 4. Konfigurasi Firebase
Update file `lib/services/firebase_service.dart` dengan konfigurasi Firebase Anda.

## Cara Menjalankan Aplikasi

### Development Mode
```bash
flutter run
```

### Build APK
```bash
flutter build apk --release
```

### Build untuk iOS
```bash
flutter build ios
```

## Testing

Jalankan unit tests:
```bash
flutter test
```

## Manfaat Aplikasi

1. **Efisiensi Operasional**: Mengurangi waktu dan tenaga dalam pencatatan manual
2. **Monitoring Real-time**: Tracking kondisi kolam dan ikan secara langsung
3. **Analitik Data**: Bantuan pengambilan keputusan berdasarkan data historis
4. **Manajemen Risiko**: Deteksi dini masalah kesehatan dan stok
5. **Peningkatan Produktivitas**: Optimasi pemberian pakan dan panen

## Kesimpulan

Aplikasi UAS Catfish merupakan solusi digital untuk modernisasi budidaya ikan lele. Dengan integrasi teknologi mobile dan cloud, aplikasi ini membantu petani dalam mengelola operasional budidaya secara lebih efektif dan efisien. Fitur-fitur yang komprehensif memungkinkan monitoring menyeluruh dari hulu ke hilir proses budidaya ikan.

## Tim Pengembang

- [Nama Anda] - Developer
- Universitas: [Nama Universitas]
- Mata Kuliah: [Nama Mata Kuliah]

## Lisensi

This project is licensed under the MIT License - see the LICENSE file for details.
