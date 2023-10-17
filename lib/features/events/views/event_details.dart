import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/events/controller/event_controller.dart';

import '../model/event_model.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({Key? key, required this.model}) : super(key: key);
  final Event model;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final EventController _controller = Get.put(EventController());

  bool isRegistered = false;
  bool isClicked = false;

  void registerForEvent() {
    _controller.registerEvent(widget.model);
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  void saveEventItem() {
    setState(() {
      isClicked = !isClicked;
    });
    if (isClicked) {
      _controller.saveEventItem(widget.model);
    } else {
      _controller.saveEventItem(widget.model);
    }
  }

  Future<void> shareEventDetails() async {
    final String shareText = 'Check out this event!\n'
        'Name: ${widget.model.name}\n'
        'Date: ${getStrDate(DateTime.parse(widget.model.date!), pattern: "dd MMMM, yyyy")}\n'
        'Type: ${widget.model.type}\n'
        'Location: ${widget.model.location}\n';

    try {
      await FlutterShare.share(
        title: 'Event Details',
        text: shareText,
        linkUrl: "",
        // Change the mime type according to your image type
      );
    } catch (e) {
      print('Error sharing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String locationText = widget.model.location ?? ''; // Ensure it's not null
    const int maxTextLength = 35; // Set your desired maximum length

    if (locationText.length > maxTextLength) {
      locationText = locationText.substring(0, maxTextLength) + '...';
    }
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
                  Hero(
                      tag: widget.model.cover!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.model.cover ?? "",
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )),
                  // Container(
                  //   height: 250,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: DecorationImage(
                  //           image: NetworkImage(widget.model.cover!),
                  //           fit: BoxFit.cover)),
                  // ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.model.type == "free")
                    Text('Free',
                        style: GoogleFonts.openSans(
                            color: yellowColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  if (widget.model.type == "paid")
                    Text(
                      capitalizeFirstLetter(widget.model.amount.toString()),
                      style: GoogleFonts.openSans(
                          color: yellowColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.model.name!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      BtnElevated(
                        btnWidth: 100,
                        btnHeight: 35,
                        onPressed: () {
                          isRegistered ? null : registerForEvent();
                        },
                        child: Text(
                          isRegistered ? 'REGISTERED' : 'REGISTER',
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
                        getStrDate(DateTime.parse(widget.model.date!),
                                pattern: "dd MMMM, yyyy") ??
                            '',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
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
                        widget.model.time!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child:
                                  Icon(Icons.location_on, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                locationText,
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      saveEventItem();
                                    },
                                    child: Icon(
                                      isClicked
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_border,
                                      color:
                                          isClicked ? logoColor : Colors.white,
                                    ),
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
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: shareEventDetails,
                            child: SizedBox(
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
                    widget.model.description!,
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
                    children: widget.model.tags!.map((tag) {
                      return Chip(
                        label: Text(tag.name),
                        backgroundColor: Colors.grey[300],
                      );
                    }).toList(),
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
                  ),
                  const SizedBox(
                    height: 30,
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
