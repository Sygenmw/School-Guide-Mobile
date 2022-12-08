import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/video_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/videos/video_info.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key, required this.video}) : super(key: key);
  final VideoDetails video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.grey,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              // Video Details
              Get.to(() => VideoInformation(video: video));
            },
            child: SizedBox(
              height: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: video.thumbNail,
                        fit: BoxFit.fitWidth,
                        height: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              video.title.length < 40 ? video.title : '${video.title.substring(0, 40)}...',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  TimeConversion.convertTimeStamp(video.createdAt),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
