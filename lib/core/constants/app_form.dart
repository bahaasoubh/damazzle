import 'package:damazzle/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppForm extends StatefulWidget {
  FormFieldValidator validator;
  Function onTap;
  TextInputType textInputType;
  final String icon;
  TextEditingController controller;
  bool isForEdit;
  String profileDetails;
  bool isForm;
  String hint;
  bool isSecure;
  final bool isSuffixIcon;
  final Function isSuffixIconClick;
  final Widget suffix;

  AppForm(
      {this.validator,
      this.hint,
      this.isForEdit = false,
      this.textInputType,
      this.controller,
      this.profileDetails,
      this.onTap,
      this.isSecure = false,
      this.isSuffixIcon = false,
      this.isForm = true,
      this.isSuffixIconClick,
      this.icon,
      this.suffix});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isForEdit ? 80.0.w : 90.0.w,
      height: widget.isForEdit ? 6.0.h : 8.0.h,
      decoration: BoxDecoration(
        color: widget.isForEdit ? DamazzleColors.orange : Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 5.0.w, right: 5.0.w, top: 0.4.h, bottom: 0.5.h),
        child: widget.isForm
            ? TextFormField(
                onChanged: (e) {},
                validator: widget.validator,
                readOnly: widget.isSuffixIcon ? true : false,
                onTap: widget.onTap,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                obscureText: widget.isSecure,
                cursorColor:
                    widget.isForEdit ? Colors.white : DamazzleColors.darkOrange,
                decoration: InputDecoration(
                  suffixIcon: widget.suffix,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    fontSize: 8.0.sp,
                    color: widget.isForEdit ? Colors.white : Colors.grey,
                  ),
                ),
                style: TextStyle(
                  fontSize: 12.0.sp,
                  color:
                      widget.isForEdit ? Colors.white : DamazzleColors.orange,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Center(child:Text(
                widget.profileDetails,
                style: TextStyle(
                  fontSize: 9.0.sp,
                  color:
                      widget.isForEdit ? Colors.white : DamazzleColors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
      ),
    );
  }
}
