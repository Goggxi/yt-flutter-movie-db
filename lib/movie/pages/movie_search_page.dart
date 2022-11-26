import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_serach_provider.dart';
import 'package:yt_flutter_movie_db/widget/image_widget.dart';

import 'movie_detail_page.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (query.isNotEmpty) {
        context.read<MovieSearchProvider>().search(context, query: query);
      }
    });

    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        if (query.isEmpty) {
          return const Center(child: Text("Search Movies"));
        }

        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.movies.isEmpty) {
          return const Center(child: Text("Movies Not Found"));
        }

        if (provider.movies.isNotEmpty) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final movie = provider.movies[index];
              return Stack(
                children: [
                  Row(
                    children: [
                      ImageNetworkWidget(
                        imageSrc: movie.posterPath,
                        height: 120,
                        width: 80,
                        radius: 10,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie.overview,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          close(context, null);
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
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: provider.movies.length,
          );
        }

        return const Center(child: Text("Another Error on search movies"));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
