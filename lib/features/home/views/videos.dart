import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:urge/common/helpers/date_util.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:urge/features/home/model/saved_items_model.dart';
import 'package:urge/features/home/views/home_details.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'package:urge/features/profile/views/profile.dart';
import 'package:google_fonts/google_fonts.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  final HomeController _homeController = Get.put(HomeController());
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getSavedVideoItems();
      _homeController.newSavedVideos.value = _homeController.savedVideos;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _savedVideos()
          ],
        ),
      ),
    );
  }

  Widget _savedVideos() {
    return Expanded(
        child:Obx(() {
          if (_homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (_homeController.savedVideos.isEmpty) {
            return const Center(child: Text('No Saved Video',
            style: TextStyle(color: Colors.white, fontSize: 16),));
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _homeController.savedVideos.length,
                itemBuilder: ((context, index) {
                  HomeModel video = _homeController.savedVideos[index];
                  return videoList(video);
                }));
          }
        }));
  }

  Widget videoList(HomeModel video) {
    return GestureDetector(
      onTap: () {
        Get.to(() => HomeDetails(model: video));
      },
      child: SizedBox(
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: video.coverImage! ?? "",
                    height: 180,
                    width: double.infinity,
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
                Text(
                    getStrDate(DateTime.parse(video.date! ?? ""),
                        pattern: "dd MMMM, yyyy") ??
                        '',
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                // Image.asset(
                //   'assets/images/heart_icon.png',
                //   height: 20,
                //   width: 20,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }



}
