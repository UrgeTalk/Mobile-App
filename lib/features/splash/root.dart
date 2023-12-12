

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:urge/common/widgets/bottom_nav.dart';
import 'package:urge/common/widgets/new_bottom_nav.dart';
import 'package:urge/features/splash/splash.dart';

import '../auth/views/login.dart';

class Root extends StatelessWidget {
  Root({super.key});
  final introdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return introdata.read("display") ? introdata.read("access") == '' ? const Login() : const BottomBar(): const NewBottomBar();
  }
}
