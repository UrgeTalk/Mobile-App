import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/common/widgets/custom_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  bool obscurePassword = false;
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password',
            style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        backgroundColor: appBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: appBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
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
                  controller: _newPasswordController,
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
                  controller: _confirmNewPasswordController,
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
                    isLoading: _authController.isLoading.value,
                    child: Text(
                      'Reset Password',
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
        ),
      ),
    );
  }
}
