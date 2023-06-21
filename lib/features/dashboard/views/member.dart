import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/dashboard/views/downloaded_videos.dart';
import 'package:urge/features/dashboard/views/registered_events.dart';

import 'donation_form.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
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
                    Get.to(() => const Donation());
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
