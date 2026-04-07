class Pointage {
  final String nomEmploye;
  final DateTime dateHeure;

  Pointage({
    required this.nomEmploye,
    required this.dateHeure,
  });

  Map<String, dynamic> toMap() {
    return {
      'nomEmploye': nomEmploye,
      'dateHeure': dateHeure.toIso8601String(),
    };
  }

  factory Pointage.fromMap(Map<String, dynamic> map) {
    return Pointage(
      nomEmploye: map['nomEmploye'],
      dateHeure: DateTime.parse(map['dateHeure']),
    );
  }
}