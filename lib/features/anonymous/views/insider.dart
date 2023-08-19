import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/dialog_box.dart';
import 'package:urge/common/widgets/colors.dart';
import 'package:urge/common/widgets/elevated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urge/features/auth/views/login.dart';


class Insider extends StatefulWidget {
  const Insider({Key? key}) : super(key: key);

  @override
  State<Insider> createState() => _InsiderState();
}

class _InsiderState extends State<Insider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/account.png',
                  height: 200, width: 300),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'You do not have access to this page.\n Login now and become an Insider.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: BtnElevated(
                      child: Text(
                        'BECOME AN INSIDER',
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      onPressed: () {
                        becomeMemberDialog();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
