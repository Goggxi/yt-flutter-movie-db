import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_detail_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_now_playing_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_top_rated_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_videos_provider.dart';
import 'package:yt_flutter_movie_db/movie/repostories/movie_repository.dart';
import 'package:yt_flutter_movie_db/movie/repostories/movie_repository_impl.dart';

import 'app_constants.dart';

final sl = GetIt.instance;

void setup() {
  // Register Provider
  sl.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(sl()),
  );
  sl.registerFactory<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(sl()),
  );
  sl.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(sl()),
  );
  sl.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(sl()),
  );
  sl.registerFactory<MovieGetVideosProvider>(
    () => MovieGetVideosProvider(sl()),
  );

  // Register Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  // Register Http Client (DIO)
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {'api_key': AppConstants.apiKey},
      ),
    ),
  );
}
