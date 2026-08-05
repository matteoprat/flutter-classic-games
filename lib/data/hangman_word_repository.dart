import 'dart:math';

import 'package:classic_games/data/hangman_category.dart';

class HangmanWordRepository {
  static final Random _random = Random();

  static const Map<HangmanCategory, List<String>> _words = {
    HangmanCategory.animals: <String>[
      "ELEPHANT",
      "ALLIGATOR",
      "ARMADILLO",
      "FLAMINGO",
      "HEDGEHOG",
      "CHINCHILLA",
      "CHIMPANZEE",
      "CROCODILE",
      "HIPPOPOTAMUS",
      "RHINOCEROS",
      "SALAMANDER",
      "TARANTULA",
      "WOODPECKER",
      "CHAMELEON",
      "RATTLESNAKE",
      "ORANGUTAN",
      "PORCUPINE",
      "CORMORANT",
      "CENTIPEDE",
      "BARRACUDA",
    ],
    HangmanCategory.food: <String>[
      "CHOCOLATE",
      "HAMBURGER",
      "SPAGHETTI",
      "CROISSANT",
      "WATERMELON",
      "PINEAPPLE",
      "BLUEBERRY",
      "CHEESECAKE",
      "MAYONNAISE",
      "MOZZARELLA",
      "PISTACHIO",
      "MARMALADE",
      "GUACAMOLE",
      "MILKSHAKE",
      "PEPPERONI",
      "SANDWICH",
      "BROCCOLI",
      "ASPARAGUS",
      "EGGPLANT",
      "TANGERINE",
    ],
    HangmanCategory.vehicles: <String>[
      "AUTOMOBILE",
      "MOTORCYCLE",
      "HELICOPTER",
      "SUBMARINE",
      "AMBULANCE",
      "SPACESHIP",
      "SNOWMOBILE",
      "SKATEBOARD",
      "LOCOMOTIVE",
      "SPEEDBOAT",
      "HOVERCRAFT",
      "CANNONBOAT",
      "CONVERTIBLE",
      "BULLDOZER",
      "FORKLIFT",
      "FIREENGINE",
      "QUADBIKE",
      "SEAPLANE",
      "CABLECAR",
      "STEELSHIP",
    ],
  };

  static String getRandomWord(HangmanCategory category) {
    final list = _words[category]!;
    return list[_random.nextInt(list.length)];
  }
}
