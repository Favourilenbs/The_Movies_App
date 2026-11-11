class Movie {
  final String title;
  final String image;
  final String year;
  final String rating;
  final String genre;
  final String duration;
  final String description;
  final String ageRating;

  const Movie({
    required this.title,
    required this.image,
    required this.year,
    required this.rating,
    required this.genre,
    required this.duration,
    required this.description,
    this.ageRating = 'U/A 16+',
  });
}

const List<Movie> featuredMovies = [
  Movie(
    title: 'PUSHPA 2',
    image:
        'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=1000',
    year: '2024',
    rating: '8.5',
    genre: 'Romance • Drama',
    duration: '2h 18m',
    description: 'The Rule continues.',
  ),
  Movie(
    title: 'THE DARK KNIGHT',
    image:
        'https://images.unsplash.com/photo-1519608487953-e999c86e7455?w=1000',
    year: '2025',
    rating: '9.0',
    genre: 'Action • Thriller',
    duration: '2h 32m',
    description: 'A city on the edge of darkness.',
  ),
  Movie(
    title: 'THE LAST KINGDOM',
    image:
        'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=1000',
    year: '2025',
    rating: '8.2',
    genre: 'Adventure • Drama',
    duration: '2h 10m',
    description: 'A kingdom worth fighting for.',
  ),
];

const List<Movie> bollywoodMovies = [
  Movie(
    title: 'Midnight Pines',
    image: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=600',
    year: '2025',
    rating: '8.4',
    genre: 'Thriller',
    duration: '2h 5m',
    description: 'A mystery unfolds.',
  ),
  Movie(
    title: 'Last Light',
    image: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=600',
    year: '2025',
    rating: '8.8',
    genre: 'Action',
    duration: '48m left',
    description: 'The final mission.',
  ),
  Movie(
    title: 'Fog Line',
    image: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=600',
    year: '2025',
    rating: '7.9',
    genre: 'Drama',
    duration: '1h 45m',
    description: 'Beyond the horizon.',
  ),
  Movie(
    title: 'The Journey',
    image: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=600',
    year: '2025',
    rating: '8.1',
    genre: 'Adventure',
    duration: '2h 15m',
    description: 'An unforgettable journey.',
  ),
];
