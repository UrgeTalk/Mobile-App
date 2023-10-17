import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/dashboard/views/event_details.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:shimmer/shimmer.dart';

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  buildPastEvents(),
                  const SizedBox(height: 45),
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
                  buildPastEvents(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
          ),
      )
    );
  }
  Widget buildPastEvents(){
    return SizedBox(
      height: 280,
      child: Obx(() {
        if (_controller.isListLoading.value) {
          //return const Center(child: Center());
          return ShimmerLoadingList();
        } else if (_controller.errorMessage.isNotEmpty) {
          return const Center(child: Text('An Error Occurred'));
        } else if (_controller.registeredList.isEmpty) {
          return const Center(child: Text('No Events',
          style: TextStyle(color: Colors.white, fontSize: 16),));
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _controller.registeredList.length,
              itemBuilder: ((context, index) {
                Event _model = _controller.registeredList[index];
                return pastEvents(_model);
              }));
        }
      })
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
            height: 100,
            width: 330,
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
                    getStrDate(DateTime.parse(_model.date!),
                        pattern: "dd MMMM, yyyy") ??
                        '',
                    style: GoogleFonts.openSans(
                        color: logoColor,
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
                        _model.name!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      BtnElevated(
                        btnWidth: 110,
                        btnHeight: 35,
                        onPressed: () {
                          Get.to(() => EventDetails(model: _model));
                        },
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

class ShimmerLoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // You can adjust this based on the number of shimmer items you want
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: containerColor, // Set your shimmer background color here
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColor, // Set your shimmer background color here
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColor, // Set your shimmer background color here
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 10,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColor, // Set your shimmer background color here
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
