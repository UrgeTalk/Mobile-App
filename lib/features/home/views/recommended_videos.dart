import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/views/home.dart';
import 'package:urge/features/home/views/home_details.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'package:urge/features/profile/views/profile.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecommendedVideos extends StatefulWidget {
  const RecommendedVideos({super.key});

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getRecommendedVideos();
      _authController.getProfile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Text('Recommended',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
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
                      itemCount: _homeController.recommendedVideos.length,
                      itemBuilder: ((context, index) {
                        HomeModel _model = _homeController.recommendedVideos[index];
                        return recommendedVideos(_model);
                      }));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget recommendedVideos(HomeModel _model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: _model));
      },
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
