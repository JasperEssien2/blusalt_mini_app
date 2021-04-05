import 'dart:io';

import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

Future<void> init(GetIt injector) async {
  await _injectDependenciesRelatedToHttpRequest(injector);

  await _injectDependencyRelatedToUser(injector);
}

Future _injectDependenciesRelatedToHttpRequest(GetIt injector) async {
  injector.registerFactoryAsync(
    () async {
      final Dio dioClient = Dio();
      await _addCookieCacheInterceptor(dioClient);
      final storageToken = await StorageHelper.getString(StorageKeys.token);
      Map<String, dynamic> headers = {};
      headers['Content-Type'] = 'application/json';
      dioClient.options.headers = headers;

      return dioClient;
    },
  );

  injector.registerLazySingleton(() => HttpHelper());
}

Future<void> _addCookieCacheInterceptor(Dio dioClient) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  var cookieJar =
      PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));
  dioClient.interceptors.add(CookieManager(cookieJar));
}

Future _injectDependencyRelatedToUser(GetIt injector) async {
  injector.registerFactoryAsync<UserResponse>(
    () async {
      String? id = await StorageHelper.getString(StorageKeys.ID);
      var dummyUser = getDummyUser()
          .copyWith(id: 'anonymous', firstname: 'Anonymous', lastname: '');
      if (id == null) {
        return dummyUser;
      } else {
        return await _makeRequestToGetUser(injector, id, dummyUser);
      }
    },
  );
}

Future<UserResponse> _makeRequestToGetUser(
    GetIt injector, String id, UserResponse dummyUser) async {
  RequestState response = await injector.get<AbstractUserService>().getUser(id);
  print(
      'MAKE REQUEST TO GET USER -------------------- RESPONSE: ${response.toString()}');
  if (response is SuccessState)
    return response.value;
  else if (response is ErrorState) {
    return dummyUser;
  }
  return dummyUser;
}
