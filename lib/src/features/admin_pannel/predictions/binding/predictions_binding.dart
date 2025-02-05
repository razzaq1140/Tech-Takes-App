import 'package:get/get.dart';

import '../controller/predictions_controller.dart';

class PredictionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PredictionsController>(() => PredictionsController());
  }
}
