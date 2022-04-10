
import 'package:damazzle/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../main.dart';





showSnackBar(String message){
  ScaffoldMessenger.of(MyApp.navigatorKey.currentContext).hideCurrentSnackBar();
  ScaffoldMessenger.of(MyApp.navigatorKey.currentContext)
      .showSnackBar(snackBar(message.toString()));
}
snackBar(String message){
  return SnackBar(
    elevation: 25,
    backgroundColor: Colors.white,
    duration: Duration(milliseconds: 3000),
    shape: RoundedRectangleBorder(side: BorderSide(color: DamazzleColors.darkOrange,width: 2.0),/*borderRadius: BorderRadius.circular(5.0.sp)*/),
    content: Text(message,style: TextStyle(
      fontFamily: 'TAHOMA',

      fontWeight: FontWeight.bold,
      fontSize: 14.0.sp,
      letterSpacing: 0.4,
      height: 0.9,
      color: DamazzleColors.darkOrange,
    ),),
    action: SnackBarAction(
      label: 'Close',
      textColor: DamazzleColors.accentOrange,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}