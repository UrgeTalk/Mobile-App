import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';


void showSnackBar({ required String content, String? title}) {
  Get.snackbar(
      title ?? 'Message',
      content,
  duration: const Duration(seconds: 3),
  backgroundColor: containerColor,
  colorText: Colors.white,
    snackPosition: SnackPosition.TOP
  );
}
