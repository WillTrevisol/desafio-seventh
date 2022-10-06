import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({required this.widget, this.onPressed, super.key});

  final Widget widget;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26)
            ),
          ),
          elevation: MaterialStateProperty.all(0)
        ),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}