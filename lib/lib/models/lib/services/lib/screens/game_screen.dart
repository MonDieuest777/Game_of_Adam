import 'package:flutter/material.dart';
import '../models/creature.dart';
import '../services/game_data.dart';

class GameScreen extends StatefulWidget {
  final int levelNumber;
  final String currentLanguage; // 'fr', 'en', 'es', 'de', 'sw', 'zh'

  const GameScreen({
    super.key, 
    required this.levelNumber,
    required this.currentLanguage,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<Creature> levelCreatures;
  int currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    // Charge les créatures pour ce niveau
    levelCreatures = GameData.getCreaturesForLevel(widget.levelNumber);
  }

  @override
  Widget build(BuildContext context) {
    // Si le niveau n'a pas encore de créatures configurées
    if (levelCreatures.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Niveau ${widget.levelNumber}'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
        body: const Center(
          child: Text(
            'Créatures en cours de chargement pour ce niveau...',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Creature currentCreature = levelCreatures[currentIndex];
    String targetWord = currentCreature.getName(widget.currentLanguage);

    return Scaffold(
      appBar: AppBar(
        title: Text('Niveau ${widget.levelNumber} - Créature ${currentIndex + 1}/${levelCreatures.length}'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. Image de la créature
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(currentCreature.imagePath),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Gestion de secours si l'image locale n'est pas encore téléversée
                  },
                ),
              ),
              child: Center(
                child: Text(
                  currentCreature.imagePath,
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 2. Cases vides pour l'assemblage des lettres du mot cible
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(targetWord.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 40,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF2E7D32), width: 2),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // 3. Clavier interactif pour le joueur
            const Expanded(
              child: Center(
                child: Text(
                  'Clavier d\'assemblage des lettres en cours d\'initialisation...',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

