import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:yt_flutter_movie_db/injector.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_detail_provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_videos_provider.dart';
import 'package:yt_flutter_movie_db/widget/image_widget.dart';
import 'package:yt_flutter_movie_db/widget/item_movie_widget.dart';
import 'package:yt_flutter_movie_db/widget/webview_widget.dart';
import 'package:yt_flutter_movie_db/widget/youtube_player_widget.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetail(context, id: id),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              sl<MovieGetVideosProvider>()..getVideos(context, id: id),
        ),
      ],
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final videos = provider.videos;
                if (videos != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                      title: 'Trailer',
                      padding: 0,
                      body: SizedBox(
                        height: 160,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final vidio = videos.results[index];
                            return Stack(
                              children: [
                                ImageNetworkWidget(
                                  radius: 12,
                                  type: TypeSrcImg.external,
                                  imageSrc: YoutubePlayer.getThumbnail(
                                    videoId: vidio.key,
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          6.0,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 32.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => YoutubePlayerWldget(
                                              youtubeKey: vidio.key,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemCount: videos.results.length,
                        ),
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  const _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => Colors.black;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WebViewWidget(
                            title: movie.title,
                            url: movie.homepage,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.public),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ];

  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 160.0,
              widthPoster: 100.0,
              radius: 0,
            );
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class _Content extends StatelessWidget {
  const _Content(
      {required this.title, required this.body, this.padding = 16.0});

  final String title;
  final Widget body;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: body,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ]);

  @override
  Widget? get child => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: 'Release Date',
                  body: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 32.0,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        movie.releaseDate.toString().split(' ').first,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                _Content(
                  title: 'Genres',
                  body: Wrap(
                    spacing: 6,
                    children: movie.genres
                        .map((genre) => Chip(label: Text(genre.name)))
                        .toList(),
                  ),
                ),
                _Content(title: 'Overview', body: Text(movie.overview)),
                _Content(
                  title: 'Summary',
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    children: [
                      _tableContent(
                        title: "Adult",
                        content: movie.adult ? "Yes" : "No",
                      ),
                      _tableContent(
                        title: "Popularity",
                        content: '${movie.popularity}',
                      ),
                      _tableContent(
                        title: "Status",
                        content: movie.status,
                      ),
                      _tableContent(
                        title: "Budget",
                        content: "${movie.budget}",
                      ),
                      _tableContent(
                        title: "Revenue",
                        content: "${movie.revenue}",
                      ),
                      _tableContent(
                        title: "Tagline",
                        content: movie.tagline,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      );
}
