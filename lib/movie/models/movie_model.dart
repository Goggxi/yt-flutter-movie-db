class MovieResponseModel {
  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  factory MovieResponseModel.fromMap(Map<String, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class MovieModel {
  MovieModel({
    this.backdropPath,
    required this.id,
    required this.overview,
    this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final int id;
  final String overview;
  final String? posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
