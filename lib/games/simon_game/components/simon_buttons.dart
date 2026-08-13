import 'package:classic_games/data/simon_command.dart';
import 'package:flutter/material.dart';

class SimonButtons extends StatelessWidget {
  final SimonCommand? command;
  final Function(SimonCommand) onTap;

  const SimonButtons({super.key, this.command, required this.onTap});

  Widget _getButton({
    required SimonCommand simonCommand,
    required BorderRadiusGeometry borderRadius,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(simonCommand),
        child: Container(
          decoration: BoxDecoration(
            color: command == simonCommand
                ? simonCommand.activeColor
                : simonCommand.color,
            borderRadius: borderRadius,
            boxShadow: command == simonCommand
                ? <BoxShadow>[
                    BoxShadow(
                      color: simonCommand.activeColor.withValues(alpha: 0.8),
                      blurRadius: 20.0,
                      spreadRadius: 4.0,
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                _getButton(
                  simonCommand: SimonCommand.green,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(125.0),
                  ),
                ),
                const SizedBox(width: 8),
                _getButton(
                  simonCommand: SimonCommand.red,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(125.0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: <Widget>[
                _getButton(
                  simonCommand: SimonCommand.yellow,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(125.0),
                  ),
                ),
                const SizedBox(width: 8),
                _getButton(
                  simonCommand: SimonCommand.blue,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(125.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
