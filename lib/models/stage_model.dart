import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'deals_model.dart';

part 'stage_model.g.dart';

@JsonSerializable()
class Stage extends Equatable {
  final int id;
  final String title;
  final List<Deal> deals;

  const Stage({
    required this.id,
    required this.title,
    required this.deals,
  });

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);

  @override
  List<Object> get props => [id, title, deals];
}