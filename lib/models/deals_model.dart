import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deals_model.g.dart';

@JsonSerializable()
class Deal extends Equatable {
  final int id;
  final String title;
  final String date;
  final String manager;

  const Deal({
    required this.id,
    required this.title,
    required this.date,
    required this.manager,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
  Map<String, dynamic> toJson() => _$DealToJson(this);

  @override
  List<Object> get props => [id, title, date, manager];
}