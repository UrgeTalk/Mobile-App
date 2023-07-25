import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/dashboard/views/event_details.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';

class RegisteredEvents extends StatefulWidget {
  const RegisteredEvents({super.key});

  @override
  State<RegisteredEvents> createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  final EventController _controller = Get.put(EventController());

  @override
  void initState() {
    _controller.getAllRegisteredEvents();
    //_controller.newEventList.value = _controller.eventList;
    super.initState();
  }

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
          child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text('Past Event',
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Obx(() {
                    if (_controller.isListLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (_controller.errorMessage.isNotEmpty) {
                      return const Center(child: Text('An Error Occurred'));
                    } else if (_controller.registeredList.isEmpty) {
                      return const Center(child: Text('No Registered Event Found'));
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _controller.registeredList.length,
                          itemBuilder: ((context, index) {
                            Event _model = _controller.registeredList[index];
                            return pastEvents(_model);
                          }));
                    }
                  }),
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
                // Expanded(
                //   child: Obx(() {
                //     if (_controller.isLoading.value) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else if (_controller.errorMessage.isNotEmpty) {
                //       return const Center(child: Text('An Error Occured'));
                //     } else if (_controller.newEventList.isEmpty) {
                //       return const Center(child: Text('No Event Found'));
                //     } else {
                //       return ListView.builder(
                //           scrollDirection: Axis.vertical,
                //           itemCount: _controller.newEventList.length,
                //           itemBuilder: ((context, index) {
                //             Event _model = _controller.newEventList[index];
                //             return pastEvents(_model);
                //           }));
                //     }
                //   }),
                // ),
              ],
            ),
      )
    );
  }

  Widget pastEvents(Event _model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetails(model: _model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      image: DecorationImage(
                          image: NetworkImage(
                            _model.cover! ?? "",
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
                    _model.date!,
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
                        _model.name!,
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
                    _model.location!,
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
