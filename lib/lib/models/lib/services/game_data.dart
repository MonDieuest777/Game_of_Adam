import '../models/creature.dart';

class GameData {
  // Liste des créatures de la Création avec leurs noms traduits dans les 6 langues
  static final List<Creature> allCreatures = [
    Creature(
      id: 'c1',
      imagePath: 'assets/images/lion.jpg',
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
      imagePath: 'assets/images/aigle.jpg',
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
      imagePath: 'assets/images/dauphin.jpg',
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

  // Méthode pour récupérer les créatures d'un niveau spécifique en mélangeant les genres
  static List<Creature> getCreaturesForLevel(int levelNumber) {
    List<Creature> filtered = allCreatures.where((c) => c.difficultyLevel == levelNumber).toList();
    filtered.shuffle(); // Mélange aléatoire pour varier l'ordre d'apparition
    return filtered;
  }
}
