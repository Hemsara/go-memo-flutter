import 'package:flutter/material.dart';
import 'package:gomemo/res/assets.dart';
import 'package:gomemo/res/dimens.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(AppAssets.goLogo),
              height: 50,
            ),
            AppDimensions.space(1),
            const Text(
              "GOMemo",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff9CCFF3)),
            ),
          ],
        ),
      ],
    );
  }
}
