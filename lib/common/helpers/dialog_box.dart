import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/register.dart';
import 'package:urge/features/dashboard/views/dashboard.dart';

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
          height: height * 0.40,
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

passwordChangeSuccessful() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.40,
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
                    'Continue',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.offAll(() => const BottomBar());
                  }),
            ],
          ),
        );
      },
    ),
  ));
}

profileUpdateSuccessful() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.40,
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
              Text('Profile Updated Successfully!',
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
                    'Continue',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.offAll(() => const BottomBar());
                  }),
            ],
          ),
        );
      },
    ),
  ));
}


accountCreatedSuccessful() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.40,
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
              Text('Account has been created!',
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
                    'PROCEED TO LOGIN',
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

becomeMemberDialog() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.30,
          width: width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text('Login to have access to this video',
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: BtnElevated(
                        btnHeight: 40,
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          Get.to(()=> const Login());
                        }),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=> const Register());
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: logoColor, width: 1),
                        ),
                        child: const Center(
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    ),
  ));
}

pendingApplication() {
  return Get.dialog(AlertDialog(
    backgroundColor: containerColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0))),
    content: Builder(
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.25,
          width: width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Speaker Application Status',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(18),
                    border:
                        Border.all(color: const Color(0xFF707070), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(6.0),
                      height: 8, width: 8,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFF7A00)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Pending',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('Check Later',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 10,
              ),
              BtnElevated(
                  btnHeight: 40,
                  btnWidth: 90,
                  child: Text(
                    'OKAY',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.back();
                  }),
            ],
          ),
        );
      },
    ),
  ));
}
