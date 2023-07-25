import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        backgroundColor: containerColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Image.asset(
                  'assets/images/cancel_icon.png',
                  height: 40,
                  width: 40,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: red, fontWeight: FontWeight.bold)
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              BtnElevated(
                  child: Text(
                    'OKAY',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    if (Get.isDialogOpen!) Get.back();
                  }),
              // ElevatedButton(
              //   onPressed: () {
              //     if (Get.isDialogOpen!) Get.back();
              //   },
              //   child: const Text('Okay'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

}
