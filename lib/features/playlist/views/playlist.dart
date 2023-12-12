import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:get/get.dart';
import 'package:urge/features/playlist/controller/playlist_controller.dart';
import 'package:urge/features/playlist/model/playlist_model.dart';
import 'package:urge/features/playlist/views/playlist_details.dart';
import '../../auth/controller/auth_controller.dart';
import 'package:urge/features/home/views/saved_videos.dart';
import '../../profile/views/profile.dart';


class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {

  final AuthController _authController = Get.put(AuthController());
  final PlaylistController _playlistController = Get.put(PlaylistController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playlistController.getAllPlaylist();
            _playlistController.allNewPlaylist.value = _playlistController.allPlaylist;
          });
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
            Text('Playlist',
              style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
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
                          height: 25, width: 25)),
                ),
                const SizedBox(
                  width: 25,
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
                        border:
                        Border.all(color: Colors.white, width: 2),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text('View all collection of playlist just for you',
                style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(() {
                if (_playlistController.isListLoading.value) {
                  return ShimmerLoadingList();
                  //return const Center(child: CircularProgressIndicator());
                } else if (_playlistController.errorMessage.isNotEmpty) {
                  return const Center(child: Text('An Error Occurred'));
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:
                      _playlistController.allNewPlaylist.length,
                      itemBuilder: ((context, index) {
                        PlaylistModel _model =
                        _playlistController.allNewPlaylist[index];
                        return allPlaylist(_model);
                      }));
                }
              }),
            ),

          ],
        ),
      ),
    );
  }

  Widget allPlaylist(PlaylistModel _model) {
    return GestureDetector(
      onTap: (){
         Get.to(()=> PlaylistDetails(model: _model));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Hero(
                          tag: _model.cover!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: _model.cover! ?? "",
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/playlist_icon.png',
                                height: 25,
                                width: 25,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${_model.episodeCount!.toString()} Episodes',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Column(
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
                      _model.speaker!,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ],
                  ))
                ],
              )
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
        itemCount: 3,
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

