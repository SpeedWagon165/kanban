// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deals_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) => Deal(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
      manager: json['manager'] as String,
    );

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'manager': instance.manager,
    };
