import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_assets.dart';
import '../data/learning_data.dart';
import '../theme/app_theme.dart';
import '../ui/tile_kit.dart';
import 'category_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _greetingIndex = 0;
  bool _wordOpen = false;

  void _nextGreeting() {
    setState(() {
      _greetingIndex = (_greetingIndex + 1) % wdGreetings.length;
    });
    HapticFeedback.selectionClick();
  }

  void _toggleWord() {
    setState(() => _wordOpen = !_wordOpen);
    HapticFeedback.selectionClick();
  }

  void _openTopic(LearningTopic topic) {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => CategoryScreen(topic: topic)),
    );
  }

  void _openQuiz() {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const QuizScreen(topics: kTopics),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double width = media.size.width;
    final bool compact = width < 390;
    final bool wide = width >= 640;

    final double horizontal = wide
        ? (width - 560) / 2
        : (compact ? 12.0 : 16.0);
    final double top = media.padding.top + 10;
    final double bottom = media.padding.bottom + 28;
    final double leading = wide ? 64.0 : (compact ? 48.0 : 54.0);
    final double heroLeading = wide ? 80.0 : (compact ? 62.0 : 70.0);
    final WdGreeting greeting = wdGreetings[_greetingIndex];
    const WordEntry word = kWordOfTheDay;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom),
        children: <Widget>[
          _brandBar(compact: compact),
          TileKit.gap(8),
          _hero(greeting: greeting, compact: compact, leading: heroLeading),
          TileKit.gap(18),
          _section(
            number: AppAssets.one,
            title: 'Kata Hari Ini',
            subtitle: 'Satu kata baru setiap hari',
            trailing: _wordOpen ? 'Sudah dibuka' : 'Buka yuk',
            compact: compact,
          ),
          TileKit.gap(8),
          _wordOfTheDay(word: word, compact: compact),
          TileKit.gap(18),
          _section(
            number: AppAssets.two,
            title: 'Pilih Petualanganmu',
            subtitle: 'Delapan topik seru untuk dicoba',
            trailing: '${kTopics.length} topik',
            compact: compact,
          ),
          TileKit.gap(8),
          for (final LearningTopic topic in kTopics) ...<Widget>[
            _topicTile(topic: topic, leading: leading, compact: compact),
            TileKit.gap(9),
          ],
          TileKit.gap(9),
          _section(
            number: AppAssets.three,
            title: 'Tantangan & Tips',
            subtitle: 'Sedikit latihan, banyak kemajuan',
            trailing: 'Ayo semangat',
            compact: compact,
          ),
          TileKit.gap(8),
          _quizTile(leading: leading, compact: compact),
          TileKit.gap(9),
          _tipTile(compact: compact),
          TileKit.gap(20),
          _footer(),
        ],
      ),
    );
  }

  Widget _brandBar({required bool compact}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      minLeadingWidth: 42,
      leading: TileKit.art(AppAssets.fox, compact ? 44 : 48),
      title: Text(
        'Wd English',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(
          size: compact ? 21 : 23,
          weight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
      ),
      subtitle: Text(
        'Belajar Inggris sambil bermain',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(
          size: compact ? 10.5 : 11.5,
          color: AppColors.inkSoft,
        ),
      ),
      trailing: TileKit.art(AppAssets.flagUk, compact ? 28 : 32),
    );
  }

  Widget _hero({
    required WdGreeting greeting,
    required bool compact,
    required double leading,
  }) {
    return ListTile(
      onTap: _nextGreeting,
      tileColor: greeting.color,
      shape: TileKit.shape(corners: 28),
      contentPadding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      minVerticalPadding: 10,
      leading: TileKit.art(AppAssets.fox, leading),
      title: Text(
        greeting.english,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(
          size: compact ? 19 : 23,
          weight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      subtitle: Text(
        '${greeting.indonesian} • ${greeting.tip}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(
          size: compact ? 11 : 12.5,
          color: AppColors.inkSoft,
        ),
      ),
      trailing: TileKit.art(AppAssets.sparkle, compact ? 22 : 26),
      titleAlignment: ListTileTitleAlignment.center,
    );
  }

  Widget _section({
    required String number,
    required String title,
    required String subtitle,
    required String trailing,
    required bool compact,
  }) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      minLeadingWidth: 28,
      leading: TileKit.art(number, compact ? 26 : 28),
      title: Text(
        title,
        style: AppType.style(size: compact ? 16 : 17, weight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: Text(
        trailing,
        style: AppType.style(
          size: compact ? 10.5 : 11,
          weight: FontWeight.w600,
          color: AppColors.coral,
        ),
      ),
    );
  }

  Widget _wordOfTheDay({required WordEntry word, required bool compact}) {
    return ListTile(
      onTap: _toggleWord,
      tileColor: _wordOpen ? AppColors.lime : AppColors.butter,
      shape: TileKit.shape(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: TileKit.art(word.asset, compact ? 48 : 54),
      title: Text(
        word.english,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 18 : 19, weight: FontWeight.w600),
      ),
      subtitle: Text(
        _wordOpen
            ? '${word.indonesian} • dibaca: ${word.hint}'
            : 'Ketuk untuk membuka arti rahasia',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 12, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(
        _wordOpen ? AppAssets.check : AppAssets.question,
        26,
      ),
    );
  }

  Widget _topicTile({
    required LearningTopic topic,
    required double leading,
    required bool compact,
  }) {
    return ListTile(
      onTap: () => _openTopic(topic),
      tileColor: topic.color,
      shape: TileKit.shape(corners: 22),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: TileKit.art(topic.cover, leading),
      title: Text(
        topic.english,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 17 : 18, weight: FontWeight.w600),
      ),
      subtitle: Text(
        '${topic.indonesian} • ${topic.words.length} kata',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(AppAssets.arrowRight, 24),
    );
  }

  Widget _quizTile({required double leading, required bool compact}) {
    return ListTile(
      onTap: _openQuiz,
      tileColor: AppColors.lavender,
      shape: TileKit.shape(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: TileKit.art(AppAssets.trophy, leading),
      title: Text(
        'Tantangan Kilat',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 17 : 18, weight: FontWeight.w600),
      ),
      subtitle: Text(
        '3 soal seru • kumpulkan bintang',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(AppAssets.arrowRight, 24),
    );
  }

  Widget _tipTile({required bool compact}) {
    return ListTile(
      tileColor: AppColors.sky,
      shape: TileKit.shape(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: TileKit.art(AppAssets.bulb, compact ? 40 : 44),
      title: Text(
        'Tips Wd',
        style: AppType.style(size: compact ? 16 : 17, weight: FontWeight.w600),
      ),
      subtitle: Text(
        'Ketuk setiap kata untuk melihat arti dan cara membacanya. Ulangi tiga kali supaya makin ingat!',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      isThreeLine: true,
    );
  }

  Widget _footer() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: TileKit.art(AppAssets.sparkle, 22),
      title: Text(
        'Ilustrasi: OpenMoji • CC BY-SA 4.0',
        style: AppType.style(size: 10.5, color: AppColors.inkSoft),
      ),
      subtitle: Text(
        'Dibuat untuk belajar bahasa Inggris dengan gembira.',
        style: AppType.style(size: 10.5, color: AppColors.inkSoft),
      ),
    );
  }
}
