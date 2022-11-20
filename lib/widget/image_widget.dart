import 'package:flutter/material.dart';
import 'package:yt_flutter_movie_db/app_constants.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({
    super.key,
    this.imageSrc,
    required this.height,
    required this.width,
    this.radius = 0.0,
  });

  final String? imageSrc;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        '${AppConstants.imageUrlW500}$imageSrc',
        height: height,
        width: width,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          return Container(
            height: height,
            width: width,
            color: Colors.black26,
            child: child,
          );
        },
        errorBuilder: (_, __, ___) {
          return SizedBox(
            height: height,
            width: width,
            child: const Icon(
              Icons.broken_image_rounded,
            ),
          );
        },
      ),
    );
  }
}
