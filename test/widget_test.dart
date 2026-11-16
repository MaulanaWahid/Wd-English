import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/data/learning_data.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('maskot bisa diketuk dan sapaan berganti', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WdApp());

    expect(find.text('Wd English'), findsOneWidget);
    expect(find.text('Hello!'), findsOneWidget);

    await tester.tap(find.text('Hello!'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Good day!'), findsOneWidget);
    expect(find.text('Hello!'), findsNothing);
  });

  testWidgets('kata hari ini bisa dibuka', (WidgetTester tester) async {
    await tester.pumpWidget(const WdApp());

    expect(find.text('Ketuk untuk membuka arti rahasia'), findsOneWidget);

    await tester.tap(find.text('Butterfly'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Kupu-kupu'), findsOneWidget);
  });

  testWidgets('topik bisa dibuka dan arti kata muncul', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WdApp());

    await tester.scrollUntilVisible(find.text('Animals'), 200);
    await tester.ensureVisible(find.text('Animals'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Animals'));
    await tester.pumpAndSettle();

    expect(find.text('Kembali'), findsOneWidget);
    expect(find.text('Cat'), findsOneWidget);

    await tester.ensureVisible(find.text('Cat'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cat'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Kucing'), findsOneWidget);
  });

  testWidgets('kuis bisa dijawab dan lanjut ke soal berikutnya', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WdApp());

    await tester.scrollUntilVisible(find.text('Tantangan Kilat'), 250);
    await tester.ensureVisible(find.text('Tantangan Kilat'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tantangan Kilat'));
    await tester.pumpAndSettle();

    expect(find.text('Soal 1 dari 3'), findsOneWidget);

    final Finder question = find.textContaining('Mana yang berarti');
    final Text questionText = tester.widget<Text>(question);
    final String indonesian = RegExp(r'"(.+)"')
        .firstMatch(questionText.data!)!
        .group(1)!;
    final WordEntry target = kAllWords.firstWhere(
      (WordEntry word) => word.indonesian == indonesian,
    );

    final Finder option = find.byKey(
      ValueKey<String>('quiz-option-${target.english}'),
    );
    await tester.scrollUntilVisible(option, 200);
    await tester.ensureVisible(option);
    await tester.pumpAndSettle();
    await tester.tap(option);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Soal berikutnya'), 200);
    await tester.ensureVisible(find.text('Soal berikutnya'));
    await tester.pumpAndSettle();
    expect(find.text('Hebat!'), findsOneWidget);

    await tester.tap(find.text('Soal berikutnya'));
    await tester.pumpAndSettle();

    expect(find.text('Soal 2 dari 3'), findsOneWidget);
  });

  testWidgets('tata letak aman di layar kecil 320px', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WdApp());
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Animals'), 180);
    await tester.ensureVisible(find.text('Animals'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Animals'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Uji topik Hewan'), 220);
    await tester.ensureVisible(find.text('Uji topik Hewan'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Uji topik Hewan'));
    await tester.pumpAndSettle();

    expect(find.text('Soal 1 dari 3'), findsOneWidget);

    final Finder scrollable = find.byType(Scrollable).first;
    for (int i = 0; i < 6; i++) {
      await tester.drag(scrollable, const Offset(0, -320));
      await tester.pumpAndSettle();
    }

    expect(tester.takeException(), isNull);
  });
}
