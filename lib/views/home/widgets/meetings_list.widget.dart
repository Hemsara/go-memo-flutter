import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:gomemo/views/home/widgets/meeting.widget.dart';

class MeetingSlider extends StatefulWidget {
  const MeetingSlider({super.key});

  @override
  State<MeetingSlider> createState() => _MeetingSliderState();
}

class _MeetingSliderState extends State<MeetingSlider> {
  List<MeetingWidget> cards = [
    const MeetingWidget(),
    const MeetingWidget(),
    const MeetingWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: CardSwiper(
        onSwipe: (x, f, t) {
          return false;
        },
        cardsCount: cards.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
            cards[index],
      ),
    );
  }
}
