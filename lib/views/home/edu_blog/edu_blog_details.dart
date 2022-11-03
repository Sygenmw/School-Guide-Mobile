import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:flutter_html/flutter_html.dart';

class EduBlogItemDetails extends StatelessWidget {
  const EduBlogItemDetails({Key? key, required this.eduBlog}) : super(key: key);
  final EduBlogDetails eduBlog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Education blog/${eduBlog.postTitle}',
          children: [
            SizedBox(
              height: 170,
              child: CachedNetworkImage(
                imageUrl: eduBlog.postCover,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          eduBlog.postTitle,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Row(
                          children: [
                            const Text(
                              'By: ',
                              style: TextStyle(),
                            ),
                            Text(
                              eduBlog.postAuthor,
                              style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: const [
                                Icon(
                                  Icons.favorite,
                                  size: 17,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '29',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.forum,
                                      size: 17,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '323',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 17,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '21129',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Posted: ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              TimeConversion.convertToTimeAgo(eduBlog.createdAt),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'By: ',
                          style: TextStyle(),
                        ),
                        Text(
                          eduBlog.postAuthor,
                          style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Html(
                      data: eduBlog.postContent,
                      style: {
                        "h3": Style(
                          letterSpacing: 1.2,
                          fontSize: FontSize(30),
                          backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "p": Style(
                          letterSpacing: 1.2,
                          fontSize: FontSize(30),
                        ),
                        "ol": Style(
                          letterSpacing: 1.2,
                          fontSize: FontSize(30),
                        ),
                        "li": Style(
                          letterSpacing: 1.2,
                          fontSize: FontSize(30),
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
