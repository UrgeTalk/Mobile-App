import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/register.dart';


passwordResetSuccessful() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.3,
          width: width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: logoColor),
                child: Image.asset(
                  'assets/images/check.png',
                  height: 60,
                  width: 60,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Password Reset Successful',
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 20,
              ),
              BtnElevated(
                  btnHeight: 40,
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.to(() => const Login());
                  }),
            ],
          ),
        );
      },
    ),
  ));
}
