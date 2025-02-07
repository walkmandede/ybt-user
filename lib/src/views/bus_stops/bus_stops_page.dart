import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ybt_user/config/constants/app_constants.dart';
import 'package:ybt_user/src/models/m_bus_stop_model.dart';

import '../../controllers/app_data_controller.dart';

class BusStopsPage extends StatefulWidget {
  const BusStopsPage({super.key});

  @override
  State<BusStopsPage> createState() => _BusStopsPageState();
}

class _BusStopsPageState extends State<BusStopsPage> {
  List<BusStopModel> shownData = [];
  TextEditingController txtSearch = TextEditingController(text: "");

  @override
  void initState() {
    initLoad();
    super.initState();
  }

  @override
  void dispose() {
    txtSearch.removeListener(() {});
    super.dispose();
  }

  initLoad() async {
    AppDataController appDataController = Get.find();
    shownData.addAll(appDataController.allBusStops);

    txtSearch.addListener(() {
      final searchQuery = txtSearch.text.replaceAll(" ", "").toLowerCase();

      shownData.clear();
      shownData.addAll(appDataController.allBusStops.where(
        (element) {
          final roadNameEn =
              element.roadNameEn.replaceAll(" ", "").toLowerCase();
          final roadNameMm =
              element.roadNameMm.replaceAll(" ", "").toLowerCase();
          final stopNameEn =
              element.stopNameEn.replaceAll(" ", "").toLowerCase();
          final stopNameMm =
              element.stopNameMm.replaceAll(" ", "").toLowerCase();

          if (roadNameEn.contains(searchQuery) ||
              roadNameMm.contains(searchQuery) ||
              stopNameEn.contains(searchQuery) ||
              stopNameMm.contains(searchQuery)) {
            return true;
          } else {
            return false;
          }
        },
      ));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Stops"),
        centerTitle: false,
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.basePadding,
                  vertical: AppConstants.basePadding / 2),
              child: TextField(
                controller: txtSearch,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded)),
              ),
            ),
            Expanded(
              child: GetBuilder<AppDataController>(
                builder: (appDataController) {
                  if (shownData.isEmpty) {
                    return const Center(
                      child: Text("No Bus Stops Yet!"),
                    );
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                          bottom: AppConstants.basePadding +
                              Get.mediaQuery.padding.bottom,
                          left: AppConstants.basePadding,
                          right: AppConstants.basePadding),
                      itemCount: shownData.length,
                      itemBuilder: (context, index) {
                        final each = shownData[index];
                        return ListTile(
                          leading: Text(each.serial),
                          title: Text(each.stopNameEn),
                          subtitle: Text(each.roadNameEn),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
