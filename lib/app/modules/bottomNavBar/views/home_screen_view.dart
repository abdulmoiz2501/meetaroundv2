import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_location_model.dart';
import 'package:scratch_project/app/modules/SearchScreen/controllers/search_screen_controller.dart';
import 'package:scratch_project/app/modules/bottomNavBar/controllers/location_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../models/user_model2.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/homeHeaderWidget.dart';
import '../../JammingScreen/controllers/jamming_screen_controller.dart';

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  GoogleMapController? _controller;
  final LocationController locationController = Get.put(LocationController());
  final UserController userController = Get.put(UserController());
  late WebSocketChannel channel;

  bool _showLoader = true;

  @override
  void initState() {
    super.initState();

    // Set a delay of 3 seconds to show the loader only the first time
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showLoader = false;
      });
    });

    Get.lazyPut<JammingScreenController>(() => JammingScreenController(userId: userController.user.value.id));

    final SearchScreenController searchScreenController = Get.put(SearchScreenController());
    connectWebSocket();

    locationController.addListener(() {
      final currentPosition = locationController.currentPosition.value;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentPosition, zoom: 15),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    await locationController.goToCurrentLocation();
    final currentPosition = locationController.currentPosition.value;
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition, zoom: 15),
      ),
    );
  }

  List<UserLocationModel> _filterUsersWithinRadius() {
    final currentPosition = locationController.currentPosition.value;
    const radiusInMeters = 300.0;

    final Set<String> seenIds = {}; // Set to track unique user IDs
    return locationController.currentUsers.where((user) {
      if (user.latitude == null || user.longitude == null) {
        return false;
      }

      final userPosition = LatLng(user.latitude!, user.longitude!);
      final distance = _calculateDistance(
        currentPosition.latitude,
        currentPosition.longitude,
        userPosition.latitude,
        userPosition.longitude,
      );

      // Only include users within the radius and not seen before
      final isWithinRadius = distance <= radiusInMeters;
      final isUniqueUser = seenIds.add(user.id.toString()); // Returns false if already in the set

      return isWithinRadius && isUniqueUser;
    }).toList();
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000; // Radius of the Earth in meters
    final dLat = (lat2 - lat1) * (3.141592653589793 / 180);
    final dLon = (lon2 - lon1) * (3.141592653589793 / 180);
    final a =
        0.5 - cos(dLat) / 2 + cos(lat1 * (3.141592653589793 / 180)) * cos(lat2 * (3.141592653589793 / 180)) * (1 - cos(dLon)) / 2;

    return R * 2 * asin(sqrt(a));
  }

  Future<Set<Marker>> _createMarkers() async {
    Set<Marker> markers = {};
    final filteredUsers = _filterUsersWithinRadius();

    for (var user in filteredUsers) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(
          context,
          size: const Size(10.0, 10.0)
      );
      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
          imageConfiguration,
          "assets/icons/markercoin.png"
      );

      markers.add(
        Marker(
          markerId: MarkerId(user.id.toString()),
          position: LatLng(user.latitude ?? 0, user.longitude ?? 0),
          icon: icon,
          infoWindow: InfoWindow(
            title: user.name,
            snippet: user.interests?.join(', '),
          ),
        ),
      );
    }
    return markers;
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void connectWebSocket() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://meet-around-apis-production.up.railway.app/ws/playback'),
    );

    final jammingController = Get.find<JammingScreenController>();
    jammingController.initializeWebSocket(channel);
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _filterUsersWithinRadius();

    return Scaffold(
      body: Container(
        color: VoidColors.whiteColor,
        child: Column(
          children: [
            if (_showLoader)
            // Show shimmer effect while waiting for 3 seconds
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 200.h,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            else
              homeHeaderWidget(
                filteredUsers.map((user) => {
                  'image': user.profilePicture != null && user.profilePicture!.isNotEmpty
                      ? user.profilePicture!
                      : VoidImages.testImg,
                  'name': user.name ?? 'Unknown',
                }).toList() as List<Map<String, String>>,
                100.0,
                    () {
                  Get.toNamed(Routes.SUGGESTED_PEOPLE);
                },
                VoidTexts.suggestPeople,
              ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
                  () => Expanded(
                child: FutureBuilder<Set<Marker>>(
                  future: _createMarkers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      // Shimmer effect while loading the map and markers
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                              height: 200.h,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return GoogleMap(
                      compassEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: locationController.currentPosition.value,
                        zoom: 10,
                      ),
                      myLocationEnabled: true,
                      circles: Set.from([
                        Circle(
                          circleId: CircleId('currentLocation'),
                          center: locationController.currentPosition.value,
                          radius: 300.r, // Set your desired radius
                          fillColor: Colors.black.withOpacity(0.2), // Black color with opacity
                          strokeColor: Colors.black.withOpacity(0.2), // Border color
                          strokeWidth: 0, // Border width
                        ),
                      ]),
                      markers: snapshot.data!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
