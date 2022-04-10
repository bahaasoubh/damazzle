import 'dart:convert';
import 'dart:io';
import 'package:damazzle/core/CoreModels/base_response_model.dart';
import 'package:damazzle/core/CoreModels/base_result_model.dart';
import 'package:damazzle/core/constants/constants.dart';
import 'package:damazzle/core/errors/HttpMethodUnCorrect.dart';
import 'package:damazzle/core/errors/bad_request_error.dart';
import 'package:damazzle/core/errors/base_error.dart';
import 'package:damazzle/core/errors/cancel_error.dart';
import 'package:damazzle/core/errors/conflict_error.dart';
import 'package:damazzle/core/errors/forbidden_error.dart';
import 'package:damazzle/core/errors/http_error.dart';
import 'package:damazzle/core/errors/internal_server_error.dart';
import 'package:damazzle/core/errors/net_error.dart';
import 'package:damazzle/core/errors/not_found_error.dart';
import 'package:damazzle/core/errors/socket_error.dart';
import 'package:damazzle/core/errors/timeout_error.dart';
import 'package:damazzle/core/errors/unauthorized_error.dart';
import 'package:damazzle/core/errors/unknown_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


 class ApiProvider {

  static Future<BaseResponseModel> sendObjectRequest<T extends BaseResultModel>({
    @required T Function(Map<String, dynamic>) converter,
    @required String method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    Map<String,String> files,
    CancelToken cancelToken,
    bool isLongTime = false
  }) async {
    assert(method != null);
    assert(url != null);

    var baseOptions =  BaseOptions(
        // connectTimeout: isLongTime? 30 *1000 : 15 *1000,
        connectTimeout: 1000 * 100,
    );

    Options options =Options(headers: headers,
    method: method ,
      contentType: Headers.jsonContentType,
      sendTimeout: 4000,
    );

    if(files != null)
    {
      headers.remove(HEADER_CONTENT_TYPE);
      if(data == null)
        data = Map();

      await Future.forEach(files.entries, (MapEntry entry) async {
        if(entry.value != null || entry.key != null)
          {
            data.addAll({
              entry.key: await MultipartFile.fromFile(entry.value)
            });
          }
      });

    }
    try {

      Response response;
      response = await Dio(baseOptions).request(
           url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        data: files!= null? FormData.fromMap(data):data
      );
      // Get the decoded json
      var decodedJson;

      if (response.data is String )
       {
         if(response.data.length ==0)
           decodedJson={"":""};
         else
           decodedJson = json.decode(response.data);
       }
      else
        decodedJson = response.data;

      print(decodedJson);


      return BaseResponseModel.fromJson(json: decodedJson,fromJson: converter);
    }

    // Handling errors
    on DioError catch (e , s) {
      print('catch DioError ');
      print(e);

      print('Stacktrace DioError ');
      print(s);
     var error = _handleDioError(e);
      var json ;
      print('DioErrorDioErrorDioError $error');
      if(e.response!=null )
        if(e.response.data!=null)
          if(!(e.response.data is String))
           {
             //TODO error 405 //TODO yes
             //TODO error 401
             //TODO test successful == true and false

             print(e.response.data);
             json = e.response.data;
             // if(error is HttpMethodUnCorrect) {
             //   json = {"":""};
             //   }else if(error is InternalServerError){
             //   json = {"":""};
             // }else{
             //   json =e.response.data;
             // }
           }

      return BaseResponseModel.fromJson(json: json);
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return BaseResponseModel.fromJson();
    }
    catch(e , stacktrace) {
      print(e);
      print(stacktrace);
      return BaseResponseModel.fromJson();
    }
  }


  static BaseError _handleDioError(DioError error) {
    print('error.type = ${(error.type) }');
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.response) {
        switch (error.response.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 405:
            return HttpMethodUnCorrect();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    } else
      return UnknownError();
  }
}
