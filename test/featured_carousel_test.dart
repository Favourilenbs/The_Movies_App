import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_movies_app/movie/data/domain/movie.dart';
import 'package:the_movies_app/movie/presentation/views/widgets/featured_card.dart';

void main() {
  testWidgets('featured card fits a narrow screen without pixel overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeaturedCarousel(
            movies: const [
              Movie(
                title: 'A VERY LONG FEATURED MOVIE TITLE',
                image: '',
                year: '2025',
                rating: '8.5',
                genre: 'Action • Adventure • Drama',
                duration: '2h 18m',
                description:
                    'A long description that must stay within the featured card '
                    'without causing any overflow.',
              ),
            ],
            favourites: const {},
            onFavourite: (_) {},
            onWatch: (_) {},
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('swiping advances to the next movie slide', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FeaturedCarousel(
            movies: featuredMovies,
            favourites: const {},
            onFavourite: (_) {},
            onWatch: (_) {},
          ),
        ),
      ),
    );

    List<double?> indicatorWidths() => tester
        .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
        .map((indicator) => indicator.constraints?.maxWidth)
        .toList();

    expect(indicatorWidths().indexOf(20), 0);

    await tester.drag(find.byType(PageView), const Offset(-700, 0));
    await tester.pumpAndSettle();

    expect(indicatorWidths().indexOf(20), 1);
  });
}
