

import 'package:get/get.dart';
import 'package:urge/features/auth/controller/auth_controller.dart';
import 'package:urge/features/dashboard/controller/dashboard_controller.dart';
import 'package:urge/features/events/controller/event_controller.dart';
import 'package:urge/features/home/controller/home_controller.dart';
import 'package:urge/features/profile/controller/profile_controller.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<EventController>(EventController(), permanent: true);
    Get.put<DashboardController>(DashboardController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}