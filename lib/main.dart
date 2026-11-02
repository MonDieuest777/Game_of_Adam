import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/game_screen.dart'; // Importation de l'écran de jeu

void main() {
  runApp(const GameOfAdamApp());
}

class GameOfAdamApp extends StatelessWidget {
  const GameOfAdamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game of Adam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Beige Éden doux
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. Écran de Démarrage (B.i.f - 3 secondes)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IntroVerseScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'B . i . f',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: Color(0xFF2E7D32),
          ),
        ),
      ),
    );
  }
}

// 2. Écran du Verset Fondateur (Genèse 2:19-20)
class IntroVerseScreen extends StatelessWidget {
  const IntroVerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('La Création'),
        backgroundColor: const Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '« L\'Éternel Dieu forma du sol tous les animaux... et il les fit venir vers l\'homme pour voir comment il les nommerait. »',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            const Text(
              '— Genèse 2:19',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                // Navigation vers le Niveau 1 du jeu en français ('fr')
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(
                      levelNumber: 1,
                      currentLanguage: 'fr',
                    ),
                  ),
                );
              },
              child: const Text('Commencer le Jeu', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
