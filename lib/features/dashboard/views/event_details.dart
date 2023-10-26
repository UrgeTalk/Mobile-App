
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/dashboard/views/ticket.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.model});

  final Event model;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final EventController _controller = Get.put(EventController());
  bool isClicked = false;


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
    final String shareText = 'Check out this event!\n'
        'Event Name: ${widget.model.name}\n'
        'Date: ${getStrDate(DateTime.parse(widget.model.date!), pattern: "dd MMMM, yyyy")}\n'
        'Location: ${widget.model.location}\n';

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
                            image: NetworkImage(widget.model.cover!),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 5,
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
                        btnWidth: 110,
                        btnHeight: 30,
                        onPressed: () {
                          Get.to(() => Ticket(model: widget.model));
                        },
                        child: Text(
                          'VIEW TICKET',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                  const SizedBox(
                    height: 10,
                  ),
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
                              child: Icon(Icons.location_on, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
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
                      const SizedBox(
                        width: 15,
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
                            onTap: () async {
                            final urlImage = widget.model.cover;
                            final url = Uri.parse(urlImage!);
                            final response = await http.get(url);
                            final bytes = response.bodyBytes;
                            final temp = await getTemporaryDirectory();
                            final file = File('${temp.path}/image.jpg');
                            await file.writeAsBytes(bytes);
                            final filePath = file.path;
                            await Share.shareFiles([filePath], text: shareText);
                            },
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
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List<Widget>.from(widget.model.tags!
                        .map((tag) => Chip(label: Text(tag.name)))),
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
                    height: 25,
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
