import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';

class CustomEditText extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType type;
  final bool obscureText;

  const CustomEditText(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      required this.type,
      this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var primaryTextColorScheme2 =
        Theme.of(context).colorScheme.primaryTextColorScheme;

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.paddingSizeHorizontal16,
        vertical: SizeConfig.paddingSizeVertical16,
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: type,
        textAlign: TextAlign.start,
        minLines: 1,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          helperStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: primaryTextColorScheme2,
                fontWeight: FontWeight.w700,
              ),
          focusColor: accentColor,
          hoverColor: accentColor,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.dividerColorScheme,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.dividerColorScheme,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ),
            borderSide: BorderSide(
              width: 0.5,
              color: accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
