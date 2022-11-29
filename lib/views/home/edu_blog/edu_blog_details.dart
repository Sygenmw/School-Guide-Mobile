import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:flutter_html/flutter_html.dart';

class EduBlogItemDetails extends StatefulWidget {
  EduBlogItemDetails({Key? key, required this.eduBlog, required this.blogViews, required this.deviceID}) : super(key: key);
  final EduBlogDetails eduBlog;
  final int blogViews;
  final String deviceID;

  @override
  State<EduBlogItemDetails> createState() => _EduBlogItemDetailsState();
}

class _EduBlogItemDetailsState extends State<EduBlogItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Education blog/${widget.eduBlog.postTitle}',
          children: [
            SizedBox(
              height: 170,
              child: CachedNetworkImage(
                imageUrl: widget.eduBlog.postCover,
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
                    child: Text(
                      '${widget.eduBlog.postTitle}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
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
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 17,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '0',
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
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 17,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '${widget.blogViews}',
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
                              TimeConversion.convertToTimeAgo(widget.eduBlog.createdAt),
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
                          widget.eduBlog.postAuthor,
                          style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Html(
                      data: widget.eduBlog.postContent,
                      style: {
                        "h3": Style(
                          letterSpacing: 1.2,
                          backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                        ),
                        "p": Style(
                          letterSpacing: 1.2,
                        ),
                        "ol": Style(
                          letterSpacing: 1.2,
                        ),
                        "li": Style(
                          letterSpacing: 1.2,
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
                backgroundColor: AppColors.errorColor,
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.heart,
                    size: 35,
                  ),
                ),
                onPressed: () async {}),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}
