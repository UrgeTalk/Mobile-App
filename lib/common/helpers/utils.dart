import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';


void showSnackBar({ required String content, String? title}) {
  Get.showSnackbar(
        GetSnackBar(
          title: title ?? 'Error',
          message: content,
          duration: const Duration(seconds: 3),
          backgroundColor: appBackgroundColor,
        ),
      );
}