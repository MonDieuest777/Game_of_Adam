import '../models/creature.dart';

class GameData {
  static final List<Creature> allCreatures = [
    // --- Niveau 1 : Animaux familiers et de la Création ---
    Creature(
      id: 'c1',
      imagePath: 'assets/images/Lion.jpg',
      names: {
        'fr': 'LION',
        'en': 'LION',
        'es': 'LEÓN',
        'de': 'LÖWE',
        'sw': 'SIMBA',
        'zh': '狮子',
        'he': 'אריה' // Aryeh
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
        'zh': '鹰',
        'he': 'נשר' // Neser
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
        'zh': '海豚',
        'he': 'דולפין' // Dolphin
      },
      category: 'aquatique',
      difficultyLevel: 1,
    ),
    Creature(
      id: 'c4',
      imagePath: 'assets/images/Elephant.jpg',
      names: {
        'fr': 'ELEPHANT',
        'en': 'ELEPHANT',
        'es': 'ELEFANTE',
        'de': 'ELEFANT',
        'sw': 'TEMBO',
        'zh': '大象',
        'he': 'פיל' // Pil
      },
      category: 'terrestre',
      difficultyLevel: 1,
    ),
    Creature(
      id: 'c5',
      imagePath: 'assets/images/Requin.jpg',
      names: {
        'fr': 'REQUIN',
        'en': 'SHARK',
        'es': 'TIBURÓN',
        'de': 'HAI',
        'sw': 'PAPA',
        'zh': '鲨鱼',
        'he': 'כריש' // Karish
      },
      category: 'aquatique',
      difficultyLevel: 1,
    ),
    Creature(
      id: 'c6',
      imagePath: 'assets/images/Papillon.jpg',
      names: {
        'fr': 'PAPILLON',
        'en': 'BUTTERFLY',
        'es': 'MARIPOSA',
        'de': 'SCHMETTERLING',
        'sw': 'KIPEPEO',
        'zh': '蝴蝶',
        'he': 'פרפר' // Parpar
      },
      category: 'aerien',
      difficultyLevel: 1,
    ),
  ];

  static List<Creature> getCreaturesForLevel(int levelNumber) {
    List<Creature> filtered = allCreatures.where((c) => c.difficultyLevel == levelNumber).toList();
    filtered.shuffle();
    return filtered;
  }
}
