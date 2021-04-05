import 'dart:io';

import 'package:blusalt_mini_app/data/network/model/server_error_model.dart';
import 'package:blusalt_mini_app/data/network/model/state.dart';
import 'package:dio/dio.dart';

class SimplifyApiConsuming {
  SimplifyApiConsuming._();

  ///A more simplified method for making endpoint request call
  ///@param [requestFunction] a function passed, this function is the api call to execute
  ///@param [isStatusCode] a bool flag to indicate whether to equate response success with statusCode or with success string in response data
  ///@Param [statusCodeSuccess] an [int] status code to validate success of the request, if [isStatusCode] == true
  ///@Param [successResponse] a [Function] to execute if request is successful, must have a return statement
  /// Returns [Future<ResponseModel>]
  static Future<RequestState> simplifyEndpointConsumingReturn(
      Future<Response<dynamic>> Function() requestFunction,
      {bool isStatusCode = true,
      int statusCodeSuccess = 200,
      required RequestState Function(dynamic data) successResponse,
      RequestState Function(dynamic data)? errorResponse,
      RequestState Function(dynamic data)? dioErrorResponse,
      Function(int)? statusCode}) async {
    try {
      return await _makeRequest(
        requestFunction,
        isStatusCode,
        statusCodeSuccess,
        successResponse,
      );
    } on SocketException {
      return RequestState<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: 400,
            errorMessage:
                "Something went wrong please check your internet connection and try again",
            data: null),
      );
    } on DioError catch (e) {
      print("dio error request is ${e}");
      return _returnDioError(dioErrorResponse, e);
    } catch (error) {
      print('error --------------------- ${error.toString()}');
      return RequestState<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: 400, errorMessage: error.toString(), data: null),
      );
    }
  }

  static Future<RequestState> _makeRequest(
      Future<Response> requestFunction(),
      bool isStatusCode,
      int statusCodeSuccess,
      RequestState successResponse(dynamic data)) async {
    var response = await requestFunction();
    if (isStatusCode) {
      return _handleResponseBasedOnStatusCode(
          response, statusCodeSuccess, successResponse);
    } else {
      return _handleResponseBasedOnDataReturned(response, successResponse);
    }
  }

  static RequestState _handleResponseBasedOnStatusCode(Response response,
      int statusCodeSuccess, RequestState successResponse(dynamic data)) {
    if (response.statusCode == statusCodeSuccess) {
      if (response.data.containsKey('data'))
        return successResponse(response.data['data']);
      else
        return successResponse(response.data);
    } else {
      return RequestState<ServerErrorModel>.error(
        ServerErrorModel(
            statusCode: response.statusCode,
            errorMessage: response.statusMessage ??
                "Something went wrong please try again",
            data: response.data),
      );
    }
  }

  static RequestState _handleResponseBasedOnDataReturned(
      Response response, RequestState successResponse(dynamic data)) {
    if (response.data['status'] == 'success') {
      return successResponse(response.data);
    }
    return RequestState.error('An Error Occurred');
  }

  static RequestState _returnDioError(
      RequestState dioErrorResponse(dynamic data)?, DioError e) {
    return dioErrorResponse != null
        ? dioErrorResponse(e.response)
        : RequestState<ServerErrorModel>.error(
            ServerErrorModel(
                statusCode: 400,
                errorMessage: "Something went wrong please try again",
                data: null),
          );
  }
}
