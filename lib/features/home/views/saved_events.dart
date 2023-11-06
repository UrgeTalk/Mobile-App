

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/dashboard/views/event_details.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:urge/features/events/views/event_details.dart';

class SavedEvents extends StatefulWidget {
  const SavedEvents({super.key});

  @override
  State<SavedEvents> createState() => _SavedEventsState();
}

class _SavedEventsState extends State<SavedEvents> {
  final EventController _eventController = Get.put(EventController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventController.getSavedEventItems();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _savedEvents()
          ],
        ),
      ),
    );
  }

  Widget _savedEvents() {
    return Expanded(
        child:Obx(() {
          if (_eventController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (_eventController.savedEvent.isEmpty) {
            return const Center(child: Text('No Saved Event',
            style: TextStyle(color: Colors.white, fontSize: 16),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _eventController.savedEvent.length,
                itemBuilder: ((context, index) {
                  Event events = _eventController.savedEvent[index];
                  return eventList(events);
                }));
          }
        }));
  }

  Widget eventList(Event events) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetailsPage(model: events));
      },
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: events.cover ?? "",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Text(events.name! ?? "",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    getStrDate(DateTime.parse(events.date! ?? ""),
                        pattern: "dd MMMM, yyyy") ??
                        '',
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }


}