import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/auth/views/login.dart';
import 'package:urge/features/auth/views/reset_password.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key, required this.emailAddress});

    final String emailAddress;


  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
    final AuthController _authController = Get.put(AuthController());

  final TextEditingController _otpPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'Verification',
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
              'An OTP has been sent to your email address.Kindly fill in the OTP below to verify your account.',
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Change Email Address',
              style: GoogleFonts.openSans(
                  fontSize: 14, fontWeight: FontWeight.w600, color: logoColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            PinCodeTextField(
              textStyle: const TextStyle(color: Colors.white),
              autovalidateMode: AutovalidateMode.disabled,
              validator: (value) {
                if (value == '') {
                  return "Pin cannot be empty";
                } else if (value!.length < 4) {
                  return 'Enter your 4 digit Pin';
                } else {
                  return null;
                }
              },
              onChanged: (value) {},
              cursorColor: Colors.white,
              appContext: context,
              length: 4,
              controller: _otpPinController,
              backgroundColor: Colors.transparent,
              enableActiveFill: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              autoDisposeControllers: false,
            
              enablePinAutofill: true,
              autoFocus: false,
              pinTheme: PinTheme(
                errorBorderColor: Colors.red,
                borderRadius: BorderRadius.circular(8),
                borderWidth: 1,
                fieldWidth: 46,
                fieldHeight: 48,
                activeColor: Colors.white,
                activeFillColor: Colors.white,
                inactiveColor: Colors.white,
                selectedColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.white,
                shape: PinCodeFieldShape.box,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Resend OTP',
              style: GoogleFonts.openSans(
                  fontSize: 14, fontWeight: FontWeight.w600, color: logoColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 70,
            ),
            BtnElevated(
                child: Text(
                  'VERIFY',
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
                onPressed: () {
                  if (_otpPinController.text.length == 4) {
                            _authController.verifyEmail(
                              widget.emailAddress,
                              _otpPinController.text
                            );
                          }
                }),
          ],
        ),
      ),
    );
  }
}
