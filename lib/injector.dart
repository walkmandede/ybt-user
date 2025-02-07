import 'package:get/get.dart';
import 'core/api/api_repo.dart';
import 'core/api/api_service.dart';
import 'src/controllers/app_data_controller.dart';

class MyInjector {
  Future<void> initDependencies() async {
    Get.put(AppDataController());
    Get.put(ApiServiceController());
    Get.put(ApiRepoController());
  }
}
