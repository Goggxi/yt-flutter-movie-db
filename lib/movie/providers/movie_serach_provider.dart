import 'package:flutter/material.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/repostories/movie_repository.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.search(query: query);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }
}
