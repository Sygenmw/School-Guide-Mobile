import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/video_controller.dart';
import 'package:school_guide/models/video_model.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/video_card.dart';
class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final VideoController videoController = Get.find();

  var videos = <VideoDetails>[];
  getVideos() {
    for (var video in videoController.allVideos) {
      videos.add(video);
    }
  }

  @override
  void initState() {
    getVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backIconAvailable: false,
        isHomeAppBar: true,
      ),
      body: CustomBody(text: 'Videos', children: [
        SizedBox(
          height: Get.size.height,
          child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (BuildContext context, int index) {
              return VideoCard(video: videos[index]);
            },
          ),
        ),
      ]),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}


