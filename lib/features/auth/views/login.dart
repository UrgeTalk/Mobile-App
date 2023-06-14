import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/custom_button.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/features/auth/views/forgot_password.dart';
import 'package:urge/features/auth/views/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = false;
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/login_icon.png',
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 50,
                          color: logoColor,
                          width: 2,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Login',
                            style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Fill in your details below to login.',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: _emailController,
                      hintText: 'Email Address',
                      suffixIcon: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      suffixIcon: Icons.remove_red_eye),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPassword());
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.openSans(
                            color: logoColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BtnElevated(
                      child: Text(
                        'LOGIN',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        Get.to(() => const BottomBar());
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const Register());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign up now',
                                style: GoogleFonts.openSans(
                                    color: logoColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
