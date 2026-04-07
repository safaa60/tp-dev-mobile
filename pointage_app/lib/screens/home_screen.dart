import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../main.dart';
import 'historique_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class PresenceRecord {
  final String date;
  final String heure;

  PresenceRecord({
    required this.date,
    required this.heure,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    exportBackgroundColor: Colors.white,
  );

  static final List<PresenceRecord> historique = [];

  bool presenceValidee = false;
  String? datePresence;
  String? heurePresence;

  void validerPresence() {
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez signer avant de valider votre présence"),
        ),
      );
      return;
    }

    final maintenant = DateTime.now();
    final date = DateFormat('dd/MM/yyyy').format(maintenant);
    final heure = DateFormat('HH:mm').format(maintenant);

    setState(() {
      presenceValidee = true;
      datePresence = date;
      heurePresence = heure;
    });

    historique.add(
      PresenceRecord(date: date, heure: heure),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Présence validée avec succès"),
      ),
    );
  }

  void effacerSignature() {
    _signatureController.clear();
    setState(() {
      presenceValidee = false;
      datePresence = null;
      heurePresence = null;
    });
  }

  void seDeconnecter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = MyApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              appState?.toggleTheme();
            },
            icon: const Icon(Icons.brightness_6),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HistoriqueScreen(historique: historique),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: seDeconnecter,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Bienvenue, ${widget.userEmail}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Signez ci-dessous pour certifier votre présence dans l'entreprise :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: effacerSignature,
                        child: const Text("Effacer"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: validerPresence,
                        child: const Text("Valider la présence"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (presenceValidee)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Présence certifiée",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("Date : $datePresence"),
                          Text("Heure : $heurePresence"),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}