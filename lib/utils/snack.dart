//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:get/get.dart';
import 'package:toptop/utils/colors.dart';

class SnackNotify {
  static void showSuccess() {}

  static void showError(title, message) {
    Get.snackbar(
      title,
      message,
      colorText: textErrorColor,
    );
  }
}
