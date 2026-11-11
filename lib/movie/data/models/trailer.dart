class TrailerModel {
  final String id;
  final String type;
  final String youtubeVideoId;
  final String youtubeChannelId;
  final String youtubeThumbnail;
  final String title;
  final String url;
  final String thumbnail;
  final String language;
  final List<String> categories;
  final DateTime? published;
  final int views;
  final String mainGenre;
  final List<String> genres;
  final TrailerResource? resource;

  TrailerModel({
    required this.id,
    required this.type,
    required this.youtubeVideoId,
    required this.youtubeChannelId,
    required this.youtubeThumbnail,
    required this.title,
    required this.url,
    required this.thumbnail,
    required this.language,
    required this.categories,
    required this.published,
    required this.views,
    required this.mainGenre,
    required this.genres,
    this.resource,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      youtubeVideoId: json['youtube_video_id'] ?? '',
      youtubeChannelId: json['youtube_channel_id'] ?? '',
      youtubeThumbnail: json['youtube_thumbnail'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      language: json['language'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      published: json['published'] != null
          ? DateTime.tryParse(json['published'])
          : null,
      views: (json['views'] as num?)?.toInt() ?? 0,
      mainGenre: json['main_genre'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      resource: json['resource'] != null
          ? TrailerResource.fromJson(
              Map<String, dynamic>.from(json['resource']),
            )
          : null,
    );
  }
}

class TrailerResource {
  final String type;
  final String path;
  final String id;
  final String? imdbId;
  final int? tmdbId;

  const TrailerResource({
    required this.type,
    required this.path,
    required this.id,
    this.imdbId,
    this.tmdbId,
  });

  factory TrailerResource.fromJson(Map<String, dynamic> json) {
    return TrailerResource(
      type: json['type'] as String? ?? '',
      path: json['path'] as String? ?? '',
      id: json['id'] as String? ?? '',
      imdbId: json['imdb_id'] as String?,
      tmdbId: (json['tmdb_id'] as num?)?.toInt(),
    );
  }
}
