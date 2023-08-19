import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
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
import 'package:urge/features/profile/views/change_password.dart';
import 'package:urge/features/profile/views/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _profileController = Get.find<ProfileController>();

  final introdata = GetStorage();

  final TextEditingController _firstNameController =
      TextEditingController(text: '');
  final TextEditingController _lastNameController =
      TextEditingController(text: '');
  late TabController _tabController;
  int _currentIndex = 0;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  File? image;

  void getDetails() {
    _firstNameController.text = _profileController.profileModel.firstName ?? '';
    _lastNameController.text = _profileController.profileModel.lastName ?? '';
  }

  void _onTabChange() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  initState() {
    _profileController.getProfile();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChange);
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => BlurryModalProgressHUD(
        inAsyncCall: _profileController.isLoading.value,
        child: Scaffold(
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
                Text('Profile',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 40,
                  child: BtnElevated(
                    btnWidth: 100,
                    btnHeight: 20,
                    onPressed: () {
                      Get.to(()=> const EditProfile());
                    },
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
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
                      imageUrl: _profileController
                                      .profileModel.profilePicture ==
                                  null ||
                              _profileController.profileModel.profilePicture ==
                                  ''
                          ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                          : _profileController.profileModel.profilePicture!,
                      placeholder: (context, url) => const Center(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.white,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${_profileController.profileModel.firstName ?? ""} ${_profileController.profileModel.lastName ?? ""}',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
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
                        onPressed: () {
                          //subscriptionDialog();
                        },
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
                        onPressed: () {
                          Get.to(() => const ChangePassword());
                        },
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
                        onPressed: () {
                          logoutDialog();
                        },
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
        )));
  }

  logoutDialog() {
    return Get.dialog(AlertDialog(
      backgroundColor: containerColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Builder(
        builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            height: height * 0.25,
            width: width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Logout',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 10,
                ),
                Text('Are you sure you want to Logout?',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: BtnElevated(
                          btnHeight: 40,
                          child: Text(
                            'CANCEL',
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _profileController.logOut();
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: logoColor, width: 1),
                          ),
                          child: const Center(
                            child: Text(
                              'LOGOUT',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    ));
  }

  subscriptionDialog() {
    return Get.dialog(AlertDialog(
      backgroundColor: containerColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Builder(builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height * 0.5,
          width: width * 0.9,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 10,
            ),
            Text('BECOME AN',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 5,
            ),
            Text('INSIDER',
                style: GoogleFonts.openSans(
                    color: logoColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w900)),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('MONTHLY',
                      style: GoogleFonts.openSans(
                          color: logoColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('ANNUALLY',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('\$20',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w900)),
            const SizedBox(
              height: 10,
            ),
            Text(
                'Enjoy full access to all Urge content \n and huge discount on Urge Merchandise',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 15,
            ),
            BtnElevated(
                child: Text(
                  'SUBSCRIBE',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                }),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _profileController.submitRequest();
              },
              child: Text(
                'BECOME A SPEAKER',
                style: GoogleFonts.openSans(
                    color: logoColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),

            // _buildTabBar(),
            // Expanded(
            //     child: TabBarView(
            //   controller: _tabController,
            //   children: const [],
            // ))
          ]),
        );
      }),
    ));
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
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          validator: (value) {
                            if (value != '') {
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
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          validator: (value) {
                            if (value != '') {
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

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {
      //_profileController.uploadImage(image!);
    });
    print(image);
    print(image!.path);
    _profileController.uploadImage(image!);
  }

  Widget _buildTabBar() {
    return Material(
      child: TabBar(
        labelPadding: EdgeInsets.all(0),
        labelColor: logoColor,
        unselectedLabelColor: Colors.white,
        controller: _tabController,
        tabs: const [
          SizedBox(
            child: Tab(
              text: 'MONTHLY',
            ),
          ),
          SizedBox(
            child: Tab(text: 'ANNUALLY'),
          )
        ],
      ),
    );
  }
}
