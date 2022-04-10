import 'package:damazzle/core/constants/app_assets.dart';
import 'package:damazzle/core/constants/app_button.dart';
import 'package:damazzle/core/constants/app_form.dart';
import 'package:damazzle/core/constants/colors.dart';
import 'package:damazzle/features/home/presentation/pages/home_page.dart';

import 'package:damazzle/features/user/data/login_request_model.dart';
import 'package:damazzle/features/user/domain/cubit/user_cubit.dart';
import 'package:damazzle/features/user/presentation/widgets/painter.dart';
import 'package:damazzle/features/user/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormState> _formKeyName = GlobalKey();
  UserCubit cubit = UserCubit();
  bool isSecure = true;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocProvider(
          create: (context) => cubit,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 85.0.h,
                        child: CustomPaint(
                          painter: BackgroundPainter(
                            animation: _controller.view,
                          ),
                        ),
                      ),
                      Transform.translate(
                          offset: Offset(0, -30.0.h),
                          child: Container(
                            width: 70.0.w,
                            child: Image.asset(AppAssets.logo2),
                          )),
                      Transform.translate(
                        offset: Offset(0, -14.0.h),
                        child: Column(
                          children: [
                            Text(
                              "ENTER YOUR DETAILS",
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: DamazzleColors.darkOrange,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -6.0.h),
                        child: Form(
                          key: _formKey,
                          child: AppForm(
                            validator: (value) {
                              if (value.isEmpty || !value.contains("@")) {
                                return "Invalid email";
                              }
                              return null;
                            },
                            hint: "EMAIL",
                            controller: email,
                            isSecure: false,
                            textInputType: TextInputType.emailAddress,
                            onTap: () {
                              _controller.forward(from: 0);
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, 4.0.h),
                        child: Form(
                          key: _formKeyName,
                          child: AppForm(
                            hint: "PASSWORD",
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please Enter Your Name";
                              } else {
                                return null;
                              }
                            },
                            onTap: () {
                              _controller.forward(from: 0);
                            },
                            controller: password,
                            textInputType: TextInputType.name,
                            isSecure: isSecure,
                            suffix: isSecure == true
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isSecure = !isSecure;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: DamazzleColors.darkOrange,
                                    ))
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isSecure = !isSecure;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: DamazzleColors.darkOrange,
                                    )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildConsumerLogin(),
                ],
              ),
            ),
          )),
    ));
  }

  void submit() {
    if (!_formKeyName.currentState.validate()) {
      return;
    }
    if (!_formKey.currentState.validate()) {
      return;
    }
  }

  _buildConsumerLogin() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        listener: (context, state) {
          print(state);
          if (state is LoginError) {
            // print("messsssssage${state.message}");
            showSnackBar(state.message);
          } else if (state is LoginSuccessfully) {
            showSnackBar("Login Successfully");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginLoading)
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: DamazzleColors.darkOrange,
                valueColor:
                    AlwaysStoppedAnimation<Color>(DamazzleColors.accentOrange),
              ),
            );
          else
            return InkWell(
                onTap: () {
                  _onPressLoginButton();
                },
                child: AppButton(
                  onPress: () {
                    _onPressLoginButton();
                  },
                  rightColor: DamazzleColors.orange,
                  leftColor: DamazzleColors.accentOrange,
                  title: "LOGIN",
                ));
        });
  }

  _onPressLoginButton() {
    String v = validate();
    if (v != "") {
      showSnackBar(v);
    } else
      cubit
          .login(LoginRequestModel(email: email.text, password: password.text));
  }

  String validate() {
    String validate;
    List<String> listValid = List();
    if (!isEmail(email.text)) {
      listValid.add("please enter real email");
      listValid.add("\n");
    }

    if (password.text.isEmpty || password.text.length < 4) {
      listValid.add("password doesn't confirm");
      listValid.add("\n");
    }

    if (listValid.isEmpty)
      return "";
    else {
      validate = listValid.join();
    }
    return validate;
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
