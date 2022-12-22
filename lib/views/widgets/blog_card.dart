import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/controllers/views_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';

class EduBlogCard extends StatefulWidget {
  const EduBlogCard({Key? key, required this.blog, required this.deviceID}) : super(key: key);
  final EduBlogDetails blog;
  final String deviceID;

  @override
  State<EduBlogCard> createState() => _EduBlogCardState();
}

class _EduBlogCardState extends State<EduBlogCard> {
  ViewsController viewsController = Get.find();
  var count = 0;
  ViewDetails view = ViewDetails(views: 0, id: '');
  getViews() {
    viewsController.allViews.forEach((view) {
      if (view.id == widget.blog.id) {
        count = view.views;
      }
    });
  }

  @override
  void initState() {
    getViews();
    super.initState();
  }

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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((BuildContext context) {
                    return EduBlogItemDetails(
                      eduBlog: widget.blog,
                      blogViews: count,
                      deviceID: widget.deviceID,
                    );
                  }),
                ),
              );
              setState(() {
                count++;
              });
              // increment value in firebase
              var docRef = FirebaseFirestore.instance.collection('blogViews').doc(widget.blog.id);
              docRef.set({"views": count}).then((value) => () {
                    docRef.update({"views": FieldValue.increment(count)});
                  });
            },
            child: SizedBox(
              height: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: widget.blog.postCover,
                        fit: BoxFit.cover,
                        height: 130,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Text(
                                    widget.blog.postTitle.length > 40 ? "${widget.blog.postTitle.substring(0, 40)}..." : widget.blog.postTitle,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 15),
                                  ),
                                ),
                                Text(
                                  widget.blog.postDescription.length > 60 ? "${widget.blog.postDescription.substring(0, 60)}..." : widget.blog.postDescription,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Text(
                              TimeConversion.convertToTimeAgo(widget.blog.createdAt),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
