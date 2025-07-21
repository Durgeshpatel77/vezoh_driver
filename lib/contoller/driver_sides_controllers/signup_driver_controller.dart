import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupDriverController extends GetxController {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();
  final scrollController = ScrollController();

  // Observables
  var code = ''.obs;

  // Validation logic for the code
  bool get isCodeValid => code.value.length == 6;

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
