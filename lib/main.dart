import 'package:blusalt_mini_app/styles/theme.dart';
import 'package:blusalt_mini_app/utils/home_widget_util.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'di/injector_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // you can add more portrait definition here
  ]);
  Widget homeWidget = await HomeWidgetUtil.getHomeWidget();
  runApp(MediaQuery(data: new MediaQueryData(), child: MyApp(homeWidget)));
}

class MyApp extends StatelessWidget {
  final Widget homeWidget;
  MyApp(this.homeWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(
        'MAIN BRIGHTNESS: ------------------------ ${SchedulerBinding.instance!.window.platformBrightness}');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(context, false),
      debugShowCheckedModeBanner: false,
      darkTheme: appTheme(context, true),
      home: homeWidget,
      routes: Routes.routes,
    );
  }
}
