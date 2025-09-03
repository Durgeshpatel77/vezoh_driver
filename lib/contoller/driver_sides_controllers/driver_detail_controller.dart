import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverDetailController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final codeController = TextEditingController(); // Only needed for other flows
  final codeFocusNode = FocusNode();              // Only needed for other flows
  final scrollController = ScrollController();

  // Observables (for other flows like code verification)
  var code = ''.obs;

  // Validation logic for the code
  bool get isCodeValid => code.value.length == 6;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    codeController.dispose();
    codeFocusNode.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
