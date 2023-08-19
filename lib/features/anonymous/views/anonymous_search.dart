import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/views/register.dart';
import 'package:urge/features/profile/views/profile.dart';

class AnonymousSearch extends StatefulWidget {
  const AnonymousSearch({Key? key}) : super(key: key);

  @override
  State<AnonymousSearch> createState() => _AnonymousSearchState();
}

class _AnonymousSearchState extends State<AnonymousSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
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
                      const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          becomeMemberDialog();
                        },
                        child: IconButton(
                          icon: const Icon(Icons.person),
                          color: Colors.white,
                          iconSize: 35, onPressed: () {
                            becomeMemberDialog();
                        },
                        )
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: containerColor
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            decoration: InputDecoration(
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
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/account.png',
                        height: 200, width: 300),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        'You do not have access to this page.\n Sign up now and become a Member.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 30,
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //     child: BtnElevated(
                    //         child: Text(
                    //           'REGISTER',
                    //           style: GoogleFonts.openSans(
                    //               color: Colors.black,
                    //               fontSize: 14,
                    //               fontWeight: FontWeight.w700),
                    //         ),
                    //         onPressed: () {
                    //           Get.to(()=> const Register());
                    //         }))
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
