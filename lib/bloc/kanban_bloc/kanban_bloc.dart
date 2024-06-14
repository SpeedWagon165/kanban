import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/models/stage_model.dart';
import 'package:tasks/models/deals_model.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  KanbanBloc() : super(KanbanInitial()) {
    on<LoadKanban>(_onLoadKanban);
    on<MoveDeal>(_onMoveDeal);
  }

  Future<void> _onLoadKanban(LoadKanban event, Emitter<KanbanState> emit) async {
    emit(KanbanLoading());
    await Future.delayed(Duration(milliseconds: 200));
    try {
      final stages = _initialData();
      emit(KanbanLoaded(loadedStages: stages));
    } catch (e) {
      emit(KanbanError(message: 'Failed to load Kanban data'));
    }
  }

  void _onMoveDeal(MoveDeal event, Emitter<KanbanState> emit) {
    final currentState = state;
    if (currentState is KanbanLoaded) {
      final fromStage = currentState.stages.firstWhere((stage) => stage.id == event.fromStageId);
      final toStage = currentState.stages.firstWhere((stage) => stage.id == event.toStageId);

      final updatedFromDeals = List<Deal>.from(fromStage.deals)..remove(event.deal);
      final updatedToDeals = List<Deal>.from(toStage.deals)..add(event.deal);

      final updatedStages = currentState.stages.map((stage) {
        if (stage.id == event.fromStageId) {
          return Stage(id: stage.id, title: stage.title, deals: updatedFromDeals);
        } else if (stage.id == event.toStageId) {
          return Stage(id: stage.id, title: stage.title, deals: updatedToDeals);
        } else {
          return stage;
        }
      }).toList();

      emit(KanbanLoaded(loadedStages: updatedStages));
    }
  }

  List<Stage> _initialData() {
    return [
      Stage(id: 1, title: 'Стадия 1', deals: [
        Deal(id: 1, title: 'Сделка 1', date: '15 мая', manager: 'Иванов И.И.'),
        Deal(id: 2, title: 'Сделка 2', date: '23 апреля', manager: 'Петров П.П.'),
        Deal(id: 3, title: 'Сделка 3', date: '01 июня', manager: 'Сидоров С.С.'),
      ]),
      Stage(id: 2, title: 'Стадия 2', deals: [
        Deal(id: 4, title: 'Сделка 4', date: '05 июля', manager: 'Кузнецов К.К.'),
      ]),
    ];
  }
}
