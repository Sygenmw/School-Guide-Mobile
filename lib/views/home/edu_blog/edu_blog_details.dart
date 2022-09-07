import 'package:flutter/material.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class EduBlogDetails extends StatelessWidget {
  const EduBlogDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Education blog/Digital library Malawi',
          children: [
            SizedBox( 
              height: 170,
              child: Image.network(
                'https://www.gannett-cdn.com/presto/2020/08/24/PGRE/c006a84b-e37a-4c7d-9c6c-d5ca09f52660-BacktoSchool-MB18-08242020.jpg?crop=2999,1687,x0,y152&width=2999&height=1687&format=pjpg&auto=webp',
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
                        const Text(
                          'Digital Library Malawi',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Row(
                          children: const [
                            Text(
                              'By: ',
                              style: TextStyle(),
                            ),
                            Text(
                              'Ahmed Assan',
                              style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.primaryColor),
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
                          children: const [
                            Text(
                              'Posted: ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '22 June 2022',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      '15 years of teaching English to hundreds of children in various parts of England, there are four books that have been on the',
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
