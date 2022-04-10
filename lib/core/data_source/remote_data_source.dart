import 'package:damazzle/core/CoreModels/base_result_model.dart';
import 'package:damazzle/core/constants/constants.dart';
import 'package:damazzle/core/errors/unauthorized_error.dart';
import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../http/api_provider.dart';

class RemoteDataSource {
  static Future<BaseResultModel> request<Response extends BaseResultModel>(
      {@required Response Function(Map<String, dynamic> json) converter,
      @required String method,
      @required String url,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> data,
      Map<String, String> files,
      bool withAuthentication = true,
      CancelToken cancelToken,
      bool isLongTime = false}) async {
    assert(converter != null);
    assert(method != null);
    assert(url != null);

    Map<String, String> headers = {
      HEADER_CONTENT_TYPE: "application/json",
      HEADER_ACCEPT: "application/json",
      PLATFORM:"web",
      APP_SECRET:"*(3%13@Uh@1",

      'Authorization':withAuthentication? 'Bearer ${AppSharedPreferences.refreshToken}':'Bearer ${AppSharedPreferences.accessToken}',

    };
    // if (withAuthentication) {
    //   if (AppSharedPreferences.accessToken != null)
    //     headers.putIfAbsent(HEADER_AUTH, () => ('bearer ${AppSharedPreferences.accessToken}'));
    //   else{
    //     logOut();
    //     return UnauthorizedError();
    //   }

    //
    // }

    // Send the request.
    final response = await ApiProvider.sendObjectRequest<Response>(
      method: method,
      url: url,
      converter: converter,
      headers: headers,
      queryParameters: queryParameters ?? {},
      data: data ?? {},
      files: files,
      isLongTime: isLongTime,
      cancelToken: cancelToken,
    );

    if (response.statusCode==200) {
      return response.data;
    } else {
      if (response.message != null) {
        return response.message;
      }
    }
  }

  static logOut() {
    AppSharedPreferences.clearForLogOut();
  }
}
