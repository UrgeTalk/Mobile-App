import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/playlist/model/playlist_model.dart';
import 'package:video_player/video_player.dart';

import '../../../common/widgets/colors.dart';
import '../../auth/controller/auth_controller.dart';
import '../../home/controller/home_controller.dart';
import '../controller/playlist_controller.dart';

class EpisodeDetails extends StatefulWidget {
  const EpisodeDetails({super.key, required this.playlistModel});

  final PlaylistModel playlistModel;

  @override
  State<EpisodeDetails> createState() => _EpisodeDetailsState();
}

class _EpisodeDetailsState extends State<EpisodeDetails> {
  final AuthController _authController = Get.put(AuthController());
  final PlaylistController _playlistController = Get.put(PlaylistController());
  final HomeController _homeController = Get.put(HomeController());

  late final FlickManager flickManager;
  bool isClicked = false;
  bool isLiked = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
        VideoPlayerController.network(widget.playlistModel.video! ?? ""));
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlaylistController>(
      id: 'episodes',
        builder: (controller){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.playlistModel.title!,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          backgroundColor: appBackgroundColor,
          elevation: 0,
        ),
        backgroundColor: appBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playlistModel.title!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Description',
                        style: GoogleFonts.openSans(
                            color: logoColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.playlistModel.description!,
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
