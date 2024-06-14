part of 'kanban_bloc.dart';

abstract class KanbanEvent extends Equatable {
  const KanbanEvent();

  @override
  List<Object> get props => [];
}

class LoadKanban extends KanbanEvent {}

class MoveDeal extends KanbanEvent {
  final Deal deal;
  final int fromStageId;
  final int toStageId;

  const MoveDeal({
    required this.deal,
    required this.fromStageId,
    required this.toStageId,
  });

  @override
  List<Object> get props => [deal, fromStageId, toStageId];
}