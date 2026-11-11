import 'package:flutter/material.dart';
import 'package:the_movies_app/movie/data/domain/movie.dart';
import 'package:the_movies_app/movie/presentation/views/widgets/bottomsheet_nav.dart';
import 'package:the_movies_app/movie/presentation/views/widgets/featured_card.dart';
import 'package:the_movies_app/movie/presentation/views/widgets/moviecard.dart';
import 'package:the_movies_app/movie/presentation/views/details_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final Set<String> favourites = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17171A),
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNavigation(
          selectedIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // buildStatusBar(),
              buildSectionHeader('Movies'),
              FeaturedCarousel(
                movies: featuredMovies,
                favourites: favourites,
                onFavourite: toggleFavourite,
                onWatch: showMovieDetails,
              ),
              const SizedBox(height: 24),
              buildSectionHeader('Popular Movies'),
              SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  itemCount: bollywoodMovies.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final movie = bollywoodMovies[index];
                    return MovieCard(
                      movie: movie,
                      onTap: () => showMovieDetails(movie),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleFavourite(String title) {
    setState(() {
      if (favourites.contains(title)) {
        favourites.remove(title);
      } else {
        favourites.add(title);
      }
    });
  }

  void showMovieDetails(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => DetailsPage(movie: movie)),
    );
  }

  // Widget buildStatusBar() {
  //   return const Padding(
  //     padding: EdgeInsets.fromLTRB(25, 12, 25, 8),
  //     child: Row(
  //       children: [
  //         Text(
  //           '9:41',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         Spacer(),
  //         Icon(Icons.signal_cellular_alt, size: 17),
  //         SizedBox(width: 7),
  //         Icon(Icons.wifi, size: 17),
  //         SizedBox(width: 7),
  //         Icon(Icons.battery_full, size: 20),
  //       ],
  //     ),
  //   );
  // }

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // _arrowButton(Icons.arrow)
        ],
      ),
    );
  }
}
