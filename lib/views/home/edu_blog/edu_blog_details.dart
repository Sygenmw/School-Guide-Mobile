import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_guide/controllers/time_controller.dart';
import 'package:school_guide/models/edu_blog.dart';
import 'package:school_guide/models/likes_model.dart';
import 'package:school_guide/models/views_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';

class EduBlogItemDetails extends StatefulWidget {
  EduBlogItemDetails({Key? key, required this.eduBlog, required this.blogViews, required this.deviceID}) : super(key: key);
  final EduBlogDetails eduBlog;
  final int blogViews;
  final String deviceID;

  @override
  State<EduBlogItemDetails> createState() => _EduBlogItemDetailsState();
}

class _EduBlogItemDetailsState extends State<EduBlogItemDetails> {
  int allViews = 0;
  int allLikes = 0;

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
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.eduBlog.postCover,
                  fit: BoxFit.cover,
                ),
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
                                StreamBuilder<List<LikeDetails>>(
                                  stream: _getLikes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<LikeDetails> likes = snapshot.data!;
                                      int currentLikes = 0;

                                      likes.forEach((like) {
                                        if (like.id == widget.eduBlog.id) {
                                          currentLikes = like.allLikes.length;
                                        }
                                      });

                                      return Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          currentLikes.toString() == 'null' ? allLikes.toString() : '$currentLikes',
                                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        '',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                      ),
                                    );
                                  },
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
                                    StreamBuilder<List<ViewDetails>>(
                                        stream: _getViews(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            var views = snapshot.data!;

                                            views.forEach((view) {
                                              if (view.id == widget.eduBlog.id) {
                                                allViews = view.views;
                                              }
                                            });

                                            return Padding(
                                              padding: EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                '$allViews',
                                                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                              ),
                                            );
                                          }
                                          return Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              '${widget.blogViews}',
                                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                                            ),
                                          );
                                        }),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'By : ',
                          style: TextStyle(),
                        ),
                        Expanded(
                          child: Text(
                            widget.eduBlog.postAuthor,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(widget.eduBlog.postDescription),
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
            Material(
              elevation: 5,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  String link = "https://play.google.com/store/apps/details?id=com.school.guide.malawi&hl=en&gl=US&pli=1";

                  // share blog
                  HapticFeedback.heavyImpact();
                  // print('HELLo');
                  // final response = await http.get(Uri.parse(widget.eduBlog.postCover));
                  // final bytes = response.bodyBytes;
                  // final temp = await getTemporaryDirectory();
                  // final path = '${temp.path}/image.jpg';
                  // XFile(path).saveTo(path);
                  // // path.writeAsBytesSync(bytes);
                  await Share.share(
                    widget.eduBlog.postDescription.length > 300 ? '${widget.eduBlog.postDescription.substring(0, 300)}\n$link...' : widget.eduBlog.postDescription,
                  );
                },
                child: Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.share,
                        color: AppColors.white,
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5,
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  // add like to firebase
                  HapticFeedback.heavyImpact();
                  var docRef = FirebaseFirestore.instance.collection('blogLikes').doc(widget.eduBlog.id);

                  docRef.set({
                    "likes": FieldValue.arrayUnion([
                      {"deviceID": widget.deviceID}
                    ])
                  }, SetOptions(merge: true));
                },
                child: Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.thumbsUp,
                        color: AppColors.white,
                      ),
                    )),
              ),
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar());
  }
}

// to get the reactiveness of the views on this page we use streams
Stream<List<ViewDetails>> _getViews() {
  return FirebaseFirestore.instance.collection('blogViews').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => ViewDetails.fromDocument(doc)).toList());
}

Stream<List<LikeDetails>> _getLikes() {
  return FirebaseFirestore.instance.collection('blogLikes').snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) => LikeDetails.fromDocument(doc)).toList());
}
