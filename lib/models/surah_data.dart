import 'ayah.dart';

class SurahData {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<Ayah> ayahs;

  SurahData({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory SurahData.fromJson(Map<String, dynamic> json) {
    var ayahsList = json['ayahs'] as List;
    List<Ayah> ayahs = ayahsList.map((i) => Ayah.fromJson(i)).toList();

    return SurahData(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      revelationType: json['revelationType'],
      ayahs: ayahs,
    );
  }
}