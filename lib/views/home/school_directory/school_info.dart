import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:school_guide/controllers/permission_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/home/school_directory/gallery.dart';
import 'package:school_guide/views/home/school_directory/school_map.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/cached_image_builder.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';
import 'package:school_guide/views/widgets/custom_text.dart';
import 'package:school_guide/views/widgets/top_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SchoolInfo extends StatefulWidget {
  const SchoolInfo({Key? key, required this.school}) : super(key: key);
  final SchoolDetails school;

  @override
  State<SchoolInfo> createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  late SchoolDetails school;
  GlobalKey itemKey = GlobalKey();
  GlobalKey item1Key = GlobalKey();
  GlobalKey item2Key = GlobalKey();

  Future schrollToItem(key) async {
    final context = key.currentContext;

    await Scrollable.ensureVisible(context!);
  }

  bool mapAvailable = false;
  bool tenImages = false;
  bool videoAvailable = false;
  getremiumFeatures() {
    school.premiumFeatures.forEach((premiumFeature) {
      if (premiumFeature.feature.toLowerCase() == 'map'.toLowerCase() && DateTime.parse(premiumFeature.endDate).compareTo(DateTime.now()) > 0) {
        setState(() {
          mapAvailable = true;
        });
      }
      if (premiumFeature.feature.toLowerCase() == '10+Images'.toLowerCase() && DateTime.parse(premiumFeature.endDate).compareTo(DateTime.now()) > 0) {
        setState(() {
          tenImages = true;
        });
      }
      if (premiumFeature.feature.toLowerCase() == 'VideoAdvert'.toLowerCase() && DateTime.parse(premiumFeature.endDate).compareTo(DateTime.now()) > 0) {
        setState(() {
          videoAvailable = true;
        });
      }
    });
  }

  // MAP
  final Completer<GoogleMapController> _controller = Completer();
  Iterable markers = [];
  Iterable<String> galleryImages = [];
  @override
  void initState() {
    school = widget.school;
    setState(() {
      galleryImages = school.gallery.reversed;
    });

    getremiumFeatures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // VIDEO DECODING
    final videoId = YoutubePlayer.convertUrlToId(widget.school.header);

    YoutubePlayerController _videoController = YoutubePlayerController(
      initialVideoId: school.header.isEmpty ? "" : videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: false,
        controlsVisibleAtStart: true,
      ),
    );
    // var date = AppConstants.convertToDateTime(gallery.createdAt);
    // var formattedTime = timeago.format(date);

    //
    Set<Marker> markerIDs = {
      Marker(
        markerId: MarkerId(
          widget.school.id,
        ),
        onTap: () {
          // Display User Information
        },
        consumeTapEvents: true,
        position: LatLng(widget.school.location.lat, widget.school.location.lng),
      ),
    };
    final CameraPosition kCustomerPosition = CameraPosition(
      target: LatLng(widget.school.location.lat, widget.school.location.lng),
      zoom: 11.4746,
    );
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
              school.header.isNotEmpty && videoAvailable
                  ? Center(
                      child: ClipRRect(
                        child: Container(
                          height: 250,
                          color: AppColors.grey,
                          width: Get.size.width,
                          child: YoutubePlayer(
                            controller: _videoController,
                            showVideoProgressIndicator: true,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      child: CachedImage(
                        imageUrl: galleryImages.toList()[0],
                        // fit: BoxFit.cover,
                      ),
                    ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 100,
                  width: 80,
                  child: InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse(school.website),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: CachedImage(
                        imageUrl: school.schoolLogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: Get.size.height,
                  child: DraggableScrollableSheet(
                    expand: true,
                    minChildSize: 0.12,
                    maxChildSize: 0.85,
                    initialChildSize: 0.344,

                    // snap: true,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return Card(
                        margin: const EdgeInsets.all(0),
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView(
                            controller: scrollController,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 5,
                                    decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.only(top: 2.0),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        HapticFeedback.vibrate();
                                        schrollToItem(itemKey);
                                        // controller.scrollToIndex(5, preferPosition: AutoScrollPosition.begin);
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
                                        schrollToItem(item1Key);

                                        // controller.scrollToIndex(13, preferPosition: AutoScrollPosition.begin);

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
                                        schrollToItem(item2Key);

                                        // controller.scrollToIndex(16, preferPosition: AutoScrollPosition.begin);
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
                              ),

                              Column(
                                key: itemKey,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(),
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      school.schoolName.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                    ),
                                  )),
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.infoHand,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'School info',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    school.city,
                                    icon: Icons.location_city,
                                    fontSize: 14,
                                  ),
                                  Column(
                                    children: [
                                      CustomText(school.address.length < 40 ? school.address : school.address.substring(0, 40), fontSize: 14, icon: Icons.maps_home_work),
                                    ],
                                  ),
                                  CustomText(school.country, fontSize: 14, icon: Icons.map),
                                  school.levelOfStudy == 'Tertiary'
                                      ? const CustomText('Courses offered', needsIcon: false, color: AppColors.primaryColor)
                                      : const CustomText('Curricula offered', needsIcon: false, textAlign: TextAlign.left, color: AppColors.primaryColor),
                                  SizedBox(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 26.0),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: school.curriculums.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 4.0,
                                                top: 4.0,
                                                bottom: 4.0,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                                  child: Center(
                                                    child: Text(
                                                      school.curriculums[index].name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                  const Divider(),
                                ],
                              ),
                              //  end of first
                              Column(
                                key: item1Key,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  school.gallery.isEmpty
                                      ? Container()
                                      : Row(
                                          children: [
                                            Image.asset(
                                              AppImages.gallery,
                                              height: 20,
                                              width: 20,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'Gallery',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                  galleryImages.toList().isEmpty
                                      ? Container()
                                      : Container(
                                          height: 70,
                                          margin: const EdgeInsets.only(top: 2),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)), // Image border
                                          ),
                                          child: CarouselSlider.builder(
                                            itemCount: tenImages
                                                ? galleryImages.toList().length
                                                : galleryImages.toList().length < 3
                                                    ? galleryImages.toList().length
                                                    : galleryImages.toList().sublist(0, 3).length,
                                            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                                              return Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => DisplayGallery(
                                                          school: school,
                                                          pageIndex: index,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: 120,
                                                    height: 60,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: galleryImages.toList()[index],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            options: CarouselOptions(
                                              height: 128,
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 0.3,
                                              initialPage: 0,
                                              enableInfiniteScroll: school.gallery.length < 3 ? false : true,
                                              autoPlay: school.gallery.length < 3 ? false : true,
                                              autoPlayInterval: const Duration(seconds: 3),
                                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                              autoPlayCurve: Curves.fastOutSlowIn,
                                              enlargeCenterPage: false,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                          ),
                                        ),
                                  const Divider(),
                                ],
                              ),
                              // end of second
                              Column(
                                key: item2Key,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        AppImages.contactUs,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'About Us',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      String subject = 'INQUIRY';
                                      String body = 'Hello, ${school.schoolName}, I wanted ...';
                                      String query = 'mailto:${school.email}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
                                      launchUrl(Uri.parse(query));
                                      // launchUrl(Uri.parse(school.email), mode: LaunchMode.externalApplication);
                                    },
                                    child: CustomText(school.email, fontSize: 14, icon: Icons.email),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse('tel:${school.phone}'), mode: LaunchMode.externalApplication);
                                    },
                                    child: CustomText(school.phone, fontSize: 14, icon: Icons.phone_android),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.selectionClick();
                                      launchUrl(Uri.parse(school.website), mode: LaunchMode.externalApplication);
                                    },
                                    child: FittedBox(child: CustomText(school.website, color: AppColors.primaryColor, fontSize: 14, icon: Icons.circle)),
                                  ),
                                  // premium

                                  mapAvailable
                                      ? Column(
                                          children: [
                                            Container(
                                              height: 120,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                clipBehavior: Clip.antiAlias,
                                                borderRadius: BorderRadius.circular(8),
                                                child: GoogleMap(
                                                  mapType: MapType.terrain,
                                                  initialCameraPosition: kCustomerPosition,
                                                  markers: markerIDs,
                                                  zoomControlsEnabled: false,
                                                  onMapCreated: (GoogleMapController controller) {
                                                    _controller.complete(controller);
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                    TopBlackText(text: widget.school.city),
                                                    TopBlackText(text: '${widget.school.location.lat.toString().substring(0, 5)}, ${widget.school.location.lng.toString().substring(0, 5)}'),
                                                  ]),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Tooltip(
                                                    message: 'Go to ${widget.school.schoolName}',
                                                    preferBelow: false,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        PermissionHandler.askLocationPermission();
                                                        Get.to(() => SchoolMap(school: widget.school));
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons.diamondTurnRight,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              )

                              //  end of third
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar());
  }
}
