import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ybt_user/src/models/m_bus_line_model.dart';
import '../../core/api/api_repo.dart';
import '../models/m_bus_stop_model.dart';
import '../models/m_profile_model.dart';

class AppDataController extends GetxController {
  //variables
  String apiToken = "";
  List<BusStopModel> allBusStops = [];
  List<BusLineModel> allBusLines = [];

  //functions
  BusStopModel? getBusStopModelById({required String id}) {
    for (final each in allBusStops) {
      if (each.id == id) {
        return each;
      }
    }
    return null;
  }
}
