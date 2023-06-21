import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/dashboard/views/donation_form.dart';
import 'package:urge/features/dashboard/views/masterclass.dart';

class Speaker extends StatefulWidget {
  const Speaker({super.key});

  @override
  State<Speaker> createState() => _SpeakerState();
}

class _SpeakerState extends State<Speaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SafeArea(
            child: ListView(
              children: [
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
                    //Get.to(() => const RegisteredEvents());
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
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text(
                                    'MY MASTERCLASS',
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
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 170,
                          decoration: BoxDecoration(
                              color: appBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 200,
                            width: 170,
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
