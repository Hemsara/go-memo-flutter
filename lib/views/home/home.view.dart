import 'package:flutter/material.dart';
import 'package:gomemo/res/dimens.dart';
import 'package:gomemo/views/home/widgets/brief.widget.dart';
import 'package:gomemo/views/home/widgets/logo.widget.dart';
import 'package:gomemo/views/home/widgets/meetings_list.widget.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppDimensions.defaultMargin,
          left: AppDimensions.defaultMargin,
          right: AppDimensions.defaultMargin,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            MeetingsOverview(),
            Spacer(),
            MeetingSlider(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('EEEE dd MMM').format(date).toUpperCase();
}

String formatMonth(DateTime date) {
  return DateFormat('MMMM').format(date).toUpperCase();
}
