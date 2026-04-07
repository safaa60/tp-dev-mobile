import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController nomController = TextEditingController();

  void seConnecter() {

    if (nomController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez entrer votre nom")),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(nom: nomController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Pointage Entreprise"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(Icons.access_time, size: 80, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                "Application de pointage",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: nomController,
                decoration: InputDecoration(
                  labelText: "Nom de l'employé",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: seConnecter,
                child: const Text("Se connecter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}