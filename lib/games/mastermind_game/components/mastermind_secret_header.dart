import 'package:classic_games/data/mastermind_color.dart';
import 'package:flutter/material.dart';

class MastermindSecretHeader extends StatelessWidget {
  final bool showSecret;
  final List<MastermindColor> secretCombination;

  const MastermindSecretHeader({
    super.key,
    required this.showSecret,
    required this.secretCombination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6.0),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: showSecret
                  ? secretCombination[index].color
                  : Colors.indigo[200],
              border: Border.all(color: Colors.indigo[400]!, width: 1.5),
            ),
            child: showSecret
                ? null
                : const Icon(
                    Icons.help_outline_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
          );
        }),
      ),
    );
  }
}
