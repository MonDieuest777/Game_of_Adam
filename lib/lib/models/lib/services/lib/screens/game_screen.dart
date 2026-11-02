import 'package:flutter/material.dart';
import 'dart:math';
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
  
  String targetWord = '';
  List<String> scrambledLetters = [];
  List<String?> userSlots = [];
  List<bool> letterUsedStatus = [];

  @override
  void initState() {
    super.initState();
    levelCreatures = GameData.getCreaturesForLevel(widget.levelNumber);
    _loadCurrentCreature();
  }

  void _loadCurrentCreature() {
    if (levelCreatures.isNotEmpty && currentIndex < levelCreatures.length) {
      Creature creature = levelCreatures[currentIndex];
      targetWord = creature.getName(widget.currentLanguage).toUpperCase();
      userSlots = List.filled(targetWord.length, null);
      
      // Mélanger les lettres du mot cible pour le clavier
      List<String> letters = targetWord.split('');
      letters.shuffle(Random());
      scrambledLetters = letters;
      letterUsedStatus = List.filled(scrambledLetters.length, false);
    }
  }

  void _onLetterTap(int index) {
    if (letterUsedStatus[index]) return;

    // Trouver la première case vide
    int emptyIndex = userSlots.indexOf(null);
    if (emptyIndex != -1) {
      setState(() {
        userSlots[emptyIndex] = scrambledLetters[index];
        letterUsedStatus[index] = true;
      });

      // Si toutes les cases sont remplies, on vérifie automatiquement
      if (!userSlots.contains(null)) {
        _checkWord();
      }
    }
  }

  void _onSlotTap(int slotIndex) {
    if (userSlots[slotIndex] != null) {
      String letterToRemove = userSlots[slotIndex]!;
      for (int i = 0; i < scrambledLetters.length; i++) {
        if (letterUsedStatus[i] && scrambledLetters[i] == letterToRemove) {
          setState(() {
            letterUsedStatus[i] = false;
            userSlots[slotIndex] = null;
          });
          break;
        }
      }
    }
  }

  void _checkWord() {
    String formedWord = userSlots.join('');
    if (formedWord == targetWord) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✨ Magnifique ! Nom de la créature validé !'),
          backgroundColor: Color(0xFF2E7D32),
          duration: Duration(seconds: 1),
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() {
          currentIndex++;
          if (currentIndex < levelCreatures.length) {
            _loadCurrentCreature();
          } else {
            _showLevelCompletedDialog();
          }
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('❌ Ce n\'est pas tout à fait ça, réessaie !'),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  void _showLevelCompletedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Niveau Terminé ! 🎉'),
        content: const Text('Tu as nommé avec succès toutes les créatures de ce niveau. Gloire à l\'Œuvre de la Création !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (levelCreatures.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Niveau ${widget.levelNumber}'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
        body: const Center(
          child: Text('Aucune créature configurée pour ce niveau.'),
        ),
      );
    }

    Creature currentCreature = levelCreatures[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Niveau ${widget.levelNumber} - ${currentIndex + 1}/${levelCreatures.length}'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. Image de la créature
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(currentCreature.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 2. Cases vides interactives pour l'assemblage des lettres
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: List.generate(targetWord.length, (index) {
                return GestureDetector(
                  onTap: () => _onSlotTap(index),
                  child: Container(
                    width: 45,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF2E7D32), width: 2),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        userSlots[index] ?? '',
                        style: const TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),

            // 3. Clavier interactif de lettres mélangées
            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(scrambledLetters.length, (index) {
                    bool isUsed = letterUsedStatus[index];
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isUsed ? Colors.grey[400] : const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: isUsed ? null : () => _onLetterTap(index),
                      child: Text(
                        scrambledLetters[index],
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
