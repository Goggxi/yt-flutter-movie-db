class MovieDetailModel {
  MovieDetailModel({
    required this.adult,
    this.backdropPath = '',
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.overview,
    required this.popularity,
    this.posterPath = '',
    required this.releaseDate,
    required this.revenue,
    required this.status,
    required this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final int revenue;
  final String status;
  final String tagline;
  final String title;
  final double voteAverage;
  final int voteCount;

  factory MovieDetailModel.fromMap(Map<String, dynamic> json) =>
      MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  @override
  String toString() {
    return 'MovieDetailModel(adult: $adult, backdropPath: $backdropPath, budget: $budget, genres: $genres, homepage: $homepage, id: $id, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, revenue: $revenue, status: $status, tagline: $tagline, title: $title, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  @override
  String toString() => 'Genre(id: $id, name: $name)';
}
