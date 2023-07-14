import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'package:urge/features/profile/views/profile.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/features/home/model/home_model.dart';

class TrendingVideos extends StatefulWidget {
  const TrendingVideos({super.key});

  @override
  State<TrendingVideos> createState() => _TrendingVideosState();
}

class _TrendingVideosState extends State<TrendingVideos> {
  final HomeController _homeController = Get.put(HomeController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getAllTrendingVideos();
      _profileController.getProfile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        id: 'Profile',
        builder: (profileController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Trending',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const Profile());
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            _profileController.profileModel.profilePicture ??
                                ""),
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: appBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: Obx(() {
                      if (_homeController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (_homeController.errorMessage.isNotEmpty) {
                        return const Center(child: Text('An Error Occurred'));
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _homeController.trendingVideos.length,
                            itemBuilder: ((context, index) {
                              HomeModel _model =
                                  _homeController.trendingVideos[index];
                              return trendingVideos(_model);
                            }));
                      }
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget trendingVideos(HomeModel _model) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(_model.coverImage! ?? ""),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _model.title! ?? "",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        _model.speaker!.fullName ?? "",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        getStrDate(DateTime.parse(_model.date!),
                                pattern: "yyyy-MM-dd") ??
                            '',
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
