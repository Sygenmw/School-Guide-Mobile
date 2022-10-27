import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';

class SchoolInfo extends StatefulWidget {
  const SchoolInfo({Key? key}) : super(key: key);

  @override
  State<SchoolInfo> createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _showBottomSheet(context);
    // });
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://media.istockphoto.com/photos/teacher-and-schoolkids-during-lesson-picture-id1032479082?k=6&m=1032479082&s=612x612&w=0&h=HPnj3-YFtISHVtPbSKryCI7O5zA4RMGVUYfwpIOjwFA=',
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SizedBox(
                  height: 120,
                  width: 80,
                  child: Image.asset(
                    'assets/images/logo_school.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 150,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.only(top: 2.0),
                          ),
                        ),
                        const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Scroll up for more details',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                        )),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                },
                                child: Image.asset(
                                  AppImages.infoHand,
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  // print('');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.asset(
                                    AppImages.gallery,
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.vibrate();
                                  // print('');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Image.asset(
                                    AppImages.contactUs,
                                    height: 36,
                                    width: 36,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }

  // void _showBottomSheet(
  //   context,
  // ) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     elevation: 0,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) => StatefulBuilder(builder: (context, setState) {
  //       return DraggableScrollableSheet(
  //         expand: true,
  //         minChildSize: 0.18,
  //         maxChildSize: 0.18,
  //         initialChildSize: 0.18,
  //         builder: (BuildContext context, ScrollController scrollController) {
  //           return Card(
  //             // margin: const EdgeInsets.all(0),
  //             color: Colors.white,
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(30),
  //                 topRight: Radius.circular(30),
  //               ),
  //             ),
  //             child: ListView(
  //               controller: scrollController,
  //               children: [
  //                 const Padding(
  //                   padding: EdgeInsets.only(top: 8.0),
  //                   child: Icon(
  //                     Icons.keyboard_arrow_up,
  //                     size: 35,
  //                   ),
  //                 ),
  //                 const Center(
  //                     child: Padding(
  //                   padding: EdgeInsets.all(12.0),
  //                   child: Text('Scroll up for more details'),
  //                 )),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: InkWell(
  //                         splashColor: const Color.fromARGB(255, 255, 211, 225),
  //                         onTap: () {
  //                           print('');
  //                         },
  //                         child: const Padding(
  //                           padding: EdgeInsets.all(18.0),
  //                           child: Icon(Icons.info_outline_rounded),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: InkWell(
  //                         splashColor: const Color.fromARGB(255, 213, 211, 255),
  //                         onTap: () {
  //                           print('');
  //                         },
  //                         child: const Padding(
  //                           padding: EdgeInsets.all(18.0),
  //                           child: Icon(Icons.browse_gallery_outlined),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: InkWell(
  //                         splashColor: const Color.fromARGB(255, 211, 255, 213),
  //                         onTap: () {
  //                           print('');
  //                         },
  //                         child: const Padding(
  //                           padding: EdgeInsets.all(18.0),
  //                           child: Icon(Icons.headphones_outlined),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     }),
  //     context: context,
  //   );
  // }
}
