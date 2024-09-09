import 'dart:io';

import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

class ImageBuilder extends StatelessWidget {
  const ImageBuilder({Key? key, required this.provider}) : super(key: key);
  final ImageProvider<Object> provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ImageError extends StatelessWidget {
  const ImageError({Key? key, this.path, this.height, this.errorFit}) : super(key: key);
  final String? path;
  final double? height;
  final BoxFit? errorFit;

  static String imagePath = 'assets/images/data_saving/maread_m.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD9D9E2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Image.asset(path ?? imagePath, height: height, fit: errorFit),
      ),
    );
  }
}

class CacheImage extends StatelessWidget {
  const CacheImage(
      {Key? key,
      required this.url,
      this.imageFit = BoxFit.cover,
      this.errorWidget = const ImageError(),
      this.width,
      this.height,
      this.errorHeight,
      this.errorFit})
      : super(key: key);

  final String url;
  final BoxFit imageFit;
  final Widget errorWidget;
  final double? width;
  final double? height;
  final double? errorHeight;
  final BoxFit? errorFit;

  @override
  Widget build(BuildContext context) {
    var futureFile = DefaultCacheManager().getSingleFile(url);
    return Container(
      color: AppTheme.color.shimmerHighlightColor,
      child: FutureBuilder<File>(
        future: futureFile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.file(snapshot.data!,
                width: width, height: height, fit: imageFit, errorBuilder: ((context, error, stackTrace) => errorWidget));
          }

          if (snapshot.hasError) {
            return ImageError(
              height: errorHeight,
              errorFit: errorFit,
            );
          }

          return const ShimmerImage();
        },
      ),
    );
  }
}

class ShimmerImage extends StatelessWidget {
  const ShimmerImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.color.shimmerBaseColor,
      highlightColor: AppTheme.color.shimmerHighlightColor,
      direction: ShimmerDirection.ltr,
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
