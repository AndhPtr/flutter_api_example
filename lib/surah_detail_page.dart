import 'package:flutter/material.dart';
import 'models/surah_data.dart'; // Import the SurahData model

class SurahDetailPage extends StatelessWidget {
  final SurahData surah; // Surah passed from the previous page

  SurahDetailPage({required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.englishName),
      ),
      body: ListView.builder(
        itemCount: surah.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = surah.ayahs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ayah ${ayah.numberInSurah}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  ayah.arabicText ?? '', // Display Arabic text
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  textAlign: TextAlign.right, // Align Arabic text to the right
                ),
                SizedBox(height: 5),
                Text(
                  ayah.text, // Display English text
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}