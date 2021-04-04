// Since it might be difficult to test static functions i decided to make this class
// function non-static, so that the class can be injected and later on Mock when we want to perform unit-testing

import 'package:blusalt_mini_app/di/injector_container.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.helper.dart';
import 'package:blusalt_mini_app/helpers/storage/storage.keys.dart';
import 'package:dio/dio.dart';

class HttpHelper {
  static Dio? _client;

  static Future<Dio> _getInstance() async {
    final storageToken = await StorageHelper.getString(StorageKeys.token);

    if (_client == null) _client = await injector.getAsync<Dio>();

    Map<String, dynamic> headers = {};
    headers['Content-Type'] = 'application/json';
    headers['Authorization'] = 'Token $storageToken';

    _client!.options.headers = headers;

    return _client!;
  }

  Future<Response> get(String url) async {
    final instance = await _getInstance();
    return instance.get(url);
  }

  Future<Response> post(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.post(url, data: body);
  }

  Future<Response> put(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.put(url, data: body);
  }

  Future<Response> delete(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.delete(url);
  }
}
