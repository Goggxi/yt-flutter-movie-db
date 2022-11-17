import 'package:dartz/dartz.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
}
