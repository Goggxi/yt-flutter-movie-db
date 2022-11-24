import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/pages/movie_detail_page.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_now_playing_provider.dart';
import 'package:yt_flutter_movie_db/widget/image_widget.dart';

class MovieNowPlayingComponent extends StatefulWidget {
  const MovieNowPlayingComponent({super.key});

  @override
  State<MovieNowPlayingComponent> createState() =>
      _MovieNowPlayingComponentState();
}

class _MovieNowPlayingComponentState extends State<MovieNowPlayingComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Consumer<MovieGetNowPlayingProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12.0)),
              );
            }

            if (provider.movies.isNotEmpty) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final movie = provider.movies[index];

                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black12,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageNetworkWidget(
                              imageSrc: movie.posterPath,
                              height: 200,
                              width: 120,
                              radius: 12.0,
                            ),
                            const SizedBox(width: 8.0),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        '${movie.voteAverage} (${movie.voteCount})',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie.overview,
                                    maxLines: 3,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) {
                                  return MovieDetailPage(id: movie.id);
                                },
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: 8.0,
                ),
                itemCount: provider.movies.length,
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text('Not found now playing movies'),
              ),
            );
          },
        ),
      ),
    );
  }
}
