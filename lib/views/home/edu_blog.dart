import 'package:flutter/material.dart';
import 'package:school_guide/views/widgets/blog_card.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/carousel_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_body.dart';

class EducationBlog extends StatelessWidget {
  const EducationBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          backIconAvailable: true,
          isHomeAppBar: true,
        ),
        body: CustomBody(
          text: 'Education Blog',
          children: [
            EduCarousel(),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: blogArticles,
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavBar());
  }
}

List<Widget> blogArticles = [
  const BlogArticleCard(
    articleTitle: 'Digital Library Malawi',
    articleDescription: '15 years of teaching English to hundreds of children in various parts of England, there are four books that have been on the',
    publishedDate: 'June 2 2022',
    image:
        'https://th.bing.com/th/id/R.25b00a1aa2cfce4887b111bb7e26d04c?rik=zCv61fXPZbaisw&riu=http%3a%2f%2ftrafficsafetyguy.com%2fwp-content%2fuploads%2f2016%2f04%2fDigital-Library.jpg&ehk=VdbzJhpL%2bMzr0zvE9c5r%2b8pw4kD8zIyuF8mb9xN09UY%3d&risl=&pid=ImgRaw&r=0',
  ),
  const BlogArticleCard(
    articleTitle: 'African Drone and Data Academy',
    articleDescription: 'The ADDA has once again made a gsiansansa recomendetation to all young entreprenuers in Malawi that. but anyway its none of our business...',
    publishedDate: 'About a week ago',
    image:
        'https://th.bing.com/th/id/R.aeda9ca8ab99fa3638fab930e133fce6?rik=%2fFD3QMVkgyIi%2fA&riu=http%3a%2f%2fwww.adda.com.tw%2ftw%2fimages%2fimages%2fLogo_03.gif&ehk=%2bkMs9Ey0FHgbLDDqMdAvX81nWSkHDn80Fr729qEuCCg%3d&risl=&pid=ImgRaw&r=0',
  ),
];
