import 'dart:math';

import 'package:abbon_demo/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class AppFormField extends StatefulWidget {
  const AppFormField({
    Key? key,
    this.title,
    this.titleStyle,
    this.enable = true,
    this.isMultiLine = false,
    this.hintText,
    this.onChanged,
    this.keyboardType,
    this.errorText,
    this.obscureText,
    this.textInputAction,
    this.padding,
    this.isShowFooterIcon = true,
    this.footerText,
    this.footerStyle,
    this.footerSubtext,
    this.maxLength,
    this.initialValue,
    this.suffixIcon,
    this.onSuffixIconClick,
    this.controller,
    this.isInvalid,
    this.onValidator,
    this.autovalidateMode,
    this.prefixIcon,
    this.borderRadius,
    this.borderColor,
    this.fillColor,
    this.onFieldSubmit,
    this.focusNode,
    this.maxLine = 1,
    this.ancestorWidget,
    this.isDefaultFormat = true,
    this.maxCharacter,
  }) : super(key: key);
  final TextEditingController? controller;
  final String? title;
  final TextStyle? titleStyle;
  final String? hintText;
  final bool enable;
  final bool isMultiLine;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final int? maxLength;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onSuffixIconClick;
  final bool? isInvalid;
  final String? Function(String?)? onValidator;
  final AutovalidateMode? autovalidateMode;
  final Function(String?)? onFieldSubmit;
  final FocusNode? focusNode;

  // DECORATION
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? fillColor;
  final int? maxLine;

  // FOOTER
  final bool? isShowFooterIcon;
  final String? footerText;
  final TextStyle? footerStyle;
  final String? footerSubtext;

  // Ancestor
  /// Wrap TextField with row then expanded to 1:1
  final Widget? ancestorWidget;
  final bool? isDefaultFormat;
  final int? maxCharacter;

  @override
  State<AppFormField> createState() => _AppFormFieldState();

  factory AppFormField.grey({
    Key? key,
    TextEditingController? controller,
    String? title,
    TextStyle? titleStyle,
    bool enable = true,
    bool isMultiLine = false,
    String? hintText,
    String? errorText,
    bool? obscureText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Function(String)? onChanged,
    int? maxLength,
    String? initialValue,
    Widget? suffixIcon,
    Widget? prefixIcon,
    VoidCallback? onSuffixIconClick,
    bool? isInvalid,
    String? Function(String?)? onValidator,
    AutovalidateMode? autovalidateMode,
    Function(String?)? onFieldSubmit,
    // DECORATION
    EdgeInsets? padding,
    BorderRadius? borderRadius = const BorderRadius.all(Radius.circular(50)),
    Color? borderColor,
    Color? fillColor,

    // FOOTER
    bool? isShowFooterIcon,
    String? footerText,
    TextStyle? footerStyle,
    String? footerSubtext,
  }) {
    return AppFormField(
        key: key,
        controller: controller,
        title: title,
        titleStyle: titleStyle,
        enable: enable,
        isMultiLine: isMultiLine,
        hintText: hintText,
        errorText: errorText,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        maxLength: maxLength,
        initialValue: initialValue,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        onSuffixIconClick: onSuffixIconClick,
        isInvalid: isInvalid,
        onValidator: onValidator,
        autovalidateMode: autovalidateMode,
        onFieldSubmit: onFieldSubmit,
        // DECORATION
        padding: padding,
        borderRadius: borderRadius,
        borderColor: borderColor,
        fillColor: fillColor,
        // FOOTER
        isShowFooterIcon: isShowFooterIcon,
        footerText: footerText,
        footerStyle: footerStyle,
        footerSubtext: footerSubtext);
  }

  factory AppFormField.rounded(
      {Key? key,
      TextEditingController? controller,
      String? title,
      TextStyle? titleStyle,
      String? hintText,
      bool enable = true,
      bool isMultiLine = false,
      FocusNode? focusNode,
      String? errorText,
      bool? obscureText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      Function(String)? onChanged,
      int? maxLength,
      String? initialValue,
      Widget? suffixIcon,
      Widget? prefixIcon,
      VoidCallback? onSuffixIconClick,
      bool? isInvalid,
      String? Function(String?)? onValidator,
      AutovalidateMode? autovalidateMode,
      Function(String?)? onFieldSubmit,
      // DECORATION
      EdgeInsets? padding,
      BorderRadius? borderRadius = const BorderRadius.all(Radius.circular(50)),
      Color? borderColor,
      Color? fillColor,
      // FOOTER
      bool? isShowFooterIcon,
      String? footerText,
      TextStyle? footerStyle,
      String? footerSubtext}) {
    return AppFormField(
      key: key,
      controller: controller,
      title: title,
      titleStyle: titleStyle,
      enable: enable,
      isMultiLine: isMultiLine,
      focusNode: focusNode,
      hintText: hintText,
      errorText: errorText,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      maxLength: maxLength,
      initialValue: initialValue,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      onSuffixIconClick: onSuffixIconClick,
      isInvalid: isInvalid,
      onValidator: onValidator,
      autovalidateMode: autovalidateMode,
      onFieldSubmit: onFieldSubmit,
      // DECORATION
      padding: padding,
      borderRadius: borderRadius,
      borderColor: borderColor,
      fillColor: fillColor,
      // FOOTER
      isShowFooterIcon: isShowFooterIcon,
      footerText: footerText,
      footerStyle: footerStyle,
      footerSubtext: footerSubtext,
    );
  }
}

class _AppFormFieldState extends State<AppFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(bottom: AppTheme.sizeL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                widget.title!,
                style: widget.titleStyle ??
                    GoogleFonts.mitr(
                      fontSize: 14,
                      color: AppTheme.color.tertiaryColor,
                    ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(maxWidth: double.infinity, minWidth: double.infinity),
                  child: TextFormField(
                    enabled: widget.enable,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    initialValue: widget.initialValue,
                    obscureText: _obscure,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction ?? TextInputAction.next,
                    maxLength: widget.maxLength,
                    validator: widget.onValidator,
                    autovalidateMode: widget.autovalidateMode,
                    onFieldSubmitted: widget.onFieldSubmit,
                    style: GoogleFonts.mitr(
                      textStyle: AppTheme.font.mitrS14,
                      height: 1.6,
                      letterSpacing: 0.4,
                    ),
                    strutStyle: const StrutStyle(
                      height: 1.9,
                    ),
                    inputFormatters: inputFormat(isDefaultFormat: widget.isDefaultFormat),
                    maxLines: widget.maxLine,
                    decoration: InputDecoration(
                      errorText: widget.errorText,
                      errorStyle: GoogleFonts.mitr(
                        fontSize: 0.001,
                        fontWeight: FontWeight.w300,
                        color: Colors.transparent,
                      ),
                      hintText: widget.hintText,
                      hintStyle: GoogleFonts.mitr(
                        fontSize: AppTheme.sizeM,
                        fontWeight: FontWeight.w300,
                        color: AppTheme.color.tertiaryColor,
                      ),
                      counterText: "",
                      isDense: true,
                      contentPadding: const EdgeInsets.only(right: 10, left: 10, top: 11, bottom: 10),
                      labelStyle: GoogleFonts.mitr(
                        fontSize: 12,
                        color: AppTheme.color.tertiaryColor,
                      ),
                      constraints: BoxConstraints(
                          maxHeight: widget.isMultiLine == true ? double.infinity : 40,
                          minHeight: 40,
                          maxWidth: double.infinity,
                          minWidth: double.infinity),
                      fillColor: widget.enable ? widget.fillColor : AppTheme.color.quaternaryColor,
                      filled: widget.fillColor != null || !widget.enable,
                      suffixIcon:
                          widget.suffixIcon != null ? InkWell(onTap: widget.onSuffixIconClick, child: widget.suffixIcon) : null,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : widget.fillColor != null
                                    ? Colors.transparent
                                    : AppTheme.color.tertiaryColor),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: widget.borderColor != null
                                ? widget.borderColor!
                                : widget.fillColor != null
                                    ? Colors.transparent
                                    : AppTheme.color.tertiaryColor),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      ),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppTheme.color.borderColor),
                          borderRadius: widget.borderRadius ?? BorderRadius.circular(8)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppTheme.color.statusColorError.withOpacity(1)),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: AppTheme.color.statusColorError.withOpacity(0.6)),
                        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: widget.onChanged,
                  ),
                ),
              ),
              if (widget.ancestorWidget != null)
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: AppTheme.sizeS),
                  child: widget.ancestorWidget!,
                ))
            ],
          ),
        ],
      ),
    );
  }

  void onObscureTextClick() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  List<TextInputFormatter>? inputFormat({bool? isDefaultFormat}) {
    if (isDefaultFormat == true) {
      return [
        if (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone)
          FilteringTextInputFormatter.digitsOnly,
        if (widget.keyboardType == TextInputType.number || widget.keyboardType == TextInputType.phone)
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true)
      ];
    }
    return [_Utf8TextLengthLimitingTextInputFormatter(widget.maxCharacter ?? 1000)];
  }
}

class _Utf8TextLengthLimitingTextInputFormatter extends TextInputFormatter {
  _Utf8TextLengthLimitingTextInputFormatter(this.maxLength);

  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength > 0 && textLength(newValue.text) > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (textLength(oldValue.text) == maxLength) {
        return oldValue;
      }
      return truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue truncate(TextEditingValue value, int maxLength) {
    var newValue = '';
    if (textLength(value.text) > maxLength) {
      var length = 0;

      value.text.characters.takeWhile((char) {
        var nbBytes = textLength(char);
        if (length + nbBytes <= maxLength) {
          newValue += char;
          length += nbBytes;
          return true;
        }
        return false;
      });
    }
    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
      composing: TextRange.empty,
    );
  }

  static int textLength(String value) {
    return value.length;
  }
}
