// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
//
// import 'package:sizer/sizer.dart';
//
// import 'login.dart';
//
// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// enum AuthMode { SignUp, Login }
//
// class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
//   AuthMode _authMode = AuthMode.Login;
//   AnimationController _controller;
//   TextEditingController name = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController rewritePassword = TextEditingController();
//   final GlobalKey<FormState> _formKeyEmail = GlobalKey();
//   final GlobalKey<FormState> _formKeyPassword = GlobalKey();
//   final GlobalKey<FormState> _formKeyRePassword = GlobalKey();
//   final GlobalKey<FormState> _formKeyName = GlobalKey();
//   Map<String, String> _authData = {'email': ''};
//   bool isSeen = true;
//   bool isSeen2 = true;
//   bool isDataCorrect=true;
//
//   void switchAuthMode() {
//     if (_authMode == AuthMode.Login) {
//       setState(() {
//         _authMode = AuthMode.SignUp;
//       });
//     } else {
//       setState(() {
//         _authMode = AuthMode.Login;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     _controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 2));
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   UserCubit cubit = UserCubit();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: BlocProvider(
//         create: (context) => cubit,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     child: CustomPaint(
//                       painter: BackgroundPainter2(
//                         animation: _controller.view,
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                       offset: Offset(0, -40.0.h),
//                       child: Text(
//                         "QUREOS",
//                         style: AppStyles.title,
//                       )),
//                   Transform.translate(
//                     offset: Offset(0, -26.0.h),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "HELLO FRIEND",
//                           style: TextStyle(
//                               fontSize: 18.0.sp,
//                               fontWeight: FontWeight.bold,
//                               color: QureosColors.darkBlue,
//                               letterSpacing: 1),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           "!",
//                           style: TextStyle(
//                               fontSize: 18.0.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.orangeAccent,
//                               letterSpacing: 1),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, -18.0.h),
//                     child: Text(
//                       "CREATE ACCOUNT",
//                       style: TextStyle(
//                           fontSize: 10.0.sp,
//                           fontWeight: FontWeight.bold,
//                           color: QureosColors.darkBlue,
//                           letterSpacing: 1),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, -10.0.h),
//                     child: Form(
//                       key: _formKeyName,
//                       child: AppForm(
//                         hint: "NAME",
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return "Please Enter Your Name";
//                           } else {
//                             return null;
//                           }
//                         },
//                         onTap: () {
//                           _controller.forward(from: 0);
//                         },
//                         controller: name,
//                         textInputType: TextInputType.name,
//                         isSecure: false,
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 0.0.h),
//                     child: Form(
//                       key: _formKeyEmail,
//                       child: AppForm(
//                         validator: (value) {
//                           if (value.isEmpty || !value.contains("@")) {
//                             return "Invalid email";
//                           }
//                           return null;
//                         },
//                         hint: "EMAIL",
//                         controller: email,
//                         isSecure: false,
//                         textInputType: TextInputType.emailAddress,
//                         onTap: () {
//                           _controller.forward(from: 0);
//                         },
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 10.0.h),
//                     child: Form(
//                       key: _formKeyPassword,
//                       child: Container(
//                         width: 80.0.w,
//                         height: 8.0.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(100),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 8,
//                               offset:
//                                   Offset(0, 1), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 5.0.w,
//                               right: 5.0.w,
//                               top: 0.4.h,
//                               bottom: 0.5.h),
//                           child: TextFormField(
//                             onTap: () {
//                               _controller.forward(from: 0);
//                             },
//                             keyboardType: TextInputType.emailAddress,
//                             controller: password,
//                             obscureText: isSeen2,
//                             validator: (value) {
//                               if (value.isEmpty || value.length <= 5) {
//                                 return "Password is too short";
//                               }
//                               return null;
//                             },
//                             // onSaved: (value) {
//                             //   _authData['email'] = value;
//                             // },
//                             decoration: InputDecoration(
//                               hintText: "PASSWORD",
//                               hintStyle: TextStyle(
//                                 fontSize: 8.0.sp,
//                                 color: Colors.grey,
//                                 // fontWeight: FontWeight.w300,
//                               ),
//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     isSeen2 = !isSeen2;
//                                   });
//                                 },
//                                 child: isSeen2
//                                     ? Icon(Icons.visibility_off,
//                                         color: Colors.orangeAccent)
//                                     : Icon(
//                                         Icons.remove_red_eye,
//                                         color: Colors.orangeAccent,
//                                       ),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(4.0),
//                                   topRight: Radius.circular(4.0),
//                                 ),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                 ),
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(4.0),
//                                   topRight: Radius.circular(4.0),
//                                 ),
//                               ),
//                             ),
//                             style: TextStyle(
//                               fontSize: 12.0.sp,
//                               color: Color(0xFF606060),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 20.0.h),
//                     child: Form(
//                       key: _formKeyRePassword,
//                       child: Container(
//                         width: 80.0.w,
//                         height: 8.0.h,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(100),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 2,
//                               blurRadius: 8,
//                               offset:
//                                   Offset(0, 1), // changes position of shadow
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: 5.0.w,
//                               right: 5.0.w,
//                               top: 0.4.h,
//                               bottom: 0.5.h),
//                           child: TextFormField(
//                             onTap: () {
//                               _controller.forward(from: 0);
//                             },
//                             keyboardType: TextInputType.emailAddress,
//                             controller: rewritePassword,
//                             obscureText: isSeen,
//
//                             validator: (value) {
//                               if (value != password.text) {
//                                 return "Password do not match!";
//                               }
//                               return null;
//                             },
//                             // onSaved: (value) {
//                             //   _authData['email'] = value;
//                             // },
//                             decoration: InputDecoration(
//                               hintText: "REWRITE PASSWORD",
//                               hintStyle: TextStyle(
//                                 fontSize: 8.0.sp,
//                                 color: Colors.grey,
//
//                                 // fontWeight: FontWeight.w300,
//                               ),
//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     isSeen = !isSeen;
//                                   });
//                                 },
//                                 child: isSeen
//                                     ? Icon(Icons.visibility_off,
//                                         color: Colors.orangeAccent)
//                                     : Icon(
//                                         Icons.remove_red_eye,
//                                         color: Colors.orangeAccent,
//                                       ),
//                               ),
//                               enabledBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(4.0),
//                                   topRight: Radius.circular(4.0),
//                                 ),
//                               ),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                 ),
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(4.0),
//                                   topRight: Radius.circular(4.0),
//                                 ),
//                               ),
//                             ),
//                             style: TextStyle(
//                               fontSize: 12.0.sp,
//                               color: Color(0xFF606060),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 30.0.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "HAVE ACCOUNT !",
//                           style: TextStyle(
//                               color: QureosColors.darkBlue, fontSize: 8.0.sp),
//                         ),
//                         MaterialButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LogIn()));
//                           },
//                           child: Text(
//                             "LOGIN",
//                             style: TextStyle(
//                                 color: Colors.orangeAccent, fontSize: 8.0.sp),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Transform.translate(
//                       offset: Offset(0, 35.0.h), child: _buildConsumerRegister()),
//                 ],
//               ),
//               SizedBox(
//                 height: 1.0.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
//
//   bool submit() {
//     if (!_formKeyName.currentState.validate()) {
//       return false;
//     }
//     if (!_formKeyEmail.currentState.validate()) {
//       return false;
//     }
//
//     if (!_formKeyPassword.currentState.validate()) {
//       return false;
//     }
//     if (!_formKeyRePassword.currentState.validate()) {
//       return false;
//     }
//   }
//
//   _buildConsumerRegister() {
//     return BlocConsumer<UserCubit, UserState>(
//         bloc: cubit,
//         listener: (context, state) {
//           print(state);
//           if (state is RegisterError) {
//             // print("messsssssage${state.message}");
//             showSnackBar(state.message);
//           } else if (state is RegisterSuccessfully) {
//         submit()? showSnackBar("Register Successfully"):SizedBox.shrink();
//             if(submit()!=false){
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => HomePage(
//                           userEmail: email.text,
//                         )));
//           }
//             else{
//               showSnackBar("Please Enter Correct Data");
//             }}
//
//         },
//         builder: (context, state) {
//           if (state is RegisterLoading)
//             return Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: QureosColors.darkBlue,
//                 valueColor:
//                     AlwaysStoppedAnimation<Color>(QureosColors.whiteBlue),
//               ),
//             );
//           else
//             return InkWell(
//               onTap: () {
//                 submit();
//                 _onPressRegisterButton();
//               },
//               child: Container(
//                 width: 36.0.w,
//                 height: 10.0.h,
//                 child: Image.asset(
//                   AppAssets.signUp,
//                 ),
//               ),
//             );
//         });
//   }
//
//   _onPressRegisterButton() {
//     cubit..register(RegisterRequestModel(
//         email: email.text,
//         password: password.text,
//         fullName: name.text,
//         passwordConfirmation: rewritePassword.text));
//   }
// }
