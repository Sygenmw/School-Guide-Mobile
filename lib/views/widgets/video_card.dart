import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/controllers/video_views_controller.dart';
import 'package:school_guide/models/video_model.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/videos/video_info.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({Key? key, required this.video}) : super(key: key);
  final VideoDetails video;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  ViewDetails views = ViewDetails(views: 0, id: '');
  final VideoViewsController controllers = Get.find();
  getVideoViews() {
    controllers.allVideoViews.forEach((videoView) {
      if (videoView.id == widget.video.id) {
        views = videoView;
      }
    });
  }

  @override
  void initState() {
    getVideoViews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8),
      child: Container(
        height: 200,
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
              setState(() {
                views.views++;
              });
              var docRef = FirebaseFirestore.instance.collection('videoViews').doc(widget.video.id);
              docRef.set({"views": views.views}).then((value) => () {
                    docRef.update({"views": FieldValue.increment(views.views)});
                  });
              Get.to(() => VideoInformation(video: widget.video));
            },
            child: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 4,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: CachedImage(
                        imageUrl: widget.video.thumbNail,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              widget.video.title.length < 40 ? widget.video.title : '${widget.video.title.substring(0, 40)}...',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  TimeConversion.convertTimeStamp(widget.video.createdAt),
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
