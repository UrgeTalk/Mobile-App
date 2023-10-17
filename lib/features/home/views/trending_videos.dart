import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/home_details.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'package:urge/features/profile/views/profile.dart';

class TrendingVideos extends StatefulWidget {
  const TrendingVideos({super.key});

  @override
  State<TrendingVideos> createState() => _TrendingVideosState();
}

class _TrendingVideosState extends State<TrendingVideos> {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getAllTrendingVideos();
      _authController.getProfile();
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
                    child: CachedNetworkImage(
                      imageUrl: _authController.profileModel.profilePicture ==
                                  null ||
                              _authController.profileModel.profilePicture == ''
                          ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                          : _authController.profileModel.profilePicture!,
                      placeholder: (context, url) => const Center(),
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
                        return ShimmerLoadingList();
                        //return const Center(child: CircularProgressIndicator());
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
                  Hero(
                      tag: _model.coverImage!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: _model.coverImage! ?? "",
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      )),
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
                        _model.title!,
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
                                pattern: "dd MMMM, yyyy") ??
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

class ShimmerLoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        // You can adjust this based on the number of shimmer items you want
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:
                        containerColor, // Set your shimmer background color here
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
                          color:
                              containerColor, // Set your shimmer background color here
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
                          color:
                              containerColor, // Set your shimmer background color here
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
                          color:
                              containerColor, // Set your shimmer background color here
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
