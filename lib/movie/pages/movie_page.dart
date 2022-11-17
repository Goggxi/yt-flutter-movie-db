import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_discover_provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDicover(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie DB'),
      ),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movies.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = provider.movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          }

          return const Center(
            child: Text('Not Found Discover Movies'),
          );
        },
      ),
    );
  }
}
