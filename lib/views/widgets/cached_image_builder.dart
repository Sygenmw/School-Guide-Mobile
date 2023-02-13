import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
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
      placeholder: placeholder,
      placeholderFadeInDuration: Duration(seconds: 0),
    );
  }
}

Widget placeholder(BuildContext context, String url) {
  return Shimmer.fromColors(
      child: Container(
        width: double.maxFinite,
        color: AppColors.grey,
        child: Text(
          '',
          textAlign: TextAlign.left,
        ),
      ),
      enabled: true,
      loop: 5,
      period: Duration(seconds: 2),
      baseColor: AppColors.grey,
      highlightColor: AppColors.greyish);
}
