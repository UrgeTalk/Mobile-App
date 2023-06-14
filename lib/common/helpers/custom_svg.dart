import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg(
      {super.key,
      required this.assetName,
      this.height,
      this.width,
      this.color});

  final String assetName;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height,
        width: width,
        color: color);
  }

  static Widget normalImage(String path,
      {double? width, double? height, Color? color}) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
    );
  }

}
