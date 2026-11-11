import 'package:flutter/material.dart';
import 'package:the_movies_app/movie/data/domain/movie.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({super.key, required this.movie});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isAdded = false;
  bool isDownloaded = false;
  bool showMore = false;
  int selectedIndex = 0;

  static const Color bg = Color(0xFF1E1E1E);
  static const Color grey = Color(0xFF858585);
  static const Color pink = Color(0xFFFF3F73);
  static const Color purple = Color(0xFF8545F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: heroSection()),
            SliverToBoxAdapter(child: movieInfo()),
            SliverToBoxAdapter(child: watchButton()),
            SliverToBoxAdapter(child: actionButtons()),
            SliverToBoxAdapter(child: movieDescription()),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(),
    );
  }

  // HERO IMAGE
  Widget heroSection() {
    return SizedBox(
      height: 315,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            widget.movie.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFF164448),
              child: const Icon(Icons.movie, size: 60, color: Colors.white),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.transparent,
                  bg.withOpacity(0.3),
                ],
              ),
            ),
          ),

          Positioned(
            top: 12,
            right: 16,
            child: circleButton(Icons.close, () => Navigator.maybePop(context)),
          ),

          Positioned(
            bottom: 15,
            right: 16,
            child: circleButton(Icons.play_arrow_rounded, () {}),
          ),
        ],
      ),
    );
  }

  Widget circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.13),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 27),
      ),
    );
  }

  // MOVIE INFORMATION
  Widget movieInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 25),

          Text(
            widget.movie.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 7,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [pink, purple]),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Text(
                  '★ ${widget.movie.rating}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 9,
            children: [
              Text(widget.movie.year, style: const TextStyle(color: grey)),
              const Text('•', style: TextStyle(color: grey)),
              Text(widget.movie.ageRating, style: const TextStyle(color: grey)),
              const Text('•', style: TextStyle(color: grey)),
              Text(widget.movie.duration, style: const TextStyle(color: grey)),
              const Text('•', style: TextStyle(color: grey)),
              Text(widget.movie.genre, style: const TextStyle(color: grey)),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // WATCH NOW BUTTON
  Widget watchButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 72,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [pink, Color(0xFFFF3484), purple],
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
              SizedBox(width: 10),
              Text(
                'Watch Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // MY LIST, DOWNLOAD AND SHARE
  Widget actionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          actionItem(
            isAdded ? Icons.check : Icons.add,
            isAdded ? 'Added' : 'My List',
            () {
              setState(() => isAdded = !isAdded);
            },
          ),

          const SizedBox(width: 45),

          actionItem(
            isDownloaded ? Icons.check : Icons.download_outlined,
            isDownloaded ? 'Downloaded' : 'Download',
            () {
              setState(() => isDownloaded = !isDownloaded);
            },
          ),

          const SizedBox(width: 45),

          actionItem(Icons.ios_share, 'Share', () {}),
        ],
      ),
    );
  }

  Widget actionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 62,
            width: 62,
            decoration: const BoxDecoration(
              color: Color(0xFF303030),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 29),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: grey, fontSize: 15)),
        ],
      ),
    );
  }

  // DESCRIPTION
  Widget movieDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.movie.description,
            maxLines: showMore ? null : 5,
            overflow: showMore ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(color: grey, fontSize: 17, height: 1.55),
          ),

          const SizedBox(height: 16),

          GestureDetector(
            onTap: () {
              setState(() => showMore = !showMore);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  showMore ? 'Less' : 'More',
                  style: const TextStyle(color: pink, fontSize: 16),
                ),
                const SizedBox(width: 8),
                Icon(
                  showMore
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: pink,
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION
  Widget bottomNav() {
    final icons = [
      Icons.home_rounded,
      Icons.search,
      Icons.person_add_alt_1_outlined,
      Icons.sensors,
      Icons.account_circle_outlined,
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF202020),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              final active = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: active
                        ? [
                            BoxShadow(
                              color: pink.withOpacity(0.2),
                              blurRadius: 20,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(icons[index], color: Colors.white, size: 30),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
