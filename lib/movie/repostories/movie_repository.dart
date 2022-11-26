import 'package:dartz/dartz.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_video_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  Future<Either<String, MovieResponseModel>> search({required String query});
  Future<Either<String, MovieDetailModel>> getDetail({required int id});
  Future<Either<String, MovieVideosModel>> getVideos({required int id});
}
