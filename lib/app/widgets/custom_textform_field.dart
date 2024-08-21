import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';


class CustomTextFormField extends StatefulWidget {
  final String? hint;
  final double? height;
  final String? label;
  final Color? borderColor;
  final Color? hintColor;
  final bool? isPasswordField;
  final TextStyle? textStyle;
  final Function(String? value)? onChange;
  final TextInputType? keyboardType;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefix;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final String? text;
  final bool? showBorder;
  final bool? isDense;
  final Key? key;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final Future<String?> Function(String?)? asyncValidator;
  final Widget? suffix;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorderType? borderType;
  final EdgeInsetsGeometry? padding;
  bool obscureText;
  bool isPassword;
  final Color? containerColor;
  final double? minWidth;

  CustomTextFormField(
      {this.hint,
        this.isPasswordField,
        required this.obscureText,
        this.isPassword = false,
        this.onChange,
        this.height,
        this.padding,
        this.keyboardType,
        this.prefix,
        this.controller,
        this.onTap,
        this.readOnly,
        this.fillColor,
        this.maxLines,
        this.text,
        this.showBorder,
        this.minLines,
        this.margin,
        this.suffix,
        this.validator,
        this.isDense,
        this.onFieldSubmitted,
        this.asyncValidator,
        this.label,
        this.key,
        this.textStyle,
        this.border,
        this.enabledBorder,
        this.hintColor,
        this.borderType,
        this.focusNode,
        this.borderColor,
        this.containerColor, this.minWidth})
      : super(key: key);

  final _state = _CustomTextFormFieldState();

  @override
  _CustomTextFormFieldState createState() {
    return _state;
  }

}

enum InputBorderType { outline, underline }

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  // late bool _isHidden;
  String text = "";
  bool isPasswordField = false;
  var isValidating = false;
  var isValid = false;
  var isDirty = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {

    return Container(
      // padding: EdgeInsets
      //     .only(top: 2.sp),
      margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 5.0.h),
      height: widget.height,
      decoration: BoxDecoration(
        color: VoidColors.lightGrey,
        borderRadius: BorderRadius.circular(16.0.r),
      ),
      child: TextFormField(
        obscureText: widget.obscureText ? true : false,
        key: widget.key,
        style: widget.textStyle ?? TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: VoidColors.blackColor,
        ),
        onTap: widget.onTap,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        initialValue: widget.controller == null ? widget.text : null,
        onFieldSubmitted: widget.onFieldSubmitted,
        focusNode: widget.focusNode,
        enabled: widget.keyboardType != TextInputType.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder( borderSide: BorderSide(color:
          VoidColors.secondary, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: VoidColors.secondary, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          errorStyle: const TextStyle(height: 0.2),
          prefixIcon: widget.prefix ?? const SizedBox(),
          prefixIconConstraints: BoxConstraints(
            minWidth: widget.prefix != null ? 50.w : 15.w,
            // minHeight: 24.sp,
          ),
          hintText: widget.hint,
          labelText: widget.label,
          // labelStyle: TextStyle(color: greyColor, fontSize: 10.sp, fontWeight: FontWeight.w400),
          isDense: widget.isDense,

          fillColor: widget.fillColor ??
              VoidColors.lightGrey,
          filled: widget.fillColor != null,
          suffixIconConstraints: BoxConstraints(minWidth: widget.minWidth ?? 50.sp),
          suffixIcon: widget.isPassword ?
          GestureDetector(
            onTap: () {
              setState(() {
                widget.obscureText = !widget.obscureText;
              });
            },
            child: Container(
                padding: EdgeInsets.all(15.w),
                child: Icon(widget.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 24.sp,)
            ),
          ) :
          widget.suffix ?? SizedBox(),
          hintStyle: TextStyle(
              color: widget.hintColor ?? VoidColors.darkGrey,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500),
          contentPadding: widget.padding ??
              EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
