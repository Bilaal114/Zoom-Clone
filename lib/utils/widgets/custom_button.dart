import 'package:flutter/material.dart';
import 'package:zoom_clone1/utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String text;
  final VoidCallback onpressed;
  CustomButton({
    Key? key,
    required this.onpressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: buttonColor, minimumSize: const Size(double.infinity, 50)),
        onPressed: onpressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
