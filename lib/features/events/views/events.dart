import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/events/views/event_details.dart';


class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Events',
                  style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile_pic.png'))
            ],
          ),
        ),
        backgroundColor: appBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SafeArea(
            child: ListView(
              children: [
                Text('See all upcoming events',
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                const SizedBox(
                  height: 20,
                ),
                Text('Featured Events',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      featuredEvents(),
                      const SizedBox(
                        width: 10,
                      ),
                      featuredEvents(),
                      const SizedBox(
                        width: 10,
                      ),
                      featuredEvents(),
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
        ));
  }

    Widget featuredEvents() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EventDetailsPage());
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
