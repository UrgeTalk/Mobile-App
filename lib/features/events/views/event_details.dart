import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage({super.key, required this.model});

  final Event model;

  bool isRegistered = false;

  void registerForEvent() {
    _controller.registerEvent(model);
  }

  final EventController _controller = Get.put(EventController());

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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                        btnWidth: 100,
                        btnHeight: 35,
                        onPressed: () {
                          isRegistered ? null : registerForEvent();
                        },
                        child: Text(
                         isRegistered? 'REGISTERED': 'REGISTER',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.calendar_month, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 15,
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
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(Icons.access_time, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.location_on, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
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
                          SizedBox(
                            height: 45,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Save',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            height: 45,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/share.png',
                                  height: 20,
                                  width: 30,
                                ),
                                Text(
                                  'Share',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    'Description',
                    style: GoogleFonts.openSans(
                        color: logoColor,
                        fontSize: 14,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.from(model.tags!.map((tag) => Chip(
                        label: Text(tag.name),
                        labelStyle: const TextStyle(color: Colors.white),
                        backgroundColor: chipColor))),
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
