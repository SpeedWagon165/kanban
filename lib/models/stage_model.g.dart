// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      id: json['id'] as int,
      title: json['title'] as String,
      deals: (json['deals'] as List<dynamic>)
          .map((e) => Deal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'deals': instance.deals,
    };
