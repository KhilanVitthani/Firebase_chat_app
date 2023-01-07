import 'package:get/get.dart';

import '../controllers/singup_page_controller.dart';

class SingupPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingupPageController>(
      () => SingupPageController(),
    );
  }
}
