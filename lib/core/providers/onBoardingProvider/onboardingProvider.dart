// product_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dio/dio.dart';
import 'package:tezda/core/data/models/request/signUP.dart';
import 'package:tezda/core/data/models/response/defaultResponse.dart';
import 'package:tezda/core/data/models/response/signUpResponse.dart';
import 'package:tezda/core/service/apiStatus.dart';
import 'package:tezda/core/service/appUrl.dart';

import '../../data/models/request/loginRequest.dart';
import '../../data/models/response/loginResponse.dart';
import '../../service/apiService.dart';
import '../apiProvider/apiProvider.dart';

final onBoardingProvider = StateNotifierProvider<OnBoardingNotifier, Object>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return OnBoardingNotifier(apiService);
});

class OnBoardingNotifier extends StateNotifier<Object> {
  final ApiService apiService;

  OnBoardingNotifier(this.apiService) : super([]);

  Future<Object?> createUserAccount(SignUpRequest request) async {
    try {
      final response = await apiService.makeApiCall(request,AppUrl.signUp, baseUrl: AppUrl.baseurl,);
      if(response is Success){
        var r = signUpResponseFromJson(response.response as String);
        state =r;
        return r;
      }else if (response is Failure){
        print("I am hee oo");
        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        state = r;
        return r;
      }else{
        return null;
      }

    } catch (e, trace) {
      print('Error creating user: $e');
      print('Error trace: $trace');
    }
  }

  Future<Object?> logUserIn(LoginRequest request) async {
    try {
      final response = await apiService.makeApiCall(request,AppUrl.login, baseUrl: AppUrl.baseurl,requestType: HttpMethods.get);
      if(response is Success){
        var r = loginResponseFromJson(response.response as String);
        state =r;
        return r;
      }else if (response is Failure){

        var r = defaultErrorFormatFromJson(response.errorResponse as String);
        state = r;
        return r;
      }

    } catch (e, trace) {
      print('Error creating user: $e');
      print('Error trace: $trace');
    }
  }

}
