import 'package:flutter/material.dart';
import 'package:gomemo/global/textfield.dart';
import 'package:gomemo/res/colors.dart';
import 'package:gomemo/res/dimens.dart';
import 'package:iconsax/iconsax.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimensions.defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.calendar5,
              color: AppColors.primary,
              size: 50,
            ),
            const Center(
              child: Text(
                "GOMEMO",
                style: TextStyle(
                    fontSize: 58,
                    color: Color(0xff7FFA88),
                    fontWeight: FontWeight.w500),
              ),
            ),
            AppDimensions.space(2),
            const TSLField(
              hint: "Enter email",
            ),
            const TSLField(
              textFieldType: TextFieldType.password,
              hint: "Enter password",
            ),
            AppDimensions.space(4),
            Button(
              onTap: () {},
              text: 'Login',
            ),
            AppDimensions.space(1),
            Button(
              primary: false,
              onTap: () {},
              text: 'New to GOMEMO',
            ),
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;

  final bool primary;

  final String text;
  final double borderRadius;

  const Button({
    Key? key,
    required this.onTap,
    required this.text,
    this.primary = true,
    this.borderRadius = 8.0, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: primary ? AppColors.primary : Colors.transparent,
          border: primary ? null : Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: primary ? Colors.black : AppColors.primary,
              fontSize: 26.0,
            ),
          ),
        ),
      ),
    );
  }
}
