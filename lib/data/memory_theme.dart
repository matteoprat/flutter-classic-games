import 'package:flutter/material.dart';

enum MemoryTheme {
  animals(
    name: 'Animals',
    themeColor: Colors.orange,
    icons: [
      Icons.pets,
      Icons.phishing,
      Icons.cruelty_free,
      Icons.bug_report,
      Icons.flutter_dash,
      Icons.catching_pokemon,
      Icons.pest_control_rodent,
      Icons.pest_control,
      Icons.waves,
      Icons.egg_rounded,
    ],
  ),

  vehicles(
    name: 'Veichles',
    themeColor: Colors.blue,
    icons: [
      Icons.directions_car,
      Icons.flight,
      Icons.pedal_bike,
      Icons.directions_boat,
      Icons.local_shipping,
      Icons.directions_bus,
      Icons.two_wheeler,
      Icons.sailing,
      Icons.subway,
      Icons.rocket_launch,
    ],
  ),

  food(
    name: 'Food',
    themeColor: Colors.red,
    icons: [
      Icons.local_pizza,
      Icons.icecream,
      Icons.cake,
      Icons.fastfood,
      Icons.local_cafe,
      Icons.ramen_dining,
      Icons.lunch_dining,
      Icons.local_bar,
      Icons.apple,
      Icons.cookie,
    ],
  );

  final String name;
  final Color themeColor;
  final List<IconData> icons;

  const MemoryTheme({
    required this.name,
    required this.themeColor,
    required this.icons,
  });

  List<IconData> getCardsForPairs(int pairsCount) {
    List<IconData> selectedIcons = icons.take(pairsCount).toList();
    List<IconData> gameCards = [...selectedIcons, ...selectedIcons];
    gameCards.shuffle();
    return gameCards;
  }
}
