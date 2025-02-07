import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:ybt_user/config/constants/app_functions.dart';
import 'package:ybt_user/core/api/api_repo.dart';
import 'package:ybt_user/src/controllers/app_data_controller.dart';
import 'package:ybt_user/src/models/m_bus_vehicle_model.dart';

class HomePageController extends GetxController {
  MapController mapController = MapController();
  bool xLoading = false;
  ApiRepoController apiRepoController = Get.find();
  AppDataController appDataController = Get.find();
  List<BusVehicleModel> allActiveBuses = [];
  Timer? timer;
  DateTime lastUpdatedAt = DateTime.now();

  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.onClose();
  }

  Future<void> initLoad() async {
    xLoading = true;
    update();
    await Future.wait([
      apiRepoController.updateAllBusStops(),
      apiRepoController.updateAllBusLines(),
      apiRepoController.getActiveBuses(),
      updateActiveBuses()
    ]);
    xLoading = false;
    update();
    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      updateActiveBuses();
    });
  }

  Future<void> updateActiveBuses() async {
    allActiveBuses.clear();
    allActiveBuses = await apiRepoController.getActiveBuses();
    lastUpdatedAt = DateTime.now();

    update();
  }
}
