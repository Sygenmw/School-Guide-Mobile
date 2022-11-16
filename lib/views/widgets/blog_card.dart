import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/edu_blog/edu_blog_details.dart';

class EduBlogCard extends StatelessWidget {
  const EduBlogCard({Key? key, required this.blog}) : super(key: key);
  final EduBlogDetails blog;

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
                      eduBlog: blog,
                    );
                  }),
                ),
              );
            },
            child: SizedBox(
              height: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: CachedNetworkImage(
                        imageUrl: blog.postCover,
                        fit: BoxFit.cover,
                        height: 130,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                blog.postTitle,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                    fontSize: 15),
                              ),
                            ),
                            Text(
                              blog.postDescription.length > 90
                                  ? "${blog.postDescription.substring(0, 60)}..."
                                  : blog.postDescription,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    TimeConversion.convertToTimeAgo(
                                        blog.createdAt),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                    ),
                                  )),
                            ),
                          ],
                        ),
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
