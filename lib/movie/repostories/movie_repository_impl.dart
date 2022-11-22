import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_detail_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_model.dart';
import 'package:yt_flutter_movie_db/movie/models/movie_video_model.dart';
import 'package:yt_flutter_movie_db/movie/repostories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get discover movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get discover movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get top rated movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get top rated movies');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get now playing movies');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get movie detail');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie detail');
    }
  }

  @override
  Future<Either<String, MovieVideosModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideosModel.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get movie videos');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie videos');
    }
  }
}
