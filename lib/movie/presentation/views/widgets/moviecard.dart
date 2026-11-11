import 'package:flutter/material.dart';
import 'package:the_movies_app/movie/data/domain/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isNew;
  final VoidCallback? onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.isNew = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 225,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: SizedBox(
                height: 180,
                width: 225,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: const Color(0xFF39303D),
                        child: const Icon(Icons.movie, size: 45),
                      ),
                    ),

                    if (isNew)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFF416C), Color(0xFF963BEE)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFB627), size: 18),
                const SizedBox(width: 5),
                Text(
                  movie.rating,
                  style: const TextStyle(
                    color: Color(0xFF92929E),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 7),
                const Text('•', style: TextStyle(color: Color(0xFF92929E))),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    '${movie.genre} • ${movie.duration}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF92929E),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
