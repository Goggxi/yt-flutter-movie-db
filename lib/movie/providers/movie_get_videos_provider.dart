import 'package:flutter/material.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_video_model.dart';
import 'package:yt_flutter_movie_db/movie/repostories/movie_repository.dart';

class MovieGetVideosProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetVideosProvider(this._movieRepository);

  MovieVideosModel? _videos;
  MovieVideosModel? get videos => _videos;

  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieRepository.getVideos(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _videos = null;
        notifyListeners();
        return;
      },
      (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}
