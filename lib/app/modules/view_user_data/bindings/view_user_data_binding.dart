import 'package:get/get.dart';

import '../controllers/view_user_data_controller.dart';

class ViewUserDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewUserDataController>(
      () => ViewUserDataController(),
    );
  }
}
