


part of 'kanban_bloc.dart';

abstract class KanbanState extends Equatable {
  const KanbanState();

  List<Stage> get stages => [];

  @override
  List<Object> get props => [];
}

class KanbanInitial extends KanbanState {}

class KanbanLoading extends KanbanState {}

class KanbanLoaded extends KanbanState {
  final List<Stage> loadedStages;

  const KanbanLoaded({required this.loadedStages});

  @override
  List<Stage> get stages => loadedStages;

  @override
  List<Object> get props => [loadedStages];
}

class KanbanError extends KanbanState {
  final String message;

  const KanbanError({required this.message});

  @override
  List<Object> get props => [message];
}