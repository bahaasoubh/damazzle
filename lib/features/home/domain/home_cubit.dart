import 'package:bloc/bloc.dart';
import 'package:damazzle/core/CoreModels/base_response_model.dart';
import 'package:damazzle/core/errors/base_error.dart';
import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:damazzle/features/home/data/profile_details_response.dart';
import 'package:damazzle/features/home/data/refresh_request_model.dart';
import 'package:damazzle/features/home/data/refresh_response_model.dart';
import 'package:damazzle/features/home/domain/repo/home_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static int checkTime(){
    String presentTime=DateFormat('yyyy-MM-dd KK:mm:ss').format(DateTime.now());
    DateTime now=DateTime.parse(presentTime);
    DateTime accessTokenExpire=DateTime.parse(AppSharedPreferences.accessExpire);
    String accessTokenFormat=DateFormat('yyyy-MM-dd KK:mm:ss').format(accessTokenExpire);
    DateTime accessExpire=DateTime.parse(accessTokenFormat);
    int minutes= accessExpire.difference(now).inMinutes;
    print(minutes);
    return minutes;
  }
 static Future<void> refreshToken(RefreshRequestModel requestModel) async {
    var response = await HomeRepository.refreshToken(requestModel);
    if (response is RefreshResponseModel) {
      AppSharedPreferences.accessToken = response.accessToken;
      AppSharedPreferences.refreshToken = response.refreshToken;
      AppSharedPreferences.accessExpire=response.accessExpiresAt;
      if(response is RefreshSuccessfully){
        print(response);
      }

    } else if (response is BaseError) {
      print("messaggeeeeeeeee${response.message}");
    } else if (response is Message) {
      print("messaggeeeeeeeee${response.content}");
    }
  }
  Future<void> getProfileDetails() async {
    emit(GetDetailsLoading());

    var response = await HomeRepository.getProfileDetails();
    if (response is ProfileDetailsResponseModel) {
      emit(GetDetailsSuccessfully(profileDetailsResponseModel: response));
    } else if (response is BaseError) {
      emit(GetDetailsError(message: response.message));
    } else if (response is Message) {
      emit(GetDetailsError(message: response.content,statusCode:response.code ));
      print(response.code);
    }
  }


}
