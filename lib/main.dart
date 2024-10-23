import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/surah_data.dart';
import 'surah_detail_page.dart'; // Import the new detail page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SurahListPage(), // Display list of Surahs
    );
  }
}

class SurahListPage extends StatefulWidget {
  @override
  _SurahListPageState createState() => _SurahListPageState();
}

class _SurahListPageState extends State<SurahListPage> {
  late Future<List<SurahData>> futureSurahs;

  @override
  void initState() {
    super.initState();
    ApiService apiService = ApiService();
    futureSurahs = apiService.fetchQuranWithArabicAndEnglish(); // Fetch all surahs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Surahs'),
      ),
      body: FutureBuilder<List<SurahData>>(
        future: futureSurahs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final surah = snapshot.data![index];
                return ListTile(
                  title: Text(surah.englishName),
                  subtitle: Text(surah.englishNameTranslation),
                  onTap: () {
                    // Navigate to Surah detail page with selected surah
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahDetailPage(surah: surah),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
