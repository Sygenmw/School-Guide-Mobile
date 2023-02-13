import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/video_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/videos/video_info.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';

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
              height: 200,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: CachedImage(
                        imageUrl: video.thumbNail,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0, right: 6),
                          child: Text(
                            video.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  Text(
                                    TimeConversion.convertTimeStamp(video.createdAt),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.remove_red_eye,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '9',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primaryColor),
                                  ),
                                ],
                              )),
                        ),
                      ],
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
