import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/events/model/event_model.dart';
import 'package:urge/features/events/views/event_details.dart';
import 'package:urge/features/profile/views/profile.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final EventController _controller = Get.put(EventController());
  final AuthController _authController = Get.put(AuthController());

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  void initState() {
    _controller.getAllEvents();
    _controller.newEventList.value = _controller.eventList;
    _controller.newUpcomingList.value = _controller.upcomingList;
    super.initState();
  }

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
              GestureDetector(
                onTap: () {
                  Get.to(() => const Profile());
                },
                child: CachedNetworkImage(
                  imageUrl: _authController
                      .profileModel.profilePicture ==
                      null ||
                      _authController
                          .profileModel.profilePicture ==
                          ''
                      ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                      : _authController.profileModel.profilePicture!,
                  placeholder: (context, url) =>
                  const Center(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 35,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: appBackgroundColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  buildFeaturedEvents(),
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
                  buildUpcomingEvents(),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )));
  }

  Widget buildFeaturedEvents() {
    return SizedBox(
      height: 300,
      child: Obx(() {
        if (_controller.isListLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_controller.errorMessage.isNotEmpty) {
          return const Center(child: Text('An Error Occurred'));
        } else if (_controller.newEventList.isEmpty) {
          return const Center(child: Text('No Featured events yet',
          style: TextStyle(color: Colors.white),));
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _controller.newEventList.length,
              itemBuilder: ((context, index) {
                Event _model = _controller.newEventList[index];
                return featuredEvents(_model);
              }));
        }
      }),
    );
  }

  Widget buildUpcomingEvents() {
    return SizedBox(
      height: 300,
      child: Obx(() {
        if (_controller.isListLoading.value) {
          return const Center();
        } else if (_controller.errorMessage.isNotEmpty) {
          return const Center(child: Text('An Error Occurred'));
        } else if (_controller.newUpcomingList.isEmpty) {
          return const Center(child: Text(''));
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _controller.newUpcomingList.length,
              itemBuilder: ((context, index) {
                Event _model = _controller.newUpcomingList[index];
                return upcomingEvents(_model);
              }));
        }
      }),
    );
  }

  Widget featuredEvents(Event _model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetailsPage(model: _model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: containerColor),
            height: 240,
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
                    getStrDate(DateTime.parse(_model.date!),
                        pattern: "dd MMMM, yyyy") ??
                        '',
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
                        btnHeight: 35,
                        onPressed: () {
                          Get.to(() => EventDetailsPage(model: _model));
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

  Widget upcomingEvents(Event _model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventDetailsPage(model: _model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: containerColor),
            height: 280,
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
                  child:
                  Text(
                    capitalizeFirstLetter(_model.type!),
                    style: GoogleFonts.openSans(
                        color: yellowColor,
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
                      const SizedBox(
                        width: 15,
                      ),
                      BtnElevated(
                        btnWidth: 100,
                        btnHeight: 35,
                        onPressed: () {
                          Get.to(() => EventDetailsPage(model: _model));
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
                ),
                const SizedBox(
                  height: 10,
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
                      getStrDate(DateTime.parse(_model.date!),
                          pattern: "dd MMMM, yyyy") ??
                          '',
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
                      _model.time!,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
