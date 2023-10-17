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
import 'package:shimmer/shimmer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_){
      _authController.getProfile();
      _homeController.getAllVideos();
      _homeController.getSavedVideoItems();
      _homeController.newFeaturedVideos.value = _homeController.featuredVideoItems;
      _homeController.newRecommendedVideos.value = _homeController.recommendedVideoItems;
      _homeController.newTrendingVideos.value = _homeController.trendingVideoItems;
      _homeController.newLatestVideos.value = _homeController.latestVideoItems;
    });
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
                  Expanded(
                    child: Text(
                        'Hello, ${_authController.profileModel.firstName ?? ""} ${_authController.profileModel.lastName ?? ""}',
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SavedVideos());
                        },
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: Image.asset('assets/images/saved_icon.png',
                          height: 25, width: 25)
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
                      height: 20,
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
            //return const Center(child: CircularProgressIndicator());
            return Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0), // You can customize the colors
              highlightColor: const Color(0xFFF5F5F5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ShimmerVideoPlaceholder();
                },
              ),
            );
          } else if (_homeController.newFeaturedVideos.isEmpty) {
            return Center(child: Text('No Featured videos yet', style: TextStyle(color: Colors.white),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.newFeaturedVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.newFeaturedVideos[index];
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
          } else if (_homeController.newRecommendedVideos.isEmpty) {
            return Center(child: Text('No videos', style: TextStyle(color: Colors.white),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.newRecommendedVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.newRecommendedVideos[index];
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
          } else if (_homeController.newLatestVideos.isEmpty) {
            return Center(child: Text('No videos', style: TextStyle(color: Colors.white),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.newLatestVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.newLatestVideos[index];
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
          } else if (_homeController.newTrendingVideos.isEmpty) {
            return Center(child: Text('No videos', style: TextStyle(color: Colors.white),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _homeController.newTrendingVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.newTrendingVideos[index];
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
                Hero(tag: video.coverImage!,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: video.coverImage! ?? "",
                        height: 180,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    )),
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
          ]),
        ),
      ),
    );
  }
  Widget ShimmerVideoPlaceholder() {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 300,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
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
            Hero(tag: video.coverImage!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: video.coverImage! ?? "",
                    height: 180,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                )),
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
              Hero(tag: video.coverImage!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: video.coverImage! ?? "",
                      height: 180,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  )),
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
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(tag: video.coverImage!,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: video.coverImage! ?? "",
                            height: 180,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                        )),
            const SizedBox(
              height: 10,
            ),
            Text(video.title!,
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
          ]),
        ),
      ),
    );
  }
}
