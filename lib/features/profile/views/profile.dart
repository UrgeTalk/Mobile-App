import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:urge/features/profile/model/profile_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _profileController = Get.put(ProfileController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  File? image;

  void getDetails() {
    _firstNameController.text = _profileController.profileModel.firstName ?? '';
    _lastNameController.text = _profileController.profileModel.lastName ?? '';
  }

    @override
  initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfile();
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text('Profile',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700))
          ],
        ),
        actions: [
          BtnElevated(
            btnWidth: 110,
            btnHeight: 30,
            onPressed: () {
              editProfileDialog();
            },
            child: Text(
              'Edit Profile',
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
            ),
          )
        ],
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: _profileController.profileModel.profilePicture ==
                              null ||
                          _profileController.profileModel.profilePicture == ''
                      ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                      : _profileController.profileModel.profilePicture!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.person,
                    size: 120,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _profileController.profileModel.fullName,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Subscription',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.white,
                    iconSize: 25,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Account Settings',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.white,
                    iconSize: 25,
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Logout',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward),
                    color: Colors.white,
                    iconSize: 25,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  editProfileDialog() {
    return Get.dialog(AlertDialog(
      backgroundColor: containerColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            height: height * 0.5,
            width: width * 0.9,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Edit Profile',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        image == null
                            ? CachedNetworkImage(
                                imageUrl: _profileController
                                                .profileModel.profilePicture ==
                                            null ||
                                        _profileController
                                                .profileModel.profilePicture ==
                                            ''
                                    ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                                    : _profileController
                                        .profileModel.profilePicture!,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  size: 120,
                                ),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 120.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  image!,
                                ),
                                radius: 64,
                              ),
                        Positioned(
                          bottom: 0,
                          right: -15,
                          child: IconButton(
                              onPressed: () {
                                // selectImage();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: logoColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstNameController,
                          hintText: 'First Name',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.person_outline),
                            onPressed: () {},
                          ),
                          validator: (value) {
                            if (value == '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          hintText: 'Last Name',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.person_outline),
                            onPressed: () {},
                          ),
                          validator: (value) {
                            if (value == '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  BtnElevated(
                      child: Text(
                        'SAVE',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      }),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
