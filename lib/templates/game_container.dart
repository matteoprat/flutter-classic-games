import 'package:flutter/material.dart';

class GameContainer extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback startGame;

  const GameContainer({
    super.key,
    required this.title,
    required this.startGame,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: "Start a new game",
            onPressed: () => startGame(),
          ),
        ],
      ),
      body: body,
    );
  }
}
