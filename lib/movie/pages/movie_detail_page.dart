import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_flutter_movie_db/injector.dart';
import 'package:yt_flutter_movie_db/movie/providers/movie_get_detail_provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<MovieGetDetailProvider>(
              builder: (_, provider, __) {
                if (provider.movie != null) {
                  log(provider.movie.toString());
                }
                return SliverAppBar(
                  title: Text(
                    provider.movie != null ? provider.movie!.title : '',
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
