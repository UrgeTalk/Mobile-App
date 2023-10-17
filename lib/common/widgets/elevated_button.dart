import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urge/common/widgets/colors.dart';
import 'loading_animation.dart';

class BtnElevated extends StatelessWidget {
  final Widget child;
  final bool useFlexibleWith;
  final VoidCallback? onPressed;
  final double btnHeight, btnWidth, btnRadius;
  final bool isLoading;
  const BtnElevated(
      {Key? key,
      required this.child,
      this.btnHeight = 45,
      this.useFlexibleWith = false,
      this.btnRadius = 25,
      this.btnWidth = double.infinity,
      this.isLoading = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: btnHeight,
      width: useFlexibleWith == true ? null : btnWidth,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: logoColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading ? LoadingAnimation(color: logoColor) : child),
    );
  }
}
