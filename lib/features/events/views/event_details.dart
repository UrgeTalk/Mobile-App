import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/events/model/event_model.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key, required this.model});

  final Event model;

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events Details',
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
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(model.cover!),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    capitalizeFirstLetter(model.type!),
                    style: GoogleFonts.openSans(
                        color: yellowColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        model.name!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                      BtnElevated(
                        btnWidth: 110,
                        btnHeight: 40,
                        onPressed: () {
                          // Get.to(() => const Ticket());
                        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.calendar_month),
                          color: Colors.white),
                      const SizedBox(
                        width: 0,
                      ),
                      Text(
                        model.date!,
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
                        model.time!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.location_on),
                              color: Colors.white),
                          const SizedBox(
                            width: 0,
                          ),
                          Text(
                            model.location!,
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border),
                                  color: Colors.white),
                              // Text(
                              //   'Save',
                              //   style: GoogleFonts.openSans(
                              //       color: Colors.white,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w400),
                              // ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/share.png',
                                height: 30,
                                width: 30,
                              )
                              // Text(
                              //   'Share',
                              //   style: GoogleFonts.openSans(
                              //       color: Colors.white,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w400),
                              // ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: dividerColor,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.openSans(
                        color: logoColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    model.description!,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tags',
                    style: GoogleFonts.openSans(
                        color: logoColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.from(
                model.tags!.map(
                  (tag) => Chip(label: Text(tag.name)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/user.png',
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Urge Talk',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
