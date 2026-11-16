# Wd English 🦊

Landing page mobile-first untuk anak yang ingin belajar bahasa Inggris sambil
bermain. Seluruh antarmuka dibangun dengan **ListView**, **ListTile**, dan
**Image** — tanpa Card, Container, Row, Column, GridView, Stack, AppBar, atau
Icon.

## Fitur

- **Maskot Wd** yang bisa diketuk untuk berganti sapaan dan warna kartu.
- **Kata Hari Ini** dengan efek kartu rahasia (tap untuk membuka arti).
- **8 topik belajar**: Alphabet, Animals, Fruits, Colors, Numbers, Family,
  Body, dan Greetings.
- **Halaman topik** dengan progres "x dari 6 kata dipelajari".
- **Tantangan Kilat**: kuis 3 soal acak dengan feedback langsung dan skor.
- Petunjuk baca sederhana untuk setiap kata (contoh: `Cat • Kucing • dibaca:
  ket`).
- Responsif untuk layar kecil, ponsel biasa, tablet, portrait, dan landscape.
- Umpan balik haptic halus saat berinteraksi.

## Menjalankan

```bash
flutter pub get
flutter run
```

Untuk menjalankan pengujian kualitas:

```bash
dart format lib test
flutter analyze
flutter test
```

## Struktur

```
lib/
  main.dart                     # Entry point + tema aplikasi
  app_assets.dart               # Daftar path aset
  data/learning_data.dart       # Topik, kata, sapaan Wd
  theme/app_theme.dart          # Palet warna dan tipografi Fredoka
  ui/tile_kit.dart              # Helper Image, gap, dan bentuk tile
  screens/home_screen.dart      # Landing page
  screens/category_screen.dart  # Daftar kata per topik
  screens/quiz_screen.dart      # Mini kuis interaktif
assets/
  images/mascot/                # Maskot rubah
  images/ui/                    # Ikon antarmuka
  images/words/                 # Ilustrasi kosakata
  fonts/                        # Fredoka 400-700
  licenses/                     # Lisensi font dan ilustrasi
```

## Catatan implementasi

- Tidak ada package tambahan saat runtime; aplikasi hanya memakai Flutter SDK.
- Jarak antar tile menggunakan gambar transparan agar aturan "hanya
  ListTile/ListView/Image" tetap terjaga.
- `Text` hanya muncul sebagai isi `title`/`subtitle` di dalam `ListTile`,
  karena materi belajar memang perlu teks. `MaterialApp` dan `Scaffold` tetap
  dipakai sebagai kerangka wajib Flutter.
- Semua ilustrasi dibundel lokal, jadi tidak ada gambar yang diambil dari
  internet saat aplikasi berjalan.
- Ikon aplikasi (Android, iOS, web) dan splash screen memakai maskot Wd
  dengan latar krem yang sama seperti tema aplikasi.

## Lisensi aset

- Ilustrasi: [OpenMoji](https://openmoji.org/) — CC BY-SA 4.0. Teks lisensi
  ada di `assets/licenses/OpenMoji-CC-BY-SA-4.0.txt`.
- Font: [Fredoka](https://fonts.google.com/specimen/Fredoka) — SIL Open Font
  License 1.1. Teks lisensi ada di `assets/licenses/Fredoka-OFL.txt`.
