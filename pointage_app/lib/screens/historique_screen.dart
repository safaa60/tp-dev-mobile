import 'package:flutter/material.dart';
import 'home_screen.dart';

class HistoriqueScreen extends StatelessWidget {
  final List<PresenceRecord> historique;

  const HistoriqueScreen({
    super.key,
    required this.historique,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des présences"),
        centerTitle: true,
      ),
      body: historique.isEmpty
          ? const Center(
              child: Text(
                "Aucune présence enregistrée",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historique.length,
              itemBuilder: (context, index) {
                final item = historique[historique.length - 1 - index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.event_available),
                    title: Text("Date : ${item.date}"),
                    subtitle: Text("Heure : ${item.heure}"),
                  ),
                );
              },
            ),
    );
  }
}