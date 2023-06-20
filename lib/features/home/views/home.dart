import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Hello, Charles!!!',
                          style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/heart_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/profile_pic.png')),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text('View our latest videos on Urge Talk',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              Text('Featured',
                  style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/dummy_image.png'))),
                width: double.infinity,
                height: 180,
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Making effective impact in your Business',
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mike Trapp',
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Image.asset(
                    'assets/images/heart_icon.png',
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  Text('See all',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: logoColor)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended(),
                      const SizedBox(
                        width: 20,
                      ),
                      recommended()
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Latest Videos',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                  Text('See all',
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: logoColor)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                      trending(),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recommended() {
    return SizedBox(
      width: 250,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/dummy_image.png'))),
          height: 180,
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Making effective impact in your Business',
            style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('David Reed',
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            Image.asset(
              'assets/images/heart_icon.png',
              height: 20,
              width: 20,
            ),
          ],
        ),
      ]),
    );
  }

  Widget trending() {
    return SizedBox(
      width: 250,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage('assets/images/trending.png'))),
          height: 180,
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Making effective impact in your Business',
            style: GoogleFonts.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('David Reed',
                style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            Image.asset(
              'assets/images/heart_icon.png',
              height: 20,
              width: 20,
            ),
          ],
        ),
      ]),
    );
  }
}
