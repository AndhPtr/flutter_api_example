import 'surah_data.dart';

class Surah {
  final int code;
  final String status;
  final SurahData data;

  Surah({
    required this.code,
    required this.status,
    required this.data,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      code: json['code'],
      status: json['status'],
      data: SurahData.fromJson(json['data']),
    );
  }
}