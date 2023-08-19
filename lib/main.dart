import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urge/common/helpers/binding.dart';
import 'features/splash/splash.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';


Future<void> main() async {

  await GetStorage.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final introdata = GetStorage();

  @override
  void initState() {
    super.initState();
    introdata.writeIfNull("access", '');

  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        title: 'URGE',
        themeMode: ThemeMode.light,
        home: const SplashScreen());
  }
}
