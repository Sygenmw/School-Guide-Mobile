import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const CachedImage({super.key, required this.imageUrl, this.fit = BoxFit.cover});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (context, url) => SizedBox(
        width: 200.0,
        height: 90.0,
        child: Shimmer.fromColors(
          baseColor: Colors.black12,
          highlightColor: Colors.black,
          child: Column(
            children: const [
              SizedBox(
                height: 20,
                width: double.infinity,
                // color: Colors.grey,
              )
            ],
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
