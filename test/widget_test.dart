import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movies_app/movie/presentation/views/home.dart';

void main() {
  testWidgets('featured movie opens its details page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    await tester.tapAt(tester.getCenter(find.byType(PageView)));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.text('PUSHPA 2'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('The Rule continues.'),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('The Rule continues.'), findsOneWidget);
  });

  testWidgets('popular movie card opens its details page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    final movieTitle = find.text('Midnight Pines');
    await tester.ensureVisible(movieTitle);
    await tester.tap(movieTitle);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.text('Midnight Pines'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('A mystery unfolds.'),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('A mystery unfolds.'), findsOneWidget);
  });

}
