import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/new_bottom_nav.dart';
import 'package:urge/features/auth/views/forgot_password.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/reset_password.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3), () => Get.off(() => const NewBottomBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Center(
        child: Text(
          'URGE',
          style: GoogleFonts.openSans(
              color: logoColor, fontSize: 48, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
