import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/common/widgets/elevated_button.dart';

import 'otp_verification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validateEmail(String email) {
    final valid_email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return valid_email.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'Forgot Password',
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter your registered Email Address below to retrieve your password.',
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                controller: _emailController,
                hintText: 'Email Address',
                suffixIcon: Icons.email_outlined),
            const SizedBox(
              height: 60,
            ),
            BtnElevated(
                child: Text(
                  'NEXT',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Get.to(() => const OTPVerification());
                }),
          ]),
        ),
      ),
    );
  }
}
