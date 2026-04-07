import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pointage.dart';

class PointageService {
  static const String keyPointages = 'pointages';

  static Future<void> ajouterPointage(Pointage pointage) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = prefs.getStringList(keyPointages) ?? [];

    data.add(jsonEncode(pointage.toMap()));

    await prefs.setStringList(keyPointages, data);
  }

  static Future<List<Pointage>> getPointages() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> data = prefs.getStringList(keyPointages) ?? [];

    return data
        .map((e) => Pointage.fromMap(jsonDecode(e)))
        .toList();
  }

  static Future<bool> aDejaPointeAujourdhui(String nomEmploye) async {
    final pointages = await getPointages();
    final maintenant = DateTime.now();

    for (final p in pointages) {
      final memeJour =
          p.dateHeure.year == maintenant.year &&
          p.dateHeure.month == maintenant.month &&
          p.dateHeure.day == maintenant.day;

      if (p.nomEmploye.toLowerCase() == nomEmploye.toLowerCase() && memeJour) {
        return true;
      }
    }

    return false;
  }
}