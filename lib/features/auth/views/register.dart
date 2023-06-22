import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/common/widgets/custom_textfield.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
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
  bool obscurePassword = false;

  final AuthController _authController = Get.put(AuthController());

  bool validateEmail(String email) {
    final valid_email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return valid_email.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => BlurryModalProgressHUD(
          inAsyncCall: _authController.isLoading.value,
           child: Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
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
                height: 25,
              ),
              CustomTextField(
                  controller: _emailController,
                  hintText: 'Email Address',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {},
                  ),
                  onChanged: (val) {
                    validateEmail(val);
                  },
                  validator: (value) {
                    if (value == '') {
                      return "Field cannot be empty";
                    } else {
                      bool result = validateEmail(value!);
                      if (result) {
                        return null;
                      } else {
                        return "Email format not correct";
                      }
                    }
                  }),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
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
                height: 25,
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye),
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
                    if (_formKey.currentState!.validate()) {
                      _authController.register(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          emailAddress: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                    }
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
    )));
  }
}
