import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/otp_verification.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: Form(
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
                      'assets/images/register.png',
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
                    Text('Register',
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
                'Fill in the following fields to create an account.',
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        controller: _firstNameController,
                        hintText: 'First Name',
                        suffixIcon: Icons.person_outline),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                        controller: _lastNameController,
                        hintText: 'Last Name',
                        suffixIcon: Icons.person_outline),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  suffixIcon: Icons.email),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  suffixIcon: Icons.remove_red_eye),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  suffixIcon: Icons.remove_red_eye),
              const SizedBox(
                height: 35,
              ),
              BtnElevated(
                  child: Text(
                    'REGISTER',
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.to(() => const Login());
                  }),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const Login());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account?',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Login',
                            style: GoogleFonts.openSans(
                                color: logoColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
