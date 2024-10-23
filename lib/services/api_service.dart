import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah_data.dart'; // Import Surah model

class ApiService {
  // Fetch the Quran with both Arabic and English text
  Future<List<SurahData>> fetchQuranWithArabicAndEnglish() async {
    // Fetch English translation
    final responseEnglish = await http.get(Uri.parse('https://api.alquran.cloud/v1/quran/en.asad'));
    // Fetch Arabic text
    final responseArabic = await http.get(Uri.parse('https://api.alquran.cloud/v1/quran/ar.alafasy'));

    if (responseEnglish.statusCode == 200 && responseArabic.statusCode == 200) {
      List surahsEnglish = jsonDecode(responseEnglish.body)['data']['surahs'];
      List surahsArabic = jsonDecode(responseArabic.body)['data']['surahs'];

      // Combine English and Arabic data into one structure
      return List.generate(surahsEnglish.length, (index) {
        SurahData englishSurah = SurahData.fromJson(surahsEnglish[index]);
        SurahData arabicSurah = SurahData.fromJson(surahsArabic[index]);

        // Match the English ayahs with the Arabic ayahs
        for (int i = 0; i < englishSurah.ayahs.length; i++) {
          englishSurah.ayahs[i].arabicText = arabicSurah.ayahs[i].text;
        }
        return englishSurah;
      });
    } else {
      throw Exception('Failed to load Quran');
    }
  }
}
