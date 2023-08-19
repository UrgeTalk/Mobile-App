import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/helpers/functions.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';
import 'dart:io';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _formKey = GlobalKey<FormState>();
  final _profileController = Get.find<ProfileController>();

  final introdata = GetStorage();

  final TextEditingController _firstNameController =
  TextEditingController();
  final TextEditingController _lastNameController =
  TextEditingController();
  File? image;


  void getDetails() {
    _firstNameController.text = _profileController.profileModel.firstName ?? '';
    _lastNameController.text = _profileController.profileModel.lastName ?? '';
  }
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfile();
      getDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit Profile',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                              selectImage();
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
                  height: 30,
                ),
                CustomTextField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.person_outline),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field cannot be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.person_outline),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field cannot be empty";
                    }
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() =>
                    BtnElevated(
                      isLoading: _profileController.isLoading.value,
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _profileController.editProfile(
                                _firstNameController.text,
                                _lastNameController.text);
                          }
                        }),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {
      //_profileController.uploadImage(image!);
    });
    print(image);
    print(image!.path);
    _profileController.uploadImage(image!);
  }
}
