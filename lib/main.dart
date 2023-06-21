import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'features/splash/splash.dart';

Future<void> main() async {
 // DevicePreview(builder: (context) => const MyApp());
  runApp(const MyApp());
}
// void main() => runApp(
//   DevicePreview(builder: (context) =>const  MyApp()),
// );


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
       // locale: DevicePreview.locale(context),
        //builder: DevicePreview.appBuilder,
        title: 'URGE',
        themeMode: ThemeMode.light,
        home: const SplashScreen());
  }
}
