import 'package:json_annotation/json_annotation.dart';
import '../park/park_model.dart';
import '../event/event_model.dart';

part 'homepage_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HomePageModel {
  final List<Park> recommendedParks;
  final List<Event> recommendedEvents;

  HomePageModel({
    required this.recommendedParks,
    required this.recommendedEvents,
  });

  factory HomePageModel.fromJson(Map<String, dynamic> json) => _$HomePageModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$HomePageModelToJson(this);

  // CopyWith method for immutability
  HomePageModel copyWith({
    List<Park>? recommendedParks,
    List<Event>? recommendedEvents,
  }) {
    return HomePageModel(
      recommendedParks: recommendedParks ?? this.recommendedParks,
      recommendedEvents: recommendedEvents ?? this.recommendedEvents,
    );
  }

  @override
  String toString() {
    return 'HomePageModel(recommendedParks: $recommendedParks, recommendedEvents: $recommendedEvents)';
  }
} 