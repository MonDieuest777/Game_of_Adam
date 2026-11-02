class Creature {
  final String id;
  final String imagePath;
  final Map<String, String> names; // Ex: {'fr': 'LION', 'en': 'LION', 'es': 'LEÓN', ...}
  final String category; // 'terrestre', 'aquatique', 'aerien'
  final int difficultyLevel; // 1 (facile) à N (difficile)

  Creature({
    required this.id,
    required this.imagePath,
    required this.names,
    required this.category,
    required this.difficultyLevel,
  });

  // Méthode pour récupérer le nom de la créature selon la langue active
  String getName(String langCode) {
    return names[langCode] ?? names['fr'] ?? '';
  }
}
