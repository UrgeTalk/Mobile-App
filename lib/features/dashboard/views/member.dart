import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/snack_bar.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/dashboard/controller/dashboard_controller.dart';
import 'package:urge/features/dashboard/views/downloaded_videos.dart';
import 'package:urge/features/dashboard/views/registered_events.dart';
import 'package:get_storage/get_storage.dart';

import 'donation_form.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final DashboardController _dashboardController = Get.put(DashboardController());
  final AuthController _authController = Get.find<AuthController>();
  final membershipStatus = GetStorage();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if(_authController.profileModel.isMember == false){
      return Scaffold(
        backgroundColor: appBackgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/account.png',
                    height: 200, width: 300),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    'You do not have access to this page.\n Subscribe now and become a Member.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: BtnElevated(
                        child: Text(
                          'SUBSCRIBE',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          UrgeSnackBar.launchURL(Get.context!, "http://urgetalks.com/p/subscribe");
                        }))
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: appBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SafeArea(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const RegisteredEvents());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 175,
                      decoration: BoxDecoration(
                          color: logoColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          'REGISTERED EVENTS',
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: navyBlueColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => const Downloads());
                            },
                            child: Container(
                                height: 400,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Image.asset(
                                        'assets/images/play_video.png',
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25),
                                        child: Text(
                                          'DOWNLOADED VIDEOS',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                              color: appBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'URGE\n',
                                      style: TextStyle(
                                          color: logoColor,
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                      children: const <TextSpan>[
                                        TextSpan(
                                            text: 'STORE',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700))
                                      ])),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      UrgeSnackBar.launchURL(Get.context!, "https://swiftpay.accessbankplc.com/@byinks");
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: appBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green, width: 1)),
                      child: Center(
                        child: Text(
                          'DONATE TO BRINKS FOUNDATION',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            )),
      );
    }
  }
}
