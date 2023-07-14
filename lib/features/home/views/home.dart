import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/views/latest_videos.dart';
import 'package:urge/features/home/views/recommended_videos.dart';
import 'package:urge/features/home/views/trending_videos.dart';
import 'package:urge/features/profile/views/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    _homeController.getFeaturedVideos();
    _homeController.getAllTrendingVideos();
    _homeController.getRecommendedVideos();
    _homeController.getLatestVideos();

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
              Text('Hello, Charles!!!',
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              GestureDetector(
                onTap: () {
                   Get.to(() => const Profile());
                },
                child: const CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage('assets/images/profile_pic.png')),
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
  }

  Widget buildFeaturedVideos() {
    return SizedBox(
      height: 250,
      child: Obx(() {
      if (_homeController.isListLoading.value) {
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
      if (_homeController.isListLoading.value) {
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
      if (_homeController.isListLoading.value) {
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
      if (_homeController.isListLoading.value) {
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
    return SizedBox(
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
    );
  }

  Widget featured(HomeModel video) {
    return SizedBox(
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
    );
  }

    Widget trending(HomeModel video) {
    return SizedBox(
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
    );
  }

  Widget latest(HomeModel video) {
    return SizedBox(
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
    );
  }
}
