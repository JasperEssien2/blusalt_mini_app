import 'package:blusalt_mini_app/styles/colors.dart';
import 'package:blusalt_mini_app/utils/size_config_util.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class AuthenticationPage extends StatefulWidget {
  final Widget child;

  const AuthenticationPage({Key? key, required this.child}) : super(key: key);
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    appbarStartGradient,
                    appbarStartGradient.withOpacity(0.5),
                    appbarEndGradient,
                    appbarEndGradient.withOpacity(0.5),
                  ],
                  durations: [18000, 8000, 5000, 12000],
                  heightPercentages: [0.95, 0.86, 0.88, 0.98],
                ),
                heightPercentange: size.height * 0.5,
                backgroundColor: appbarEndGradient,
                size: Size(
                  size.width,
                  size.height * 0.5,
                ),
              ),
            ),
            Center(child: widget.child),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  right: 16.0,
                ),
                child: Text(
                  'Skip',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: SizeConfig.textSize16,
                        color: Colors.white,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
