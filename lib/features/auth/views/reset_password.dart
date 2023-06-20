import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/custom_button.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/features/auth/views/login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscurePassword = false;
  final _formKey = GlobalKey<FormState>();

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
              height: 40,
            ),
            Text(
              'Reset Password',
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
              'Create a new password with a minimum of 8\n characters, with at least 1 special character\n (capital letter, number or punctuation).',
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            CustomTextField(
              controller: _passwordController,
              hintText: 'New Password',
              suffixIcon: IconButton(
                icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              obscureText: !obscurePassword,
              validator: (value) {
                if (value != '') {
                  return null;
                } else {
                  return "Field cannot be empty";
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: 'Confirm New Password',
              suffixIcon: IconButton(
                icon: Icon(
                    obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                },
              ),
              obscureText: !obscurePassword,
              validator: (value) {
                if (value != '') {
                  return null;
                } else {
                  return "Field cannot be empty";
                }
              },
            ),
            const SizedBox(
              height: 60,
            ),
            BtnElevated(
                child: Text(
                  'RESET PASSWORD',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  Get.to(() => const Login());
                }),
          ]),
        ),
      ),
    );
  }
}
