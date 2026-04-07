import 'package:flutter/material.dart';
import '../models/pointage.dart';
import '../services/pointage_service.dart';
import 'historique_screen.dart';

class HomeScreen extends StatelessWidget {
  final String nom;

  const HomeScreen({super.key, required this.nom});

  void sePointer(BuildContext context) async {
    final dejaPointe = await PointageService.aDejaPointeAujourdhui(nom);

    if (dejaPointe) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Vous avez déjà pointé aujourd'hui"),
        ),
      );
      return;
    }

    final pointage = Pointage(
      nomEmploye: nom,
      dateHeure: DateTime.now(),
    );

    await PointageService.ajouterPointage(pointage);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pointage enregistré")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.business_center,
                      size: 50,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Bienvenue $nom",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateTime.now().toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => sePointer(context),
              icon: const Icon(Icons.login),
              label: const Text("Se pointer"),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoriqueScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.history),
              label: const Text("Voir historique"),
            ),
          ],
        ),
      ),
    );
  }
}