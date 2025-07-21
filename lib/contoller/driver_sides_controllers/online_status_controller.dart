import 'package:get/get.dart';

import '../../driver_sides_screens/login_scrrens/incoming_requests_screen.dart';

class OnlineStatusController extends GetxController {
  var isOnline = false.obs;

  void toggleOnline(bool value) {
    isOnline.value = value;
    if (value) {
      Get.to(() =>  IncomingRequestsPage());
    }
  }
}
