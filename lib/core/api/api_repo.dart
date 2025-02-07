import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ybt_user/src/models/m_bus_line_model.dart';

import '../../config/constants/app_enums.dart';
import '../../config/constants/app_functions.dart';
import '../../src/controllers/app_data_controller.dart';
import '../../src/models/m_bus_stop_model.dart';
import '../../src/models/m_bus_vehicle_model.dart';
import 'api_end_points.dart';
import 'api_request_model.dart';
import 'api_service.dart';

class ApiRepoController extends GetxController {
  Future<List<BusVehicleModel>> getActiveBuses() async {
    List<BusVehicleModel> result = [];
    final apiResult = await ApiServiceController().makeARequest(
        apiRequestData: ApiRequestModel(
          enumApiRequestMethods: EnumApiRequestMethods.get,
          url: ApiEndPoints.getAllActiveBuses,
        ),
        xNeedToken: true);
    if (apiResult.xSuccess) {
      Iterable rawData = apiResult.bodyData["data"] ?? [];
      result = rawData.map((e) => BusVehicleModel.fromJson(json: e)).toList();
    }
    try {} catch (e) {
      superPrint(e, title: "API get active buses");
    }
    return result;
  }

  Future<void> updateAllBusStops() async {
    AppDataController appDataController = Get.find();
    appDataController.allBusStops.clear();
    try {
      final apiResult = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
            enumApiRequestMethods: EnumApiRequestMethods.get,
            url: ApiEndPoints.getAllBusStops,
          ),
          xNeedToken: false);
      if (apiResult.xSuccess) {
        Iterable rawData = apiResult.bodyData["data"] ?? [];
        appDataController.allBusStops =
            rawData.map((e) => BusStopModel.fromMap(data: e)).toList();
        appDataController.update();
      }
    } catch (e) {
      superPrint(e, title: "API update all bus stops");
    }
  }

  Future<void> updateAllBusLines() async {
    AppDataController appDataController = Get.find();
    appDataController.allBusLines.clear();
    try {
      final apiResult = await ApiServiceController().makeARequest(
          apiRequestData: ApiRequestModel(
            enumApiRequestMethods: EnumApiRequestMethods.get,
            url: ApiEndPoints.getAllBusLines,
          ),
          xNeedToken: false);
      if (apiResult.xSuccess) {
        Iterable rawData = apiResult.bodyData["data"] ?? [];
        appDataController.allBusLines =
            rawData.map((e) => BusLineModel.fromMap(data: e)).toList();
        appDataController.update();
      }
    } catch (e) {
      superPrint(e, title: "API update all buses lines");
    }
  }
}
