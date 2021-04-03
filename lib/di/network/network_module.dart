import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:blusalt_mini_app/data/network/model/user_response.dart';
import 'package:blusalt_mini_app/data/network/service/user/user_service.dart';
import 'package:blusalt_mini_app/helpers/http/http.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> init(GetIt injector) async {
  injector.registerFactoryAsync(
    () async {
      final Dio dioClient = Dio();
      final storageToken = await StorageHelper.getString(StorageKeys.token);

      Map<String, dynamic> headers = {};
      headers['Content-Type'] = 'application/json';
      if (storageToken != null)
        headers['Authorization'] = 'Bearer $storageToken';

      dioClient.options.headers = headers;

      return dioClient;
    },
  );

  injector.registerLazySingleton(() => HttpHelper());

  injector.registerFactoryAsync<UserResponse>(
    () async {
      String? token = await StorageHelper.getString(StorageKeys.token);
      var dummyUser = getDummyUser()
          .copyWith(id: 'anonymous', firstname: 'Anonymous', lastname: '');
      if (token == null)
        return dummyUser;
      else {
        return await _makeRequestToGetUser(injector, token, dummyUser);
      }
    },
  );
}

Future _makeRequestToGetUser(
    GetIt injector, String token, UserResponse dummyUser) async {
  RequestState response = await injector.get<UserService>().getUser(token);
  if (response is SuccessState)
    return response.value;
  else if (response is ErrorState) {
    return dummyUser;
  }
  return dummyUser;
}
