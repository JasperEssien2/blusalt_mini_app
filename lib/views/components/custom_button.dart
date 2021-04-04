import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final isEnabled;
  final isLoading;
  final buttonText;
  final Function? onPressed;
  final double radius;

  CustomButton(
      {this.isEnabled = true,
      this.isLoading = false,
      required this.buttonText,
      required this.onPressed,
      this.radius = 30.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RawMaterialButton(
        fillColor: isEnabled ? accentColor : Colors.grey[400],
        onPressed: isEnabled
            ? () {
                onPressed!();
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      accentColor.withOpacity(0.3)),
                )
              : Text(
                  buttonText,
                ),
        ),
      ),
    );
  }
}
