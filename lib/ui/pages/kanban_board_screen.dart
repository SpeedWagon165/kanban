import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/kanban_bloc/kanban_bloc.dart';
import '../../models/deals_model.dart';
import '../../models/stage_model.dart';


class KanbanBoardScreen extends StatelessWidget { //Можно было использовать виджеты типо kanban_board и т.д. но так интереснее
  const KanbanBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сделки'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocProvider(
        create: (context) => KanbanBloc()..add(LoadKanban()),
        child: BlocBuilder<KanbanBloc, KanbanState>(
          builder: (context, state) {
            if (state is KanbanLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is KanbanLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.stages.map((stage) => _buildDraggableStage(stage, context)).toList(),
                ),
              );
            } else if (state is KanbanError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Ошибка загрузки'));
            }
          },
        ),
      ),
    );
  }

// Убрал бы виджеты в отдельные файлы если бы они повторялись
  Widget _buildDraggableStage(Stage stage, BuildContext context) {
    return DragTarget<Deal>(
      onWillAccept: (receivedDeal) => stage.deals.every((deal) => deal.id != receivedDeal?.id),
      onAccept: (deal) {
        final fromStageId = context.read<KanbanBloc>().state.stages.firstWhere((s) => s.deals.contains(deal)).id;
        BlocProvider.of<KanbanBloc>(context).add(
          MoveDeal(
            deal: deal,
            fromStageId: fromStageId,
            toStageId: stage.id,
          ),
        );
      },
      builder: (context, candidateData, rejectedData) => _buildStage(stage, context),
    );
  }
// Убрал бы виджеты в отдельные файлы если бы они повторялись
  Widget _buildStage(Stage stage, BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stage.title,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 12,
                  child: Text(
                    stage.deals.length.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: stage.deals.length,
              itemBuilder: (context, index) {
                final deal = stage.deals[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Draggable<Deal>(
                    data: deal,
                    feedback: Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(20.0),
                      child: _buildDealCard(deal, isDragging: true),
                    ),
                    childWhenDragging: Container(),
                    child: _buildDealCard(deal),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
// Убрал бы виджеты в отдельные файлы если бы они повторялись
  Widget _buildDealCard(Deal deal, {bool isDragging = false}) {
    return Card(
      elevation: isDragging ? 8.0 : 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deal.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35),
            Text(deal.date),
            const SizedBox(height: 10),
            Text('Менеджер: ${deal.manager}'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Дела"),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    side: const BorderSide(color: Colors.white),
                    backgroundColor: const Color(0xE2F0FEFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Запланировать', style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}