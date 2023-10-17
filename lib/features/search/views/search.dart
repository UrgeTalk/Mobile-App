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
import 'package:urge/features/profile/views/profile.dart';

import '../../home/views/home_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final HomeController _homeController = Get.put(HomeController());
  final AuthController _authController = Get.put(AuthController());

  void searchVideos(String value) {
    if (value.isEmpty) {
      _homeController.newTrendingVideos.value = _homeController.trendingVideos;
    } else {
      _homeController.newTrendingVideos.value = _homeController.trendingVideos
          .where((element) => element.title!.contains(value.toString()))
          .toList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getAllTrendingVideos();
      _homeController.newTrendingVideos.value = _homeController.trendingVideos;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        id: 'search',
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: appBackgroundColor,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search',
                      style: GoogleFonts.openSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: containerColor),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
                                  onChanged: searchVideos,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: Colors.white,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
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
                              itemCount:
                                  _homeController.newTrendingVideos.length,
                              itemBuilder: ((context, index) {
                                HomeModel _model =
                                    _homeController.newTrendingVideos[index];
                                return trendingVideos(_model);
                              }));
                        }
                      }),
                    ),
                  ],
                )),
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
