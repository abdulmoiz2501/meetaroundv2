import 'package:get/get.dart';

import '../controllers/past_interections_controller.dart';

class PastInterectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PastInterectionsController>(
      () => PastInterectionsController(),
    );
  }
}
