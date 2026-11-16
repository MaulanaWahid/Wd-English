import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_assets.dart';
import '../data/learning_data.dart';
import '../theme/app_theme.dart';
import '../ui/tile_kit.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.topics,
    this.title = 'Tantangan Kilat',
  });

  final List<LearningTopic> topics;
  final String title;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Random _random = Random();

  late List<_QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  String? _picked;
  bool _answered = false;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  _QuizQuestion get _question => _questions[_index];

  List<_QuizQuestion> _buildQuestions() {
    final List<WordEntry> pool = <WordEntry>[];
    final Set<String> seen = <String>{};

    for (final LearningTopic topic in widget.topics) {
      for (final WordEntry word in topic.words) {
        if (seen.add(word.english)) {
          pool.add(word);
        }
      }
    }

    final List<WordEntry> targets = List<WordEntry>.of(pool)..shuffle(_random);
    final int count = min(3, pool.length);
    final List<_QuizQuestion> questions = <_QuizQuestion>[];

    for (int i = 0; i < count; i++) {
      final WordEntry target = targets[i];
      final List<WordEntry> others =
          pool
              .where((WordEntry word) => word.english != target.english)
              .toList()
            ..shuffle(_random);
      final List<WordEntry> options = <WordEntry>[target, ...others.take(3)]
        ..shuffle(_random);

      questions.add(_QuizQuestion(target: target, options: options));
    }

    return questions;
  }

  void _pick(WordEntry word) {
    if (_answered) {
      return;
    }

    final bool correct = word.english == _question.target.english;
    setState(() {
      _picked = word.english;
      _answered = true;
      if (correct) {
        _score++;
      }
    });

    if (correct) {
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.lightImpact();
    }
  }

  void _next() {
    HapticFeedback.selectionClick();
    setState(() {
      if (_index + 1 >= _questions.length) {
        _finished = true;
        return;
      }
      _index++;
      _picked = null;
      _answered = false;
    });
  }

  void _restart() {
    HapticFeedback.selectionClick();
    setState(() {
      _questions = _buildQuestions();
      _index = 0;
      _score = 0;
      _picked = null;
      _answered = false;
      _finished = false;
    });
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

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, bottom),
        children: _finished
            ? _resultChildren(compact: compact, leading: leading)
            : _questionChildren(compact: compact, leading: leading),
      ),
    );
  }

  List<Widget> _questionChildren({
    required bool compact,
    required double leading,
  }) {
    final _QuizQuestion question = _question;
    final bool correct = _answered && _picked == question.target.english;

    final List<Widget> children = <Widget>[
      _backBar(),
      TileKit.gap(8),
      _header(compact: compact),
      TileKit.gap(14),
      ListTile(
        tileColor: AppColors.lavender,
        shape: TileKit.shape(corners: 26),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: TileKit.art(question.target.asset, compact ? 52 : 60),
        title: Text(
          'Mana yang berarti "${question.target.indonesian}"?',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(
            size: compact ? 17 : 18,
            weight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        subtitle: Text(
          'Pilih jawaban bahasa Inggris yang tepat.',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(size: 11.5, color: AppColors.inkSoft),
        ),
        isThreeLine: true,
      ),
      TileKit.gap(12),
    ];

    for (final WordEntry option in question.options) {
      children.add(
        _optionTile(
          option: option,
          target: question.target,
          compact: compact,
          leading: leading,
        ),
      );
      children.add(TileKit.gap(9));
    }

    if (_answered) {
      children
        ..add(TileKit.gap(3))
        ..add(_feedback(correct: correct, target: question.target))
        ..add(TileKit.gap(9))
        ..add(_nextTile());
    }

    children
      ..add(TileKit.gap(16))
      ..add(_footer());

    return children;
  }

  List<Widget> _resultChildren({
    required bool compact,
    required double leading,
  }) {
    final int total = _questions.length;
    final bool perfect = _score == total;
    final String title;
    final String message;

    if (perfect) {
      title = 'Sempurna!';
      message = 'Semua jawaban tepat. Wd bangga sekali!';
    } else if (_score > 0) {
      title = 'Kerja bagus!';
      message = 'Skor kamu $_score dari $total. Ayo coba lagi!';
    } else {
      title = 'Jangan menyerah!';
      message = 'Skor kamu 0 dari $total. Pelan-pelan saja ya!';
    }

    return <Widget>[
      _backBar(),
      TileKit.gap(8),
      _header(compact: compact, subtitle: 'Tantangan selesai'),
      TileKit.gap(14),
      ListTile(
        tileColor: perfect ? AppColors.butter : AppColors.aqua,
        shape: TileKit.shape(corners: 28),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        leading: TileKit.art(
          perfect ? AppAssets.trophy : AppAssets.medal,
          compact ? 60 : 72,
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(
            size: compact ? 22 : 25,
            weight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        subtitle: Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(size: 12, color: AppColors.inkSoft),
        ),
        isThreeLine: true,
      ),
      TileKit.gap(10),
      ListTile(
        tileColor: AppColors.sky,
        shape: TileKit.shape(corners: 22),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: TileKit.art(AppAssets.party, compact ? 40 : 46),
        title: Text(
          'Kamu menyelesaikan tantangan!',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(
            size: compact ? 14 : 15,
            weight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Makin sering latihan, makin jago bahasa Inggris.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppType.style(size: 11.5, color: AppColors.inkSoft),
        ),
        isThreeLine: true,
      ),
      TileKit.gap(16),
      _actionTile(
        onTap: _restart,
        color: AppColors.coral,
        titleColor: AppColors.white,
        subtitleColor: AppColors.cream,
        icon: AppAssets.sparkle,
        title: 'Main lagi',
        subtitle: 'Soal baru menantimu!',
      ),
      TileKit.gap(9),
      _actionTile(
        onTap: () =>
            Navigator.of(context)
                .popUntil((Route<dynamic> route) => route.isFirst),
        color: AppColors.white,
        titleColor: AppColors.ink,
        subtitleColor: AppColors.inkSoft,
        icon: AppAssets.fox,
        title: 'Kembali ke beranda',
        subtitle: 'Sampai jumpa di petualangan berikutnya!',
      ),
      TileKit.gap(16),
      _footer(),
    ];
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

  Widget _header({required bool compact, String? subtitle}) {
    return ListTile(
      tileColor: AppColors.lavender,
      shape: TileKit.shape(corners: 24),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: TileKit.art(AppAssets.trophy, compact ? 42 : 48),
      title: Text(
        widget.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 18 : 19, weight: FontWeight.w700),
      ),
      subtitle: Text(
        subtitle ?? 'Soal ${_index + 1} dari ${_questions.length}',
        style: AppType.style(size: 11.5, color: AppColors.inkSoft),
      ),
      trailing: Text(
        '$_score/${_questions.length}',
        style: AppType.style(size: compact ? 13 : 14, weight: FontWeight.w600),
      ),
    );
  }

  Widget _optionTile({
    required WordEntry option,
    required WordEntry target,
    required bool compact,
    required double leading,
  }) {
    final bool isTarget = option.english == target.english;
    final bool isPicked = _picked == option.english;

    final Color color;
    if (_answered && isTarget) {
      color = AppColors.mint;
    } else if (_answered && isPicked) {
      color = AppColors.rose;
    } else {
      color = AppColors.white;
    }

    final String trailing;
    if (_answered && isTarget) {
      trailing = AppAssets.check;
    } else if (_answered && isPicked) {
      trailing = AppAssets.cross;
    } else {
      trailing = AppAssets.arrowRight;
    }

    return ListTile(
      key: ValueKey<String>('quiz-option-${option.english}'),
      onTap: _answered ? null : () => _pick(option),
      tileColor: color,
      shape: TileKit.shape(corners: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      leading: TileKit.art(option.asset, compact ? 42 : 48),
      title: Text(
        option.english,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: compact ? 16 : 17, weight: FontWeight.w600),
      ),
      subtitle: _answered
          ? Text(
              option.indonesian,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppType.style(size: 11, color: AppColors.inkSoft),
            )
          : null,
      trailing: TileKit.art(trailing, 22),
    );
  }

  Widget _feedback({required bool correct, required WordEntry target}) {
    return ListTile(
      tileColor: correct ? AppColors.mint : AppColors.rose,
      shape: TileKit.shape(corners: 22),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      leading: TileKit.art(correct ? AppAssets.check : AppAssets.cross, 38),
      title: Text(
        correct ? 'Hebat!' : 'Belum tepat',
        style: AppType.style(size: 17, weight: FontWeight.w700),
      ),
      subtitle: Text(
        correct
            ? '"${target.english}" memang ${target.indonesian}.'
            : '"${target.english}" artinya ${target.indonesian}.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 12, color: AppColors.inkSoft),
      ),
      isThreeLine: true,
    );
  }

  Widget _nextTile() {
    final bool last = _index + 1 >= _questions.length;

    return ListTile(
      onTap: _next,
      tileColor: last ? AppColors.coral : AppColors.white,
      shape: TileKit.shape(
        corners: 22,
        borderColor: last
            ? AppColors.coral
            : AppColors.coral.withValues(alpha: 0.35),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: TileKit.art(AppAssets.star, 30),
      title: Text(
        last ? 'Lihat hasil' : 'Soal berikutnya',
        style: AppType.style(
          size: 16,
          weight: FontWeight.w600,
          color: last ? AppColors.white : AppColors.coral,
        ),
      ),
      subtitle: Text(
        last ? 'Satu langkah lagi!' : 'Ayo lanjut!',
        style: AppType.style(
          size: 11,
          color: last ? AppColors.cream : AppColors.inkSoft,
        ),
      ),
      trailing: TileKit.art(AppAssets.arrowRight, 24),
    );
  }

  Widget _actionTile({
    required VoidCallback onTap,
    required Color color,
    required Color titleColor,
    required Color subtitleColor,
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      onTap: onTap,
      tileColor: color,
      shape: TileKit.shape(corners: 22),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: TileKit.art(icon, 38),
      title: Text(
        title,
        style: AppType.style(
          size: 16,
          weight: FontWeight.w600,
          color: titleColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppType.style(size: 11, color: subtitleColor),
      ),
      trailing: TileKit.art(AppAssets.arrowRight, 22),
    );
  }

  Widget _footer() {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: TileKit.art(AppAssets.bulb, 22),
      title: Text(
        'Baca pertanyaan dengan teliti, lalu pilih satu jawaban.',
        maxLines: 2,
        style: AppType.style(size: 10.5, color: AppColors.inkSoft),
      ),
    );
  }
}

class _QuizQuestion {
  const _QuizQuestion({required this.target, required this.options});

  final WordEntry target;
  final List<WordEntry> options;
}
