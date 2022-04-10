import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class AppButton extends StatelessWidget {
  String title;
  Function onPress;
  Color rightColor;
  Color leftColor;
  AppButton({@required this.title,@required this.onPress,this.leftColor,this.rightColor});
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 6.0.h,
        width: 30.0.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              rightColor,
              leftColor,
            ],
          ),
        ),
        child: MaterialButton(
          onPressed:
          onPress,

          child: Text(title,
            style: TextStyle(
                fontFamily: 'TAHOMA',
                fontWeight: FontWeight.bold,
                fontSize: 10.0.sp,
                color: Colors.white),
          ),
        ));
  }
}