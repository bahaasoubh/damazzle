import 'package:damazzle/core/CoreModels/base_result_model.dart';
import 'package:damazzle/core/CoreModels/empty_model.dart';
import 'package:damazzle/core/data_source/remote_data_source.dart';
import 'package:damazzle/core/http/api_url.dart';
import 'package:damazzle/core/http/http_method.dart';
import 'package:damazzle/features/user/data/edit_profile_model.dart';
import 'package:damazzle/features/user/data/login_request_model.dart';
import 'package:damazzle/features/user/data/login_response_model.dart';
import 'package:damazzle/features/user/data/logout_request_model.dart';

class UserRepository {
  static Future<BaseResultModel> login(
      LoginRequestModel loginRequestModel) async {
    return await RemoteDataSource.request<LoginResponseModel>(
        converter: (json) => LoginResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: loginRequestModel.toJson(),
        url: ApiURLs.LoginUSER);
  }

  static Future<BaseResultModel> editProfile(
      EditProfileRequestModel editProfileRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        withAuthentication: false,
        data: editProfileRequestModel.toJson(),
        url: ApiURLs.UpdateUser);
  }

  static Future<BaseResultModel> logout(
      LogoutRequestModel logoutRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "access_token":logoutRequestModel.accessToken,
        },
        url: ApiURLs.LogoutUser);
  }
}
