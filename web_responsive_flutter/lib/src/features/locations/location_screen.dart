import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import '../../app_configs/app_colors.dart';
import '../../common_widgets/custom_appbar/custom_appBar.dart';
import '../../common_widgets/custom_drawer/custom_drawer.dart';
import '../../utils/responsive.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const LocationMaain();
  }
}

class LocationMaain extends StatefulWidget {
  const LocationMaain({super.key});

  @override
  State<LocationMaain> createState() => _LocationMaainState();
}

class _LocationMaainState extends State<LocationMaain> {
  Completer<GoogleMapController> mController = Completer<GoogleMapController>();

  Set<Marker> marker = {
    Marker(
      markerId: const MarkerId("Marker 1"),
      position: const LatLng(26.2978, 73.0180),
      infoWindow: const InfoWindow(
        title: "Mehrangarh Fort",
        snippet: "Jodhpur",
      ),
    ),
    Marker(
      markerId: const MarkerId("Marker 2"),
      position: const LatLng(27.3978, 73.0180),
    ),
    Marker(
      markerId: const MarkerId("Marker 3"),
      position: const LatLng(26.3978, 74.0180),
    ),
  };

  @override
  void initState() {
    super.initState();
    getCurrentLoc();
  }

  void getCurrentLoc() async {
    if (await checkIfGetCurrLoc()) {
      var currPos = await Geolocator.getCurrentPosition();
      var currPosition = CameraPosition(
        target: LatLng(currPos.latitude, currPos.longitude),
        zoom: 19,
      );
      var mapController = await mController.future;
      mapController.animateCamera(CameraUpdate.newCameraPosition(currPosition));
      print('Lat: ${currPos.latitude}, Lng: ${currPos.longitude}');
    } else {
      print("Location services error: Unable to get your location.");
    }
  }

  Future<bool> checkIfGetCurrLoc() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services disabled!");
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final dashBoardProvider = context.watch<DashBoardController>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "",
        actionImages: [
          AppImages.notification,
          AppImages.appBarProfile,
          AppImages.downArrow,
        ],
        imageUrl: AppImages.heroAppBar,
      ),
      backgroundColor: Colors.white,
      drawer: !isDesktop
          ? SizedBox(
        width: 250,
        child: SideMenuWidget(
          menuItems: dashBoardProvider.menuItems,
          onItemSelected: (index) {
            dashBoardProvider.handleMenuItemSelected(index, context);
          },
        ),
      )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: const Text(""),
      )
          : null,
      body: Column(
        children: [
          const Divider(
            color: AppColors.lightGrey,
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: SafeArea(
              child: Row(
                children: [
                  if (isDesktop)
                    Expanded(
                      flex: 2,
                      child: SideMenuWidget(
                        menuItems: dashBoardProvider.menuItems,
                        onItemSelected: (index) {
                          dashBoardProvider.handleMenuItemSelected(index, context);
                        },
                      ),
                    ),
                  Expanded(
                    flex: 9,
                    child: GoogleMap(
                      onMapCreated: (loadedController) {
                        if (!mController.isCompleted) {
                          mController.complete(loadedController);
                        }
                      },
                      mapType: MapType.satellite,
                      markers: marker,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onTap: (loc) {
                        setState(() {
                          marker.add(Marker(
                            markerId: MarkerId("New_${loc.latitude}_${loc.longitude}"),
                            position: loc,
                          ));
                        });
                      },
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(26.2978, 73.0180),
                        zoom: 19,
                        tilt: 85,
                        bearing: 135,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
