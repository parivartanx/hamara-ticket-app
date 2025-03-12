class Event {
  final int id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String imageUrl;
  final bool isBookmarked;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    this.isBookmarked = false,
  });

  Event copyWith({
    int? id,
    String? title,
    String? date,
    String? time,
    String? location,
    String? imageUrl,
    bool? isBookmarked,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
} 