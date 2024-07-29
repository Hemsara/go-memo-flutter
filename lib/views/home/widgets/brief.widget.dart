import 'package:flutter/material.dart';
import 'package:gomemo/views/home/home.view.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingsOverview extends StatelessWidget {
  const MeetingsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formatDate(DateTime.now()).toUpperCase(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
        ),
        const Text(
          "8 meetings",
          style: TextStyle(
              fontSize: 58,
              color: Color(0xff7FFA88),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
            height:
                5), // Adds some spacing between the meetings text and the rich text
        Text.rich(
          TextSpan(
            style: GoogleFonts.poppins(fontSize: 14),
            children: const [
              TextSpan(
                text: "Your first meeting starts at ",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 207, 207, 207),
                ),
              ),
              TextSpan(
                text: "11:30 AM",
                style: TextStyle(fontSize: 18, color: Color(0xff7FFA88)),
              ),
              TextSpan(
                text: " and last meeting at ",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 207, 207, 207),
                ),
              ),
              TextSpan(
                text: "4:00 PM",
                style: TextStyle(fontSize: 18, color: Color(0xff7FFA88)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
