import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/edu_blog_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/views/widgets/blog_card.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/carousel_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:school_guide/views/widgets/empty_list.dart';

class EducationBlog extends StatefulWidget {
  const EducationBlog({Key? key}) : super(key: key);

  @override
  State<EducationBlog> createState() => _EducationBlogState();
}

class _EducationBlogState extends State<EducationBlog> {
  final EduBlogController blogController = Get.find();

  final currentBlogs = <EduBlogDetails>[];

  void getAllBlogs() {
    for (var blog in blogController.allBlogPosts) {
      if (blog.publishPost) {
        currentBlogs.add(blog);
      }
    }
  }

  Future<String> getDev() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  }

  String deviceID = '';
  String deviceUniqueID = '';
  @override
  void initState() {
    uuid = DeviceUuid().getUUID();
    uuid.then((id) {
      deviceUniqueID = id!;
    });
    getAllBlogs();
    getDev().then((value) => setState(() {
          deviceID = value;
        }));

    super.initState();
  }

  late Future<String?> uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: currentBlogs.isEmpty
            ? EmptyList(
                text: 'We do not have any blogs now. Come back later.',
              )
            : CustomBody(
                text: 'Education Blog',
                children: [
                  EduCarousel(
                    blogItems: currentBlogs,
                    deviceID: deviceID,
                    addFavourite: () async {
                      // implement adding to favourite
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: currentBlogs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return EduBlogCard(blog: currentBlogs[index], deviceID: deviceUniqueID);
                    },
                  ),
                ],
              ),
        bottomNavigationBar: CustomBottomNavBar());
  }
}
