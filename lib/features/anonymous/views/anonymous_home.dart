import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/anonymous/controller/anonymous_home_controller.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/home/model/home_model.dart';

import '../../../common/widgets/elevated_button.dart';

class AnonymousHomeScreen extends StatefulWidget {
  const AnonymousHomeScreen({Key? key}) : super(key: key);

  @override
  State<AnonymousHomeScreen> createState() => _AnonymousHomeScreenState();
}

class _AnonymousHomeScreenState extends State<AnonymousHomeScreen> {
  final AuthController _authController = Get.put(AuthController());
  final AnonymousController _anonymousController =
      Get.put(AnonymousController());
  bool isClicked = false;

  @override
  void initState() {
    _anonymousController.getAllAnonymousVideos();
    _anonymousController.newFeaturedVideos.value =
        _anonymousController.featuredVideoItems;
    _anonymousController.newRecommendedVideos.value =
        _anonymousController.recommendedVideoItems;
    _anonymousController.newTrendingVideos.value =
        _anonymousController.trendingVideoItems;
    _anonymousController.newLatestVideos.value =
        _anonymousController.latestVideoItems;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        id: 'Profile',
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: appBackgroundColor,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Welcome',
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
                            becomeMemberDialog();
                          },
                          child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('assets/images/saved_icon.png',
                                  height: 25, width: 25)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                            onTap: () {
                              becomeMemberDialog();
                            },
                            child: IconButton(
                              onPressed: () {
                                becomeMemberDialog();
                              },
                              icon: const Icon(Icons.person),
                              color: Colors.white,
                              iconSize: 35,
                            ))
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
                              // Get.to(() => const RecommendedVideos());
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
                              // Get.to(() => const LatestVideos());
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
                              // Get.to(() => const TrendingVideos());
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
    // return SizedBox(
    //     height: 250,
    //     child: Obx(() {
    //       if (_anonymousController.isLoading.value) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (_anonymousController.newFeaturedVideos.isEmpty) {
    //         return Center(
    //             child: Text(
    //           'No video',
    //           style: TextStyle(color: appBackgroundColor),
    //         ));
    //       } else {
    //         return ListView.builder(
    //             scrollDirection: Axis.horizontal,
    //             itemCount: _anonymousController.newFeaturedVideos.length,
    //             itemBuilder: ((context, index) {
    //               HomeModel video =
    //                   _anonymousController.newFeaturedVideos[index];
    //               return featured(video);
    //             }));
    //       }
    //     }));
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            'URGE LOLZ 2024 APPLICATION',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            'Stand a challenge to win N300,000 when you \nsend a short video of your jokes.',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 30,
          ),
          BtnElevated(
            btnWidth: 150,
            btnHeight: 30,
            onPressed: () {
              becomeMemberDialog();
            },
            child: Text(
              'APPLY NOW',
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildRecommendedVideos() {
    return SizedBox(
        height: 280,
        child: Obx(() {
          if (_anonymousController.isLoading.value) {
            return const Center(child: Center());
          } else if (_anonymousController.newRecommendedVideos.isEmpty) {
            return Center(
                child: Text(
              'No videos',
              style: TextStyle(color: appBackgroundColor),
            ));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _anonymousController.newRecommendedVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video =
                      _anonymousController.newRecommendedVideos[index];
                  return recommended(video);
                }));
          }
        }));
  }

  Widget buildLatestVideos() {
    return SizedBox(
        height: 300,
        child: Obx(() {
          if (_anonymousController.isLoading.value) {
            return const Center(child: Center());
          } else if (_anonymousController.newLatestVideos.isEmpty) {
            return Center(
                child: Text(
              'No videos',
              style: TextStyle(color: appBackgroundColor),
            ));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _anonymousController.newLatestVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _anonymousController.newLatestVideos[index];
                  return latest(video);
                }));
          }
        }));
  }

  Widget buildTrendingVideos() {
    return SizedBox(
        height: 250,
        child: Obx(() {
          if (_anonymousController.isLoading.value) {
            return const Center(child: Center());
          } else if (_anonymousController.newTrendingVideos.isEmpty) {
            return Center(
                child: Text(
              'No videos',
              style: TextStyle(color: appBackgroundColor),
            ));
          } else {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _anonymousController.newTrendingVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video =
                      _anonymousController.newTrendingVideos[index];
                  return trending(video);
                }));
          }
        }));
  }

  Widget recommended(HomeModel video) {
    return GestureDetector(
      onTap: () {
        becomeMemberDialog();
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Hero(
                tag: video.coverImage!,
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

  Widget featured(HomeModel video) {
    return GestureDetector(
      onTap: () {
        becomeMemberDialog();
      },
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                tag: video.coverImage!,
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
        becomeMemberDialog();
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: video.coverImage!,
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
        becomeMemberDialog();
      },
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Hero(
                tag: video.coverImage!,
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
