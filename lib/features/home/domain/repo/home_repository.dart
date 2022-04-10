import 'package:damazzle/core/CoreModels/base_result_model.dart';
import 'package:damazzle/core/data_source/remote_data_source.dart';
import 'package:damazzle/core/http/api_url.dart';
import 'package:damazzle/core/http/http_method.dart';
import 'package:damazzle/features/home/data/profile_details_response.dart';
import 'package:damazzle/features/home/data/refresh_request_model.dart';
import 'package:damazzle/features/home/data/refresh_response_model.dart';

class HomeRepository{
  static Future<BaseResultModel> refreshToken(
      RefreshRequestModel refreshRequestModel) async {
    return await RemoteDataSource.request<RefreshResponseModel>(
        converter: (json) => RefreshResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          "access_token":refreshRequestModel.accessToken,
        },
        withAuthentication: true,
        url: ApiURLs.RefreshToken);
  }
  static Future<BaseResultModel> getProfileDetails(
       ) async {
    return await RemoteDataSource.request<ProfileDetailsResponseModel>(
        converter: (json) => ProfileDetailsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: false,
        url: ApiURLs.ME);
  }

}