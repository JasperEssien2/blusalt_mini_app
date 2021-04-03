import 'package:blusalt_mini_app/styles/theme.dart';
import 'package:blusalt_mini_app/utils/home_widget_util.dart';
import 'package:blusalt_mini_app/views/routes/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  Widget homeWidget = await HomeWidgetUtil.getHomeWidget();
  runApp(MyApp(homeWidget));
}

class MyApp extends StatelessWidget {
  final Widget homeWidget;
  MyApp(this.homeWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(context, false),
      darkTheme: appTheme(context, true),
      home: homeWidget,
      routes: Routes.routes,
    );
  }
}
