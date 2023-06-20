import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';



class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      Text('Search',
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
                height: 20,
              )
            ],
          ),
        ),
      ),

    );
  }
}