import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/helpers/snack_bar.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/dashboard/controller/dashboard_controller.dart';
import 'package:urge/features/dashboard/views/donation_form.dart';
import 'package:urge/features/dashboard/views/masterclass.dart';
import 'package:urge/features/dashboard/views/registered_events.dart';
import 'package:get_storage/get_storage.dart';

class Speaker extends StatefulWidget {
  const Speaker({super.key});

  @override
  State<Speaker> createState() => _SpeakerState();
}

class _SpeakerState extends State<Speaker> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    print(_authController.profileModel.isSpeaker);
    //_dashboardController.getApplicationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_authController.profileModel.isSpeaker == false) {
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
                    'You do not have access to this page.\n Subscribe now and become a Speaker.',
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
                  child: Obx(() => BtnElevated(
                      isLoading: _dashboardController.isLoading(false),
                      child: Text(
                        'BECOME A SPEAKER',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        _dashboardController.speakerRequest();
                      })),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    pendingApplication();
                  },
                  child: Text('SPEAKER APPLICATION STATUS',
                      style: TextStyle(
                          color: logoColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),
                )
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
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 110,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: yellowColor),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            'Coming Soon',
                            style: GoogleFonts.openSans(
                                color: navyBlueColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '\$0.00',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const RegisteredEvents());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150,
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
                          Get.to(() => const MasterClass());
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: Text(
                                      'MY MASTERCLASS',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12),
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
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                UrgeSnackBar.launchURL(Get.context!, "https://www.amway.com/en_US/myshop/MAISON-STORE");
                              },
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
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
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/dummy_image.png'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/copy.png',
                                              height: 25,
                                              width: 25,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Image.asset(
                                              'assets/images/share_video.png',
                                              height: 25,
                                              width: 25,
                                            ),
                                          ],
                                        )),
                                    const Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          'Share this Video',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ],
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
                      height: 70,
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
