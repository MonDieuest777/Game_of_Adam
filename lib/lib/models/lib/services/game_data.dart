import '../models/creature.dart';

class GameData {
  static final List<Creature> allCreatures = [
    Creature(
      id: 'c1',
      imagePath: 'assets/images/Lion.jpg',
      names: {
        'fr': 'LION',
        'en': 'LION',
        'es': 'LEÓN',
        'de': 'LÖWE',
        'sw': 'SIMBA',
        'zh': '狮子'
      },
      category: 'terrestre',
      difficultyLevel: 1,
    ),
    Creature(
      id: 'c2',
      imagePath: 'assets/images/Aigle.jpg',
      names: {
        'fr': 'AIGLE',
        'en': 'EAGLE',
        'es': 'ÁGUILA',
        'de': 'ADLER',
        'sw': 'TAI',
        'zh': '鹰'
      },
      category: 'aerien',
      difficultyLevel: 1,
    ),
    Creature(
      id: 'c3',
      imagePath: 'assets/images/Dauphin.jpg',
      names: {
        'fr': 'DAUPHIN',
        'en': 'DOLPHIN',
        'es': 'DELFÍN',
        'de': 'DELFIN',
        'sw': 'PUNGUWA',
        'zh': '海豚'
      },
      category: 'aquatique',
      difficultyLevel: 1,
    ),
  ];

  static List<Creature> getCreaturesForLevel(int levelNumber) {
    List<Creature> filtered = allCreatures.where((c) => c.difficultyLevel == levelNumber).toList();
    filtered.shuffle();
    return filtered;
  }
}
