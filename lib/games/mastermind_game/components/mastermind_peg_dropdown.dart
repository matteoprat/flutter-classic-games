import 'package:classic_games/data/mastermind_color.dart';
import 'package:flutter/material.dart';

class MastermindPegDropdown extends StatelessWidget {
  final MastermindColor? currentColor;
  final bool isActive;
  final ValueChanged<MastermindColor?> onColorSelected;

  const MastermindPegDropdown({
    super.key,
    required this.currentColor,
    required this.isActive,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentColor?.color ?? Colors.grey[300],
        border: Border.all(
          color: isActive ? Colors.brown : Colors.grey[400]!,
          width: isActive ? 2.0 : 1.0,
        ),
        boxShadow: currentColor != null
            ? <BoxShadow>[
                BoxShadow(
                  color: currentColor!.color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: isActive
          ? DropdownButtonHideUnderline(
              child: DropdownButton<MastermindColor>(
                value: currentColor,
                icon: const SizedBox.shrink(),
                alignment: Alignment.center,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                selectedItemBuilder: (BuildContext context) {
                  return MastermindColor.values.map((MastermindColor color) {
                    return const SizedBox.shrink();
                  }).toList();
                },
                items: MastermindColor.values.map((MastermindColor colorEnum) {
                  return DropdownMenuItem<MastermindColor>(
                    value: colorEnum,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorEnum.color,
                        border: Border.all(color: Colors.black26, width: 1.0),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onColorSelected,
              ),
            )
          : null,
    );
  }
}
