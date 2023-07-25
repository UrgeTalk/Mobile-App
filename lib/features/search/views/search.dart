import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/profile/views/profile.dart';



class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Search',
                          style: GoogleFonts.openSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/heart_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
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
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),

    );
  }
}