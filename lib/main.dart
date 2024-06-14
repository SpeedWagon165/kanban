import 'package:flutter/material.dart';
import 'ui/pages/kanban_board_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban Board',
      theme: ThemeData(
        primarySwatch: Colors.blue, //Опять же мог вынести темы и текст в отдельные файлы но так интереснее
      ),
      home: const KanbanBoardScreen(),
    );
  }
}