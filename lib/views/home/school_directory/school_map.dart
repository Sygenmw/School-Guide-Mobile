import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_guide/controllers/location_controller.dart';
import 'package:school_guide/models/school_model.dart';
import 'package:school_guide/style/app_styles.dart';
import 'package:school_guide/views/widgets/bottom_navbar.dart';
import 'package:school_guide/views/widgets/custom_appbar.dart';

class SchoolMap extends StatefulWidget {
  final SchoolDetails school;

  SchoolMap({super.key, required this.school});

  @override
  State<SchoolMap> createState() => _SchoolMapState();
}

class _SchoolMapState extends State<SchoolMap> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAgBGoIVyXGpkb_HcrECR9ovrRu2DirvoY";
  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  late LatLng startLocation;
  late LatLng endLocation;
  double lat = 0.0;
  double long = 0.0;
  late BitmapDescriptor destIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    startLocation = LatLng(lat, long);

    refreshMarkers(lat, long);
    Timer.periodic(const Duration(seconds: 5), (xxx) {
      getGeoPoint();
      markers.clear();

      refreshMarkers(lat, long);
      getDirections();
      // setCustomMarker();
    });
    super.initState();
  }

  getGeoPoint() {
    var currentLocation = LocationController().determinePosition();
    currentLocation.then((value) => {
          setState(() {
            lat = value.latitude;
            long = value.longitude;

            print('$lat-xxx-$long');
          })
        });
    // print('latitude: $latitude');
  }

  refreshMarkers(double orgLat, double orgLng) {
    setState(() {
      startLocation = LatLng(orgLat, orgLng);
      endLocation = LatLng(widget.school.location.lat, widget.school.location.lng);

      // Fetch new locations from firebase
      markers.add(
        Marker(
          //add start location marker
          markerId: MarkerId(startLocation.toString()),
          position: startLocation, //position of marker

          infoWindow: InfoWindow(
            //popup info
            title: 'Your Location',
            snippet: 'Towards ${widget.school.schoolName}',
          ),
          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        ),
      );

      markers.add(Marker(
        //add distination location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation, //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: widget.school.schoolName,
          snippet: 'Destination',
        ),
        icon: destIcon, //Icon for Marker
      ));

      getDirections();
    });
  }

  setCustomMarker() async {
    //  assetImg
    return BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, AppImages.logo).then((icon) => destIcon = icon);
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(lat, long),
      PointLatLng(widget.school.location.lat, widget.school.location.lng),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {}
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColors.primaryColor,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: lat == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Planning your best route...',
                        style: TextStyle(fontSize: 18, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            : GoogleMap(
                //Map widget from google_maps_flutter package
                zoomControlsEnabled: false, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: startLocation, //initial position
                  zoom: 16.0, //initial zoom level
                ),
                buildingsEnabled: false,
                trafficEnabled: false,

                compassEnabled: true,
                markers: markers, //markers to show on map
                polylines: Set<Polyline>.of(polylines.values), //polylines
                mapType: MapType.normal,

                mapToolbarEnabled: true,
                //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                    mapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 14));
                  });
                },
              ),
        bottomNavigationBar: CustomBottomNavBar());
  }
}
