import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/dashboard/views/event_details.dart';

class RegisteredEvents extends StatefulWidget {
  const RegisteredEvents({super.key});

  @override
  State<RegisteredEvents> createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Events',
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: ListView(
            children: [
              // Row(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       icon: const Icon(Icons.arrow_back),
              //       color: Colors.white,
              //       iconSize: 24,
              //     ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     Text('Registered Events',
              //         style: GoogleFonts.openSans(
              //             color: Colors.white,
              //             fontSize: 20,
              //             fontWeight: FontWeight.w700))
              //   ],
              // ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Past Events',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      pastEvents(),
                      const SizedBox(
                        width: 10,
                      ),
                      pastEvents(),
                      const SizedBox(
                        width: 10,
                      ),
                      pastEvents(),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Upcoming Events',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              upcomingEvents(),
              const SizedBox(
                height: 10,
              ),
              upcomingEvents(),
              const SizedBox(
                height: 10,
              ),
              upcomingEvents(),
              const SizedBox(
                height: 10,
              ),
              upcomingEvents(),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pastEvents() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EventDetails());
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: containerColor),
          height: 250,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/registered_event.png',
                        ),
                        fit: BoxFit.cover)),
                height: 150,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '27 MAY, 2023',
                  style: GoogleFonts.openSans(
                      color: logoColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Urge Talk Conference',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )),
                    BtnElevated(
                      btnWidth: 110,
                      btnHeight: 40,
                      onPressed: () {},
                      child: Text(
                        'INTERESTED',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'VIRTUAL',
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          )),
    );
  }

  Widget upcomingEvents() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: containerColor),
        height: 270,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/registered_event.png',
                      ),
                      fit: BoxFit.cover)),
              height: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'FREE',
                style: GoogleFonts.openSans(
                    color: yellowColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'Urge Talk Conference',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )),
                  BtnElevated(
                    btnWidth: 110,
                    btnHeight: 40,
                    onPressed: () {},
                    child: Text(
                      'REGISTER',
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month),
                        color: Colors.white),
                    const SizedBox(
                      width: 0,
                    ),
                    Text(
                      '27 May, 2023',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.access_time),
                        color: Colors.white),
                    const SizedBox(
                      width: 0,
                    ),
                    Text(
                      '10:00AM',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ))
          ],
        ));
  }
}
