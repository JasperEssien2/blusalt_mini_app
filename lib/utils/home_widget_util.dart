import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:blusalt_mini_app/views/screens/authentication/authentication_fragment.dart';
import 'package:blusalt_mini_app/views/screens/authentication/widgets/login_card.dart';
import 'package:blusalt_mini_app/views/screens/homepage/home_page.dart';
import 'package:flutter/material.dart';

class HomeWidgetUtil {
  HomeWidgetUtil._();

  static Future<Widget> getHomeWidget() async {
    // Set default home.
    var loginCard = LoginCard();

    Widget defaultHome = AuthenticationPage(
      child: loginCard,
    );

    String? token = await StorageHelper.getString(StorageKeys.token);
    bool stayLoggedIn = token != null;

    UserResponse userResponse = await injector.getAsync<UserResponse>();

    if (!stayLoggedIn) {
      defaultHome = AuthenticationPage(child: loginCard);
    }

    if (stayLoggedIn) {
      if (userResponse.id == 'anonymous') {
        defaultHome = HomePage();
      } else {
        defaultHome = AuthenticationPage(child: loginCard);
      }
    }

    return defaultHome;
  }
}
