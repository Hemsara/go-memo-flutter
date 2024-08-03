import 'package:flutter/material.dart';
import 'package:gomemo/res/colors.dart';
import 'package:gomemo/res/dimens.dart';
import 'package:gomemo/res/text.dart';
import 'package:iconsax/iconsax.dart';

enum TextFieldType {
  text,
  address,
  password,
  email,
  number,
  url,
}

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? prefixText;
  final bool? enabled;
  final String? errorText;
  final int? maxlines;
  final bool isRequired;
  final bool showPasswordValidations;

  final bool disableBorder;
  final double? padding;
  final int? max;

  final bool autoFocus;

  final String hint;
  final TextFieldType textFieldType;
  final IconData? icon;
  final Function(String)? onChanged;

  const InputField({
    super.key,
    this.disableBorder = false,
    this.controller,
    this.padding,
    this.isRequired = true,
    this.showPasswordValidations = true,
    this.label,
    this.max,
    this.prefixText,
    this.hint = "",
    this.textFieldType = TextFieldType.text,
    this.icon,
    this.onChanged,
    this.enabled = true,
    this.autoFocus = false,
    this.maxlines,
    this.errorText,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool obscured;

  @override
  void initState() {
    if (widget.textFieldType == TextFieldType.password) {
      obscured = true;
    }
    super.initState();
  }

  TextInputType getKeyboardType() {
    if (widget.maxlines != null) {
      return TextInputType.multiline;
    }
    switch (widget.textFieldType) {
      case TextFieldType.address:
        return TextInputType.streetAddress;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.number:
        return TextInputType.number;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.url:
        return TextInputType.url;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.padding ?? AppDimensions.baseSize),
      child: GestureDetector(
        onTap: () {
          // FocusScope.of(context).requestFocus(focusNode);
          // focus on the text field once the container is clicked
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: widget.label != null
                  ? [
                      Text(
                        widget.label!,
                        style: AppTextStyles.bodyRegular,
                      ),
                      AppDimensions.space(1),
                    ]
                  : [],
            ),
            TextFormField(
              autocorrect: false,
              onTapOutside: (event) {
                print('onTapOutside');
                FocusManager.instance.primaryFocus?.unfocus();
              },
              maxLines: widget.maxlines ?? 1,
              autofocus: widget.autoFocus,
              enabled: widget.enabled,
              onChanged: widget.onChanged,
              controller: widget.controller,
              validator: (value) {
                if (widget.isRequired) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return widget.errorText ??
                        'Please enter ${widget.label ?? "this field"}';
                  }
                }
                if (widget.textFieldType == TextFieldType.password &&
                    widget.showPasswordValidations) {
                  if (value == null || value.isEmpty) {
                    return "";
                  }
                  if (value.length < 6) {
                    return "";
                  }
                  if (!containsSpecialCharacter(value)) {
                    return "";
                  }
                }
                if (widget.textFieldType == TextFieldType.url) {
                  if (value != null &&
                      value.isNotEmpty &&
                      !hasValidUrl(value)) {
                    return "";
                  }
                }
                if (widget.textFieldType == TextFieldType.email) {
                  if (!emailValid(value!)) {
                    return "";
                  }
                }

                return null;
              },
              maxLength: widget.max,
              keyboardType: getKeyboardType(),
              obscureText: widget.textFieldType == TextFieldType.password
                  ? obscured
                  : false,
              style: AppTextStyles.bodyRegular.copyWith(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                counterText: widget.max == null
                    ? null
                    : '${widget.controller!.text.length}/${widget.max}',
                fillColor: Colors.transparent,
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        size: 22,
                        color: AppColors.neutralColor200,
                      )
                    : widget.prefixText != null
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: AppDimensions.defaultMargin),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.prefixText!,
                                  style: AppTextStyles.bodySmallMedium.copyWith(
                                    color: AppColors.neutralColor200,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null,
                suffixIcon: widget.textFieldType == TextFieldType.password
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            obscured = !obscured;
                          });
                        },
                        child: Icon(
                          obscured ? Iconsax.eye4 : Iconsax.eye_slash5,
                          size: 16,
                        ),
                      )
                    : null,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
                hintText: widget.hint,
                focusedBorder: widget.disableBorder
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonRadiusSmall,
                        ),
                      ),
                enabledBorder: widget.disableBorder
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonRadiusSmall,
                        ),
                      ),
                border: widget.disableBorder
                    ? InputBorder.none
                    : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonRadiusSmall,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool hasValidUrl(String value) {
  String pattern =
      r'[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
  RegExp regExp = RegExp(pattern);
  if (value.isEmpty) {
    return false;
  } else if (!regExp.hasMatch(value)) {
    return false;
  }
  return true;
}

bool emailValid(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool containsSpecialCharacter(String value) {
  // Define a regular expression to check for special characters
  RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  return specialCharRegex.hasMatch(value);
}
