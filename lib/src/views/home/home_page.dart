import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_user/src/views/home/c_home_page_controller.dart';
import 'package:ybt_user/src/views/home/widgets/home_drawer.dart';

import '../../../config/constants/app_functions.dart';
import '../../../config/constants/app_svgs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController homePageController;

  @override
  void initState() {
    homePageController = Get.put(HomePageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<HomePageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<HomePageController>(
          builder: (controller) {
            return Text(
                "Upated at - ${controller.lastUpdatedAt.toString().substring(0, 19)}");
          },
        ),
        centerTitle: false,
      ),
      endDrawer: const HomeDrawer(),
      body: SizedBox.expand(
        child: GetBuilder<HomePageController>(
          builder: (homePageController) {
            if (homePageController.xLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Stack(
                children: [
                  FlutterMap(
                    mapController: homePageController.mapController,
                    options: const MapOptions(
                        initialZoom: 12,
                        interactionOptions: InteractionOptions(
                            enableMultiFingerGestureRace: true),
                        initialCenter:
                            LatLng(16.775545012652657, 96.1670323640905)),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.kphkph.ybtadmin',
                      ),
                      MarkerClusterLayerWidget(
                        options: MarkerClusterLayerOptions(
                          maxClusterRadius: 45,
                          size: const Size(100, 40),
                          markers: homePageController
                              .appDataController.allBusStops
                              .where((eachStop) {
                            return true;
                          }).map((eachStop) {
                            return Marker(
                                width: Get.width * 0.3,
                                height: Get.width * 0.15,
                                point: eachStop.location,
                                child: InkWell(
                                  onTap: () {},
                                  child: Card(
                                    elevation: 0,
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.8),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(Get.width * 0.015),
                                      child: FittedBox(
                                        child: Text(
                                          eachStop.stopNameEn,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          }).toList(),
                          polygonOptions: PolygonOptions(
                            borderColor: Theme.of(context).primaryColor,
                            color:
                                Theme.of(context).primaryColor.withAlpha(100),
                            borderStrokeWidth: 2,
                          ),
                          builder: (context, markers) {
                            return Card(
                              shape: const CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: FittedBox(
                                  child: Text(
                                    markers.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      MarkerLayer(markers: [
                        ...homePageController.allActiveBuses.map((each) {
                          return Marker(
                            alignment: Alignment.center,
                            width: Get.width * 0.15,
                            height: Get.width * 0.15,
                            point: AppFunctions.convertStringToLatLng2Instance(
                                latLngString: each.location),
                            child: SvgPicture.string(AppSvgs.busPinIcon),
                          );
                        })
                      ])
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
