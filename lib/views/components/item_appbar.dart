import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final Widget child;
  final double? height;
  final List<Color>? gradientColors;
  const GradientAppBar(
      {Key? key, required this.child, this.height, this.gradientColors})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var appBarTheme = Theme.of(context).appBarTheme;

    return Container(
      height: height ?? 0.14 * size.height,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: 0.14 * size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors ??
                    [
                      appbarStartGradient,
                      appbarEndGradient,
                    ],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: Image.asset(
          //     ImageUtil.ic_tab_ripple_effect_background,
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          Center(child: child),
          SizedBox(
            height: SizeConfig.paddingSizeVertical16,
          ),
        ],
      ),
    );
  }
}
