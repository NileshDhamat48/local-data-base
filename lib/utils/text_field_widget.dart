import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// This is common widget to create the text-field which is common in this application
/// Any change in this method should be also reflected in All the text field widgets.
/// All of these are share the same styles and theme and everything.
class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final FocusNode currentFocusNode;
  final TextInputType textInputType;
  final List<TextInputFormatter>? formatters;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool isEnabled;
  final int maxLength;
  final FocusNode? nextFocusNode;
  final int? maxLine;
  final int? minLine;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;

  const TextFieldWidget(
      this.textEditingController, this.hintText, this.currentFocusNode,
      {this.textInputType = TextInputType.text,
        this.formatters,
        this.textInputAction = TextInputAction.next,
        this.textCapitalization = TextCapitalization.sentences,
        this.isEnabled = true,
        this.maxLength = TextField.noMaxLength,
        this.nextFocusNode,
        this.maxLine = 1,
        this.minLine = 1,
        this.prefix,
        this.suffix,
        this.prefixIcon,
        this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      minLines: minLine,
      inputFormatters: formatters,
      enabled: isEnabled,
      autocorrect: false,
      maxLength: maxLength,
      controller: textEditingController,
      buildCounter: (context,
          {required currentLength, required isFocused, maxLength}) =>
      null,
      keyboardType: textInputType,
      onSubmitted: (text) {
        if (nextFocusNode != null)
          FocusScope.of(context).requestFocus(nextFocusNode);
        if(textInputAction== TextInputAction.done)
          FocusScope.of(context).unfocus();
      },
      cursorColor: Colors.black,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      focusNode: currentFocusNode,
      style: getTextInputStyle(),
      decoration: getTextInputDecoration(hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          prefix: prefix,
          suffix: suffix),
    );
  }
}

TextStyle getTextInputStyle() {
  return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black45);
}

InputDecoration getTextInputDecoration(String hintText,
    {Widget? prefixIcon, Widget? suffixIcon, Widget? prefix, Widget? suffix}) {
  return InputDecoration(
      labelText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      focusedBorder: getTextInputBorder(),
      border: getTextInputBorder(),
      disabledBorder: getTextInputBorder(),
      enabledBorder: getTextInputBorder(),
      contentPadding: EdgeInsets.only(
          top: 17,
          bottom: 17,
          left: 16,
          right: 16),
      labelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: Colors.black45),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      prefix: prefix,
      suffix: suffix);
}

OutlineInputBorder getTextInputBorder({color = Colors.grey}) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(10));
}
