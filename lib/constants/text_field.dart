import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/color_constant.dart';
import '../constants/sizeConstant.dart';

TextFormField getTextField({
  String? hintText,
  String? labelText,
  TextEditingController? textEditingController,
  Widget? prefixIcon,
  double? borderRadius,
  Widget? suffixIcon,
  double? size = 70,
  Widget? suffix,
  Color? borderColor,
  Color? fillColor,
  bool isFilled = false,
  Color? labelColor,
  TextInputType textInputType = TextInputType.name,
  TextInputAction textInputAction = TextInputAction.next,
  bool textVisible = false,
  bool readOnly = false,
  bool expands = false,
  VoidCallback? onTap,
  int maxLine = 1,
  int minLine = 1,
  String errorText = "",
  FocusNode? focusNode,
  Function(String)? onChange,
  Function(String)? onSubmit,
  FormFieldValidator<String>? validation,
  double fontSize = 15,
  double hintFontSize = 14,
  TextCapitalization textCapitalization = TextCapitalization.none,
}) {
  return TextFormField(
    controller: textEditingController,
    obscureText: textVisible,
    textInputAction: textInputAction,
    keyboardType: textInputType,
    expands: expands,
    textCapitalization: textCapitalization,
    focusNode: focusNode,
    cursorColor: appTheme.appbarTheme,
    readOnly: readOnly,
    validator: validation,
    onTap: onTap,
    maxLines: maxLine,
    minLines: minLine,
    onChanged: onChange,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      fillColor: fillColor ?? appTheme.textGrayColor,
      filled: isFilled,
      labelText: labelText,
      labelStyle: TextStyle(
        color: labelColor ?? appTheme.yellowPrimaryTheme,
        // fontWeight: FontWeight.w600
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.getHeight(10) : borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.getHeight(10) : borderRadius),
        borderSide: BorderSide(color: borderColor ?? Colors.white),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.getHeight(10) : borderRadius),
        borderSide: BorderSide(color: borderColor ?? Colors.white),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
            (borderRadius == null) ? MySize.getHeight(10) : borderRadius),
      ),
      contentPadding: EdgeInsets.only(
        left: MySize.getWidth(20),
        right: MySize.getWidth(10),
        bottom: size! / 2, // HERE THE IMPORTANT PART
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorMaxLines: 2,
      errorText: (isNullEmptyOrFalse(errorText)) ? null : errorText,
      hintText: hintText,
    ),
  );
}
