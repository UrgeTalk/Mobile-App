import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData suffixIcon;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.suffixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.hintText,
          labelStyle: const TextStyle(color: Colors.white),
          fillColor: Colors.white,
          hintStyle: const TextStyle(color: Colors.white),
          suffixIcon: Icon(widget.suffixIcon, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        ),
        onChanged: (value) {
          setState(() {
            // Update the state if needed
          });
        },
        onTap: () {
          setState(() {
            _isFocused = true;
          });
        },
        onSubmitted: (value) {
          setState(() {
            _isFocused = false;
          });
        },
      ),
    );
  }
}
