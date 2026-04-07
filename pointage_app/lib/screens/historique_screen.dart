import 'package:flutter/material.dart';
import '../models/pointage.dart';
import '../services/pointage_service.dart';

class HistoriqueScreen extends StatefulWidget {
  const HistoriqueScreen({super.key});

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  List<Pointage> pointages = [];

  @override
  void initState() {
    super.initState();
    chargerPointages();
  }

  void chargerPointages() async {
    final data = await PointageService.getPointages();
    setState(() {
      pointages = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des pointages"),
        centerTitle: true,
      ),
      body: pointages.isEmpty
          ? const Center(
              child: Text("Aucun pointage enregistré"),
            )
          : ListView.builder(
              itemCount: pointages.length,
              itemBuilder: (context, index) {
                final pointage = pointages[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.access_time,
                      color: Colors.blue,
                    ),
                    title: Text(pointage.nomEmploye),
                    subtitle: Text(pointage.dateHeure.toString()),
                  ),
                );
              },
            ),
    );
  }
}