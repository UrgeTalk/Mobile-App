import 'package:flutter/material.dart';
import 'package:urge/common/widgets/colors.dart';

class NormalButtonWidget extends StatelessWidget {
  final String buttonText;
  final double width;
  final Function onpressed;
  final bool loading;
  final double radius;

  const NormalButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.width,
      required this.onpressed,
      this.radius = 20,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        // ignore: prefer_const_literals_to_create_immutables
        boxShadow: [
          const BoxShadow(
              color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
        ],

        color: logoColor,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(width, 50)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          // elevation: MaterialStateProperty.all(3),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          if (loading) {
          } else {
            onpressed();
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
