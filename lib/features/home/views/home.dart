import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/home_details.dart';
import 'package:urge/features/home/views/latest_videos.dart';
import 'package:urge/features/home/views/recommended_videos.dart';
import 'package:urge/features/home/views/saved_videos.dart';
import 'package:urge/features/home/views/trending_videos.dart';
import 'package:urge/features/profile/views/profile.dart';

import '../../auth/controller/auth_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());

  bool isClicked = false;


  @override
  void initState() {
    _authController.getProfile();
    _homeController.getFeaturedVideos();
    _homeController.getAllTrendingVideos();
    _homeController.getRecommendedVideos();
    _homeController.getLatestVideos();
    _homeController.getSavedVideoItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      id: 'Profile',
        builder: (controller){
        return Scaffold(
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Hello, ${_authController.profileModel.fullName ?? ""}',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SavedVideos());
                        },
                        child: const SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
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
                  )
                ],
              ),
            ),
            backgroundColor: appBackgroundColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'View our latest videos on Urge Talk',
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Featured',
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                    const SizedBox(
                      height: 5,
                    ),
                    buildFeaturedVideos(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recommended',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const RecommendedVideos());
                          },
                          child: Text('See all',
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: logoColor)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildRecommendedVideos(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Latest Videos',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const LatestVideos());
                          },
                          child: Text('See all',
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: logoColor)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildLatestVideos(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Trending Videos',
                            style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const TrendingVideos());
                          },
                          child: Text('See all',
                              style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: logoColor)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    buildTrendingVideos(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ));
        });
  }

  Widget buildFeaturedVideos() {
    return SizedBox(
        height: 250,
        child: Obx(() {
          if (_homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (_homeController.featuredVideos.isEmpty) {
            return const Center(child: Text('No video'));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.featuredVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.featuredVideos[index];
                  return featured(video);
                }));
          }
        }));
  }

  Widget buildRecommendedVideos() {
    return SizedBox(
        height: 280,
        child: Obx(() {
          if (_homeController.isLoading.value) {
            return const Center(child: Center());
          } else if (_homeController.recommendedVideos.isEmpty) {
            return const Center(child: Text('No videos'));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.recommendedVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.recommendedVideos[index];
                  return recommended(video);
                }));
          }
        }));
  }

  Widget buildLatestVideos() {
    return SizedBox(
        height: 260,
        child: Obx(() {
          if (_homeController.isLoading.value) {
            return const Center(child: Center());
          } else if (_homeController.lastestVideos.isEmpty) {
            return const Center(child: Text('No videos'));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.lastestVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.lastestVideos[index];
                  return latest(video);
                }));
          }
        }));
  }

  Widget buildTrendingVideos() {
    return SizedBox(
        height: 250,
        child: Obx(() {
          if (_homeController.isLoading.value) {
            return const Center(child: Center());
          } else if (_homeController.trendingVideos.isEmpty) {
            return const Center(child: Text('No videos'));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.trendingVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.trendingVideos[index];
                  return trending(video);
                }));
          }
        }));
  }

  Widget recommended(HomeModel video) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: video));
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(video.coverImage! ?? ""),
                      fit: BoxFit.cover)),
              width: 300,
              height: 180,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(video.title! ?? "",
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(video.speaker!.fullName ?? "",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Image.asset(
                  'assets/images/heart_icon.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget featured(HomeModel video) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: video));
      },
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(video.coverImage! ?? ""),
                      fit: BoxFit.cover)),
              width: 300,
              height: 180,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(video.title! ?? "",
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(video.speaker!.fullName ?? "",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Image.asset(
                  'assets/images/heart_icon.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget trending(HomeModel video) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: video));
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(video.coverImage! ?? ""),
                        fit: BoxFit.cover)),
                width: 300,
                height: 180,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(video.title! ?? "",
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(video.speaker!.fullName ?? "",
                      style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Image.asset(
                    'assets/images/heart_icon.png',
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget latest(HomeModel video) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: video));
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(video.coverImage! ?? ""),
                      fit: BoxFit.cover)),
              height: 180,
              width: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(video.title!,
                style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(video.speaker!.fullName ?? "",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Image.asset(
                  'assets/images/heart_icon.png',
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
