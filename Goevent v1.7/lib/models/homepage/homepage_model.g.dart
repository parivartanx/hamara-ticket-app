// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homepage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageModel _$HomePageModelFromJson(Map<String, dynamic> json) =>
    HomePageModel(
      recommendedParks: (json['recommendedParks'] as List<dynamic>)
          .map((e) => Park.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendedEvents: (json['recommendedEvents'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomePageModelToJson(HomePageModel instance) =>
    <String, dynamic>{
      'recommendedParks':
          instance.recommendedParks.map((e) => e.toJson()).toList(),
      'recommendedEvents':
          instance.recommendedEvents.map((e) => e.toJson()).toList(),
    };
