// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/home/model/home_model.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:urge/common/helpers/date_util.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({super.key, required this.model});

  final HomeModel model;

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final HomeController _homeController = Get.put(HomeController());

  bool isClicked = false;
  bool isLiked = false;

  void saveVideoItem() {
    setState(() {
      isClicked = !isClicked;
    });
    if (isClicked) {
      _homeController.saveVideoItem(widget.model);
    } else {
      _homeController.saveVideoItem(widget.model);
    }
  }

  void likeItem() {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      _homeController.likeVideoItem(widget.model);
    } else {
      _homeController.likeVideoItem(widget.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.network(widget.model.video! ?? ""),
      autoInitialize: true,
      looping: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.title!,
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
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 15 / 12,
                  child: Chewie(
                    controller: chewieController,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model.title!,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.model.speaker!.fullName ?? "",
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          getStrDate(DateTime.parse(widget.model.date!),
                                  pattern: "dd MMMM, yyyy") ??
                              '',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 45,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.download_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Download',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 45,
                          child: Column(
                            children: [
                              if(widget.model.saved == true)
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.favorite_outlined,
                                  color: logoColor,
                                ),
                              ),
                              if(widget.model.saved == false)
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    saveVideoItem();
                                  },
                                  child: Icon(
                                    isClicked
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_border,
                                    color: isClicked ? logoColor : Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Save',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 45,
                          child: Column(
                            children: [
                              if (widget.model.liked == true)
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Icon(
                                    Icons.thumb_up_alt,
                                    color: logoColor,
                                  ),
                                ),
                              if (widget.model.liked == false)
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      likeItem();
                                    },
                                    child: Icon(
                                      isLiked
                                          ? Icons.thumb_up_alt
                                          : Icons.thumb_up_alt_outlined,
                                      color: isLiked ? logoColor : Colors.white,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Like',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 45,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/share.png',
                                height: 20,
                                width: 30,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Share',
                                style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      widget.model.description!,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tags',
                      style: GoogleFonts.openSans(
                          color: logoColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.model.tags!.map((tag) {
                        return Chip(
                          label: Text(tag.name!),
                          backgroundColor: Colors.grey[300],
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Comments',
                      style: GoogleFonts.openSans(
                          color: logoColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
