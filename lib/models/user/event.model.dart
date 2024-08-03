class Event {
  List<String> attendees;
  String color;
  String summary;
  String date;
  String meetLink;

  Event({
    required this.attendees,
    required this.color,
    required this.summary,
    required this.date,
    required this.meetLink,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      attendees: List<String>.from(json['Attendees']),
      color: json['Color'] ?? '',
      summary: json['Summary'] ?? '',
      date: json['Date'] ?? '',
      meetLink: json['MeetLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Attendees': attendees,
      'Color': color,
      'Summary': summary,
      'Date': date,
      'MeetLink': meetLink,
    };
  }
}
