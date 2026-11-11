import 'package:flutter/material.dart';
import 'package:the_movies_app/movie/data/domain/movie.dart';

class FeaturedCarousel extends StatefulWidget {
  final List<Movie> movies;
  final Set<String> favourites;
  final Function(String) onFavourite;
  final Function(Movie) onWatch;

  const FeaturedCarousel({
    super.key,
    required this.movies,
    required this.favourites,
    required this.onFavourite,
    required this.onWatch,
  });

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    controller = PageController(viewportFraction: 0.64);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 470,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(parent: PageScrollPhysics()),
              clipBehavior: Clip.none,
              itemCount: widget.movies.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: controller,
                  child: _buildCard(widget.movies[index]),
                  builder: (context, child) {
                    final page = controller.hasClients
                        ? controller.page ?? currentPage.toDouble()
                        : currentPage.toDouble();
                    final difference = (page - index).abs();
                    final scale = (1 - difference * 0.16).clamp(0.82, 1.0);

                    return Transform.translate(
                      offset: Offset((page - index) * 22, difference * 10),
                      child: Transform.scale(scale: scale, child: child),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.movies.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentPage == index ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? const Color(0xFFFF416C)
                      : Colors.white38,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCard(Movie movie) {
    final isFavourite = widget.favourites.contains(movie.title);

    return GestureDetector(
      onTap: () => widget.onWatch(movie),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              movie.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF39303D),
                child: const Icon(Icons.movie, size: 60),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.95),
                  ],
                  stops: const [0.25, 0.50, 1],
                ),
              ),
            ),

            Positioned(top: 18, right: 18, child: _hdBadge()),

            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 250;
                  final veryCompact = constraints.maxWidth < 185;
                  final actionSize = compact ? 40.0 : 55.0;
                  final actionSpacing = compact ? 6.0 : 10.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 65,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              movie.title,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              movie.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 9,
                        runSpacing: 5,
                        children: [
                          _info(movie.year),
                          _info(movie.ageRating),
                          _info(movie.duration),
                          _info(movie.genre),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => widget.onWatch(movie),
                              child: Container(
                                height: compact ? 44 : 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF416C),
                                      Color(0xFF963BEE),
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      size: compact ? 20 : 27,
                                    ),
                                    SizedBox(width: compact ? 4 : 7),
                                    Flexible(
                                      child: Text(
                                        veryCompact ? 'Watch' : 'Watch Now',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: compact ? 12 : 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: actionSpacing),
                          _actionButton(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            isFavourite ? Colors.pink : Colors.white,
                            () => widget.onFavourite(movie.title),
                            actionSize,
                          ),
                          SizedBox(width: actionSpacing),
                          _actionButton(
                            Icons.remove_red_eye_outlined,
                            Colors.white,
                            () => widget.onWatch(movie),
                            actionSize,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hdBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'HD',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
      ),
    );
  }

  Widget _info(String value) {
    return Text(
      value,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    Color color,
    VoidCallback onTap,
    double size,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Color(0xFF353538),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 25),
      ),
    );
  }
}
