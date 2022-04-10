import 'package:bloc/bloc.dart';
import 'package:damazzle/core/CoreModels/base_response_model.dart';
import 'package:damazzle/core/CoreModels/empty_model.dart';
import 'package:damazzle/core/errors/base_error.dart';
import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:damazzle/features/user/data/edit_profile_model.dart';
import 'package:damazzle/features/user/data/login_request_model.dart';
import 'package:damazzle/features/user/data/login_response_model.dart';
import 'package:damazzle/features/user/data/logout_request_model.dart';
import 'package:damazzle/features/user/domain/repo/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());



  Future<void> login(LoginRequestModel loginRequestModel) async {
    emit(LoginLoading());

    var response = await UserRepository.login(loginRequestModel);
    if (response is LoginResponseModel) {
      AppSharedPreferences.accessPhone = response.me.phone;
      AppSharedPreferences.accessEmail = response.me.email;
      AppSharedPreferences.accessName = response.me.name;
      AppSharedPreferences.accessToken = response.accessToken;
      AppSharedPreferences.refreshToken = response.refreshToken;
      AppSharedPreferences.accessExpire=response.accessExpiresAt;

      emit(LoginSuccessfully(message: "login"));
    } else if (response is BaseError) {
      print("messaggeeeeeeeee${response.message}");
      emit(LoginError(message: response.message));
    } else if (response is Message) {
      emit(LoginError(message: response.content));
    }
  }



  Future<void> editProfile(EditProfileRequestModel editProfileRequestModel) async {
    emit(EditLoading());

    var response = await UserRepository.editProfile(editProfileRequestModel);
    if (response is EmptyModel) {
      emit(EditSuccessfully(message: "Edit Done"));
    } else if (response is BaseError) {
      emit(EditError(message: response.message));
    } else if (response is Message) {
      emit(EditError(message: response.content,statusCode:response.code ));
      print(response.code);
    }
  }

  Future<void> logout(LogoutRequestModel logoutRequestModel) async {
    emit(LogoutLoading());

    var response = await UserRepository.logout(logoutRequestModel);
    if (response is EmptyModel) {
      emit(LogoutSuccessfully(message: "Logout Done"));
    } else if (response is BaseError) {
      print("messaggeeeeeeeee${response.message}");
      emit(LogoutError(message: response.message));
    } else if (response is Message) {
      emit(LogoutError(message: response.content));
    }
  }
}
