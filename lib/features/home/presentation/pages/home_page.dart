import 'package:damazzle/core/constants/app_assets.dart';
import 'package:damazzle/core/constants/app_form.dart';
import 'package:damazzle/core/constants/colors.dart';
import 'package:damazzle/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:damazzle/features/home/data/refresh_request_model.dart';
import 'package:damazzle/features/home/domain/home_cubit.dart';
import 'package:damazzle/features/user/data/edit_profile_model.dart';
import 'package:damazzle/features/user/data/logout_request_model.dart';
import 'package:damazzle/features/user/domain/cubit/user_cubit.dart';
import 'package:damazzle/features/user/presentation/pages/login.dart';
import 'package:damazzle/features/user/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:residemenu/residemenu.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  MenuController _menuController;
  PageController ctrl;
  double pageOffset = 0.0;
  double viewportFraction = 0.8;
  TextEditingController editName = TextEditingController();
  bool isEmail = true;
  bool isError = false;
  UserCubit cubit = UserCubit();
  HomeCubit homeCubit = HomeCubit();


  @override
  void initState() {
    homeCubit..getProfileDetails();
    HomeCubit.checkTime();
    if (HomeCubit.checkTime() < 30) {
      HomeCubit.refreshToken(
          RefreshRequestModel(accessToken: AppSharedPreferences.accessToken));
    }

    _menuController = MenuController(
      vsync: this,
    );
    super.initState();
    print('access Token ${AppSharedPreferences.accessToken}');
  }

  @override
  Widget build(BuildContext context) {
    String name = AppSharedPreferences.accessName;
    return ResideMenu.scaffold(
      enableFade: false,
      leftScaffold: MenuScaffold(
        footer: Padding(
          padding: EdgeInsets.only(top: 10.0.h, right: 5.0.w, left: 5.0.w),
          child: _buildConsumerLogout(),
        ),
        itemExtent: 30.0.sp,
        children: [
          SizedBox(
            height: 0.5.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.0.w, left: 5.0.w),
            child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                child: Text(
                  "PROFILE",
                  style: TextStyle(
                      color: DamazzleColors.orange,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0.sp),
                )),
          ),
          SizedBox(height: 5.0.h,),
            MaterialButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              child: AppForm(
                isForEdit: true,
                hint: "NAME",
                controller: editName,
                isSecure: false,
                textInputType: TextInputType.name,
              ),
            ),

          SizedBox(
            height: 1.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0.w, left: 30.0.w),
            child: _buildConsumerEdit(),
          ),
          SizedBox(
            height: 1.0.h,
          ),



              _buildConsumerProfileDetails(true),


          SizedBox(
            height: 1.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0.w, left: 0.0.w),
            child: _buildConsumerProfileDetails(false),
          ),
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
        ]),
      ),
      controller: _menuController,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                height: 100.0.h,
                width: 100.0.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppAssets.background),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 80.0.w,
                            child: Image.asset(AppAssets.logo2),
                          ),
                          SizedBox(
                            height: 10.0.h,
                          ),
                          Container(
                            width: 60.0.w,
                            height: 30.0.h,
                            child: Image.asset(AppAssets.homeLogo),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Text(
                            "HEllO $name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          InkWell(
                            onTap: () {
                              print('access Token ${AppSharedPreferences
                                  .accessToken}');
                              print('refresh Token ${AppSharedPreferences
                                  .refreshToken}');
                              _menuController.openMenu(true);
                            },
                            child: Container(
                              width: 50.0.w,
//                height: 8.0.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 1.0.h),
                              child: Center(
                                child: Text(
                                  "EDIT PROFILE",
                                  style: TextStyle(
                                      color: DamazzleColors.orange,
                                      fontSize: 14.0.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "OR SWIPE RIGHT TO EDIT",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.0.sp),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  _buildConsumerEdit() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        listener: (context, state) {
          print(state);
          if (state is EditError) {
            if (state.statusCode == 401) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            } else
              showSnackBar(state.message);
          } else if (state is EditSuccessfully) {
            showSnackBar("Edit Successfully");

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            );
            AppSharedPreferences.accessName = editName.text;
          }
        },
        builder: (context, state) {
          if (state is EditLoading)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: DamazzleColors.darkOrange,
                valueColor:
                AlwaysStoppedAnimation<Color>(DamazzleColors.accentOrange),
              ),
            );
          else
            return MaterialButton(
              onPressed: () {
                print("object");
              },
              child: InkWell(
                onTap: () {
                  print('access Token ${AppSharedPreferences.accessToken}');
                  _onPressEditButton();
                },
                child: Container(
                  width: 30.0.w,
//
                  decoration: BoxDecoration(
                    color: DamazzleColors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.0.h),
                  child: Center(
                    child: Text(
                      "EDIT",
                      style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
                    ),
                  ),
                ),
              ),
            );
        });
  }

  bool isName(String em) {
    String p = '[A-Za-z\u0621-\u064a-\ ]';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  String validate() {
    String validate;
    List<String> listValid = List();
    if (!isName(editName.text)) {
      listValid.add("please enter real name");
      listValid.add("\n");
    }
    if (listValid.isEmpty)
      return "";
    else {
      validate = listValid.join();
    }
    return validate;
  }

  _onPressEditButton() {
    print(AppSharedPreferences.accessToken);
    String v = validate();
    if (v != "") {
      showSnackBar(v);
    } else
      cubit.editProfile(EditProfileRequestModel(name: editName.text));
  }

  _buildConsumerProfileDetails(bool isEmail) {
    // if(HomeCubit.checkTime()<30){
    //   HomeCubit.refreshToken(RefreshRequestModel(accessToken: AppSharedPreferences.accessToken));
    // }
    return BlocConsumer<HomeCubit, HomeState>(
        bloc: homeCubit,
        listener: (context, state) {
          print(state);
          if (state is GetDetailsError) {
            return MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                child: AppForm(
                  isForm: false,
                  profileDetails: isEmail
                      ? AppSharedPreferences.accessEmail
                      : AppSharedPreferences.accessPhone,
                  isForEdit: true,
                ) );

                } else
                if (state is GetDetailsSuccessfully)
            {
              AppSharedPreferences.accessEmail =
                  state.profileDetailsResponseModel.email;
              AppSharedPreferences.accessPhone =
                  state.profileDetailsResponseModel.phone;
            }
          },
        builder: (context, state) {
          if (state is GetDetailsLoading)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: DamazzleColors.darkOrange,
                valueColor:
                AlwaysStoppedAnimation<Color>(DamazzleColors.accentOrange),
              ),
            );
          else if (state is GetDetailsSuccessfully) {
            return MaterialButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              child: AppForm(
                isForm: false,
                profileDetails: isEmail ? state.profileDetailsResponseModel
                    .email : state.profileDetailsResponseModel.phone,
                isForEdit: true,
              ),
            );
          }
          if (state is GetDetailsError) {
            return MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                child: AppForm(
                  isForm: false,
                  profileDetails: isEmail
                      ? AppSharedPreferences.accessEmail
                      : AppSharedPreferences.accessPhone,
                  isForEdit: true,
                ) );

          }
          return SizedBox.shrink();
        });
  }

  _buildConsumerLogout() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        listener: (context, state) {
          print(state);
          if (state is LogoutError) {
            showSnackBar(state.message);
          } else if (state is LogoutSuccessfully) {
            showSnackBar("Logout Successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => LogIn(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LogoutLoading)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: DamazzleColors.darkOrange,
                valueColor:
                AlwaysStoppedAnimation<Color>(DamazzleColors.accentOrange),
              ),
            );
          else
            return MaterialButton(
              onPressed: () {},
              child: InkWell(
                onTap: () {
                  _onPressLogoutButton();
                  AppSharedPreferences.clearForLogOut();
                },
                child: Container(
                  width: 30.0.w,
                  decoration: BoxDecoration(
                    color: DamazzleColors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.0.h),
                  child: Center(
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
                    ),
                  ),
                ),
              ),
            );
        });
  }

  _onPressLogoutButton() {
    cubit.logout(
        LogoutRequestModel(accessToken: AppSharedPreferences.accessToken));
  }
}
