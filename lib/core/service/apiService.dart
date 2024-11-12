// api_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../util/AppUtill.dart';
import 'apiStatus.dart';
String accessToken = "";

enum HttpMethods { post, put, patch, get, delete }


class ApiService {

  static Dio dio = Dio();

  static void initiateDio(bool requireAccess, String baseUrl) {
    dio.options
      ..baseUrl = baseUrl
      ..connectTimeout =Duration(seconds: 10)
      ..receiveTimeout =Duration(seconds: 10)
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = header(requireAccess);
    dio.interceptors.add(
      LogInterceptor(
          requestBody: true,
          responseBody: true
      ),
    );
  }

  static Map<String, String> header(bool requireAccess) {
    return requireAccess
        ? {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    }
        : {
      HttpHeaders.userAgentHeader: 'dio',
      'Content-Type': 'application/json',
      'Accept-Language': 'en-US,en;q=0.5',
      'Accept': 'application/json',
      'Connection':"keep-alive"
    };
  }
   Future<Object> makeApiCall(request,
      url,
      {bool requireAccess = true, HttpMethods requestType = HttpMethods.post,
        context,
        required String baseUrl,bool isFile=false,dynamic queryParameters}) async {
    initiateDio(requireAccess, baseUrl);
    try {
      Object? body;
      body = request != null ? json.encode(request.toJson()) : null;

      Response<String>? response;
      switch (requestType) {
        case HttpMethods.get:
          AppUtils.debug("trying a get request");
          if (request == null) {
            response = await dio.get(url);
          } else {
            print("req to send ${request.toJson}");
            response = await dio.get(url, queryParameters: request.toJson());
          }
          AppUtils.debug("method: get");
          break;
        case HttpMethods.post:
          response = await dio.post(url, data: body);
          AppUtils.debug("this is a POST request: $response");
          break;
        case HttpMethods.put:
          response = await dio.put(url, data: body);
          AppUtils.debug("this is a PUT request");
        case HttpMethods.patch:
          response = await dio.patch(url, data: body);
          AppUtils.debug("this is a PATCH request");
        case HttpMethods.delete:
          response = await dio.delete(url, data: body);
          AppUtils.debug("this is a DELETE request");
      }
      if (response.statusCode != null) {
        AppUtils.debug("api Url: $url");
        AppUtils.debug("status code: ${response.statusCode}");
        AppUtils.debug("response body: $body");
        if (response.statusCode == ApiResponseCodes.success||
            response.statusCode==ApiResponseCodes.create_success) {
          return Success(response.statusCode!, response.data as String);
        }else{
          if(response.statusCode == 404){
            AppUtils.showSnack("Account not found", context);
          }
          return Failure(response.statusCode!, response.data as String);
        }

      } else {
        return UnExpectedError();
      }
    } on DioError catch (e, trace) {

      return NetWorkFailure();
    }
  }
}