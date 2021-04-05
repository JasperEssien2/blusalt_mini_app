import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';

class AppUtil {
  AppUtil._();

  static AlertDialog authenticateDialog(
      BuildContext context, TextStyle textStyle) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      content: Text(
        'Only authenticated users can create question, Authenticate?',
        style: textStyle,
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.popAndPushNamed(context, Routes.authenticationPageLogin);
          },
          child: Text(
            'OK',
            style: textStyle.copyWith(
              fontSize: SizeConfig.textSize16,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
