import 'package:classic_games/games/fifteen_game/fifteen_game.dart';
import 'package:classic_games/games/hangman_game/hangman_game.dart';
import 'package:classic_games/games/hanoi_tower_game/hanoi_tower_game.dart';
import 'package:classic_games/games/mastermind_game/mastermind_game.dart';
import 'package:classic_games/games/memory_game/memory_game.dart';
import 'package:classic_games/games/minesweeper_game/minesweeper_game.dart';
import 'package:classic_games/games/simon_game/simon_game.dart';
import 'package:classic_games/games/tris_game/tris_game.dart';
import 'package:classic_games/templates/game_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Classic Games Hub",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsetsGeometry.only(bottom: 16.0, left: 4.0),
              child: Text(
                "Choose a game",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            GameCard(
              title: "15 Game",
              subtitle: "Reorder numbers from 1 to 15!",
              icon: Icons.grid_on_rounded,
              color: Colors.indigo,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FifteenGame()),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Hangman",
              subtitle: "Guess the word",
              icon: Icons.abc_rounded,
              color: Colors.teal,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HangmanGame()),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Mastermind",
              subtitle: "Guess the secret combination",
              icon: Icons.psychology_rounded,
              color: Colors.purple,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MastermindGame(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Memory",
              subtitle: "Find pair of equal cards",
              icon: Icons.style_rounded,
              color: Colors.teal,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MemoryGame()),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Mine Sweeper",
              subtitle: "Find all mines without explode",
              icon: Icons.brightness_7_rounded,
              color: Colors.redAccent,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MinesweeperGame(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Simon",
              subtitle: "Repeat the sequence",
              icon: Icons.pie_chart_rounded,
              color: Colors.red,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SimonGame()),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Tower of Hanoi",
              subtitle: "Move discs from column A to column C",
              icon: Icons.cabin_rounded,
              color: Colors.lightBlue,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HanoiTowerGame(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            GameCard(
              title: "Tris (Tic-Tac-Toe)",
              subtitle: "Align 3 symbols",
              icon: Icons.close_rounded,
              color: Colors.orange,
              isAvailable: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrisGame()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
