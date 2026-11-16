import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WordEntry {
  const WordEntry({
    required this.english,
    required this.indonesian,
    required this.hint,
    required this.asset,
    this.label,
  });

  final String english;
  final String indonesian;

  /// Petunjuk baca sederhana untuk anak, bukan simbol IPA.
  final String hint;
  final String asset;
  final String? label;

  String get display => label ?? english;
}

class LearningTopic {
  const LearningTopic({
    required this.english,
    required this.indonesian,
    required this.tagline,
    required this.color,
    required this.cover,
    required this.words,
  });

  final String english;
  final String indonesian;
  final String tagline;
  final Color color;
  final String cover;
  final List<WordEntry> words;
}

class WdGreeting {
  const WdGreeting({
    required this.english,
    required this.indonesian,
    required this.tip,
    required this.color,
  });

  final String english;
  final String indonesian;
  final String tip;
  final Color color;
}

const List<WdGreeting> wdGreetings = <WdGreeting>[
  WdGreeting(
    english: 'Hello!',
    indonesian: 'Halo!',
    tip: 'ketuk aku lagi',
    color: AppColors.mint,
  ),
  WdGreeting(
    english: 'Good day!',
    indonesian: 'Hari yang seru!',
    tip: 'ayo mulai',
    color: AppColors.peach,
  ),
  WdGreeting(
    english: "Let's learn!",
    indonesian: 'Ayo belajar!',
    tip: 'kamu pasti bisa',
    color: AppColors.sky,
  ),
  WdGreeting(
    english: 'High five!',
    indonesian: 'Tos dulu!',
    tip: 'semangat ya',
    color: AppColors.lavender,
  ),
  WdGreeting(
    english: 'Thank you!',
    indonesian: 'Terima kasih!',
    tip: 'kamu hebat',
    color: AppColors.butter,
  ),
];

const WordEntry kWordOfTheDay = WordEntry(
  english: 'Butterfly',
  indonesian: 'Kupu-kupu',
  hint: 'ba-ter-flai',
  asset: 'assets/images/words/butterfly.png',
);

const List<LearningTopic> kTopics = <LearningTopic>[
  LearningTopic(
    english: 'Alphabet',
    indonesian: 'Alfabet',
    tagline: 'Dari A sampai F',
    color: AppColors.sky,
    cover: 'assets/images/ui/abc.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Apple',
        label: 'A • Apple',
        indonesian: 'Apel',
        hint: 'e-pel',
        asset: 'assets/images/words/apple.png',
      ),
      WordEntry(
        english: 'Ball',
        label: 'B • Ball',
        indonesian: 'Bola',
        hint: 'bol',
        asset: 'assets/images/words/ball.png',
      ),
      WordEntry(
        english: 'Cat',
        label: 'C • Cat',
        indonesian: 'Kucing',
        hint: 'ket',
        asset: 'assets/images/words/cat.png',
      ),
      WordEntry(
        english: 'Dog',
        label: 'D • Dog',
        indonesian: 'Anjing',
        hint: 'dog',
        asset: 'assets/images/words/dog.png',
      ),
      WordEntry(
        english: 'Elephant',
        label: 'E • Elephant',
        indonesian: 'Gajah',
        hint: 'e-li-fen',
        asset: 'assets/images/words/elephant.png',
      ),
      WordEntry(
        english: 'Fish',
        label: 'F • Fish',
        indonesian: 'Ikan',
        hint: 'fis',
        asset: 'assets/images/words/fish.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Animals',
    indonesian: 'Hewan',
    tagline: 'Kenalan dengan hewan lucu',
    color: AppColors.mint,
    cover: 'assets/images/words/lion.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Cat',
        indonesian: 'Kucing',
        hint: 'ket',
        asset: 'assets/images/words/cat.png',
      ),
      WordEntry(
        english: 'Dog',
        indonesian: 'Anjing',
        hint: 'dog',
        asset: 'assets/images/words/dog.png',
      ),
      WordEntry(
        english: 'Lion',
        indonesian: 'Singa',
        hint: 'lai-en',
        asset: 'assets/images/words/lion.png',
      ),
      WordEntry(
        english: 'Elephant',
        indonesian: 'Gajah',
        hint: 'e-li-fen',
        asset: 'assets/images/words/elephant.png',
      ),
      WordEntry(
        english: 'Rabbit',
        indonesian: 'Kelinci',
        hint: 're-bet',
        asset: 'assets/images/words/rabbit.png',
      ),
      WordEntry(
        english: 'Monkey',
        indonesian: 'Monyet',
        hint: 'mang-ki',
        asset: 'assets/images/words/monkey.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Fruits',
    indonesian: 'Buah',
    tagline: 'Buah segar setiap hari',
    color: AppColors.peach,
    cover: 'assets/images/words/apple.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Apple',
        indonesian: 'Apel',
        hint: 'e-pel',
        asset: 'assets/images/words/apple.png',
      ),
      WordEntry(
        english: 'Banana',
        indonesian: 'Pisang',
        hint: 'be-na-ne',
        asset: 'assets/images/words/banana.png',
      ),
      WordEntry(
        english: 'Strawberry',
        indonesian: 'Stroberi',
        hint: 'stro-be-ri',
        asset: 'assets/images/words/strawberry.png',
      ),
      WordEntry(
        english: 'Watermelon',
        indonesian: 'Semangka',
        hint: 'wo-ter-me-len',
        asset: 'assets/images/words/watermelon.png',
      ),
      WordEntry(
        english: 'Orange',
        indonesian: 'Jeruk',
        hint: 'o-renj',
        asset: 'assets/images/words/orange_fruit.png',
      ),
      WordEntry(
        english: 'Grapes',
        indonesian: 'Anggur',
        hint: 'greips',
        asset: 'assets/images/words/grapes.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Colors',
    indonesian: 'Warna',
    tagline: 'Warna-warni ceria',
    color: AppColors.butter,
    cover: 'assets/images/ui/rainbow.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Red',
        indonesian: 'Merah',
        hint: 'red',
        asset: 'assets/images/words/red.png',
      ),
      WordEntry(
        english: 'Orange',
        indonesian: 'Oranye',
        hint: 'o-renj',
        asset: 'assets/images/words/orange.png',
      ),
      WordEntry(
        english: 'Yellow',
        indonesian: 'Kuning',
        hint: 'ye-lou',
        asset: 'assets/images/words/yellow.png',
      ),
      WordEntry(
        english: 'Green',
        indonesian: 'Hijau',
        hint: 'grin',
        asset: 'assets/images/words/green.png',
      ),
      WordEntry(
        english: 'Blue',
        indonesian: 'Biru',
        hint: 'blu',
        asset: 'assets/images/words/blue.png',
      ),
      WordEntry(
        english: 'Purple',
        indonesian: 'Ungu',
        hint: 'per-pel',
        asset: 'assets/images/words/purple.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Numbers',
    indonesian: 'Angka',
    tagline: 'Hitung satu sampai enam',
    color: AppColors.lavender,
    cover: 'assets/images/words/one.png',
    words: <WordEntry>[
      WordEntry(
        english: 'One',
        indonesian: 'Satu',
        hint: 'wan',
        asset: 'assets/images/words/one.png',
      ),
      WordEntry(
        english: 'Two',
        indonesian: 'Dua',
        hint: 'tu',
        asset: 'assets/images/words/two.png',
      ),
      WordEntry(
        english: 'Three',
        indonesian: 'Tiga',
        hint: 'tri',
        asset: 'assets/images/words/three.png',
      ),
      WordEntry(
        english: 'Four',
        indonesian: 'Empat',
        hint: 'for',
        asset: 'assets/images/words/four.png',
      ),
      WordEntry(
        english: 'Five',
        indonesian: 'Lima',
        hint: 'faiv',
        asset: 'assets/images/words/five.png',
      ),
      WordEntry(
        english: 'Six',
        indonesian: 'Enam',
        hint: 'siks',
        asset: 'assets/images/words/six.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Family',
    indonesian: 'Keluarga',
    tagline: 'Keluarga tercinta',
    color: AppColors.rose,
    cover: 'assets/images/words/family.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Father',
        indonesian: 'Ayah',
        hint: 'fa-der',
        asset: 'assets/images/words/father.png',
      ),
      WordEntry(
        english: 'Mother',
        indonesian: 'Ibu',
        hint: 'ma-der',
        asset: 'assets/images/words/mother.png',
      ),
      WordEntry(
        english: 'Brother',
        indonesian: 'Kakak laki-laki',
        hint: 'bra-der',
        asset: 'assets/images/words/brother.png',
      ),
      WordEntry(
        english: 'Sister',
        indonesian: 'Kakak perempuan',
        hint: 'sis-ter',
        asset: 'assets/images/words/sister.png',
      ),
      WordEntry(
        english: 'Grandpa',
        indonesian: 'Kakek',
        hint: 'gran-pa',
        asset: 'assets/images/words/grandpa.png',
      ),
      WordEntry(
        english: 'Grandma',
        indonesian: 'Nenek',
        hint: 'gran-ma',
        asset: 'assets/images/words/grandma.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Body',
    indonesian: 'Tubuh',
    tagline: 'Kenali anggota tubuh',
    color: AppColors.aqua,
    cover: 'assets/images/words/eye.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Eye',
        indonesian: 'Mata',
        hint: 'ai',
        asset: 'assets/images/words/eye.png',
      ),
      WordEntry(
        english: 'Ear',
        indonesian: 'Telinga',
        hint: 'ir',
        asset: 'assets/images/words/ear.png',
      ),
      WordEntry(
        english: 'Nose',
        indonesian: 'Hidung',
        hint: 'nouz',
        asset: 'assets/images/words/nose.png',
      ),
      WordEntry(
        english: 'Mouth',
        indonesian: 'Mulut',
        hint: 'mauth',
        asset: 'assets/images/words/mouth.png',
      ),
      WordEntry(
        english: 'Hand',
        indonesian: 'Tangan',
        hint: 'hend',
        asset: 'assets/images/words/hand.png',
      ),
      WordEntry(
        english: 'Foot',
        indonesian: 'Kaki',
        hint: 'fut',
        asset: 'assets/images/words/foot.png',
      ),
    ],
  ),
  LearningTopic(
    english: 'Greetings',
    indonesian: 'Sapaan',
    tagline: 'Sapaan setiap hari',
    color: AppColors.lime,
    cover: 'assets/images/words/hello_wave.png',
    words: <WordEntry>[
      WordEntry(
        english: 'Hello',
        indonesian: 'Halo',
        hint: 'he-lou',
        asset: 'assets/images/words/hello_wave.png',
      ),
      WordEntry(
        english: 'Good morning',
        indonesian: 'Selamat pagi',
        hint: 'gud mor-ning',
        asset: 'assets/images/words/good_morning.png',
      ),
      WordEntry(
        english: 'Good night',
        indonesian: 'Selamat malam',
        hint: 'gud nait',
        asset: 'assets/images/words/good_night.png',
      ),
      WordEntry(
        english: 'Thank you',
        indonesian: 'Terima kasih',
        hint: 'teng-kyu',
        asset: 'assets/images/words/thank_you.png',
      ),
      WordEntry(
        english: 'Good job',
        indonesian: 'Kerja bagus',
        hint: 'gud job',
        asset: 'assets/images/words/good_job.png',
      ),
      WordEntry(
        english: 'Smile',
        indonesian: 'Tersenyum',
        hint: 'smail',
        asset: 'assets/images/words/smile.png',
      ),
    ],
  ),
];

/// Dipakai kuis dan pengujian untuk mencari kata dari semua topik.
List<WordEntry> get kAllWords => <WordEntry>[
  for (final LearningTopic topic in kTopics) ...topic.words,
];
