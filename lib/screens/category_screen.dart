import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_assets.dart';
import '../data/learning_data.dart';
import '../theme/app_theme.dart';
import '../ui/tile_kit.dart';
import 'quiz_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.topic});

  final LearningTopic topic;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Set<String> _learned = <String>{};

  void _toggleWord(WordEntry word) {
    setState(() {
      if (!_learned.add(word.english)) {
        _learned.remove(word.english);
      }
    });
    HapticFeedback.selectionClick();
  }

  void _openQuiz() {
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          topics: <LearningTopic>[widget.topic],
          title: 'Kuis ${widget.topic.english}',
        ),
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
    final double leading = wide ? 60.0 : (compact ? 44.0 : 50.0);
    final int total = widget.topic.words.length;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom),
        children: <Widget>[
          _backBar(),
          TileKit.gap(8),
          _header(compact: compact, leading: leading),
          TileKit.gap(8),
          _progress(total: total),
          TileKit.gap(14),
          _hintBar(),
          TileKit.gap(6),
          for (final WordEntry word in widget.topic.words) ...<Widget>[
            _wordTile(word: word, compact: compact, leading: leading),
            TileKit.gap(9),
          ],
          TileKit.gap(8),
          _quizTile(compact: compact, leading: leading),
          TileKit.gap(16),
          _footer(),
        ],
      ),
    );
  }

  Widget _backBar() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
      leading: TileKit.art(AppAssets.arrowBack, 28),
      title: Text(
        'Kembali',
        style: AppType.style(size: 14, weight: FontWeight.w600),
      ),
      trailing: Text(
        'Wd English',
        style: AppType.style(size: 10.5, color: AppColors.inkSoft),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }

  Widget _header({required bool compact, required double leading}) {
    return ListTile(
      tileColor: widget.topic.color,
      shape: TileKit.shape(corners: 26),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      leading: TileKit.art(widget.topic.cover, leading),
      title: Text(
        widget.topic.english,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(
          size: compact ? 21 : 24,
          weight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
      subtitle: Text(
        '${widget.topic.indonesian} • ${widget.topic.tagline}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(AppAssets.star, 24),
    );
  }

  Widget _progress({required int total}) {
    final bool finished = _learned.length == total;
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: TileKit.art(AppAssets.medal, 26),
      title: Text(
        '${_learned.length} dari $total kata dipelajari',
        style: AppType.style(size: 13, weight: FontWeight.w500),
      ),
      trailing: Text(
        finished ? 'Selesai!' : 'Ayo!',
        style: AppType.style(
          size: 11.5,
          weight: FontWeight.w600,
          color: AppColors.coral,
        ),
      ),
    );
  }

  Widget _hintBar() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 6),
      leading: TileKit.art(AppAssets.paw, 22),
      title: Text(
        'Ketuk kata untuk melihat arti',
        style: AppType.style(size: 12, color: AppColors.inkSoft),
      ),
      trailing: Text(
        'Tap lagi untuk menutup',
        style: AppType.style(size: 10, color: AppColors.inkSoft),
      ),
    );
  }

  Widget _wordTile({
    required WordEntry word,
    required bool compact,
    required double leading,
  }) {
    final bool learned = _learned.contains(word.english);

    return ListTile(
      onTap: () => _toggleWord(word),
      tileColor: learned ? AppColors.mint : AppColors.white,
      shape: TileKit.shape(corners: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: TileKit.art(word.asset, leading),
      title: Text(
        word.display,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 16 : 17, weight: FontWeight.w600),
      ),
      subtitle: Text(
        learned
            ? '${word.indonesian} • dibaca: ${word.hint}'
            : 'Ketuk untuk lihat arti',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(learned ? AppAssets.check : AppAssets.question, 22),
    );
  }

  Widget _quizTile({required bool compact, required double leading}) {
    return ListTile(
      onTap: _openQuiz,
      tileColor: AppColors.lavender,
      shape: TileKit.shape(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      leading: TileKit.art(AppAssets.trophy, leading),
      title: Text(
        'Uji topik ${widget.topic.indonesian}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 16 : 17, weight: FontWeight.w600),
      ),
      subtitle: Text(
        '3 soal • pakai kata dari topik ini',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: TileKit.art(AppAssets.arrowRight, 24),
    );
  }

  Widget _footer() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: TileKit.art(AppAssets.bulb, 22),
      title: Text(
        'Tips: ucapkan kata bahasa Inggrisnya dengan lantang.',
        maxLines: 2,
        style: AppType.style(size: 10.5, color: AppColors.inkSoft),
      ),
    );
  }
}
