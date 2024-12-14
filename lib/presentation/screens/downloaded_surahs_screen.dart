import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_screen.dart';

class DownloadedSurahsScreen extends StatefulWidget {
  final List<String> downloadedSurahs;

  DownloadedSurahsScreen({required this.downloadedSurahs});

  @override
  _DownloadedSurahsScreenState createState() => _DownloadedSurahsScreenState();
}

class _DownloadedSurahsScreenState extends State<DownloadedSurahsScreen> {
  List<String> _downloadedSurahs = [];

  @override
  void initState() {
    super.initState();
    _loadDownloadedSurahs();
  }

  // Lokal saqlangan yuklab olingan suralarni yuklash
  Future<void> _loadDownloadedSurahs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _downloadedSurahs = prefs.getStringList('downloadedSurahs') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yuklab Olingan Suralar"),
      ),
      body: _downloadedSurahs.isEmpty
          ? const Center(
              child: Text("Hech qanday sura yuklab olinmagan."),
            )
          : ListView.builder(
              itemCount: _downloadedSurahs.length,
              itemBuilder: (context, index) {
                var filePath = _downloadedSurahs[index];
                return ListTile(
                  title: Text(filePath.split(",")[1]), // Fayl nomini ko'rsatish
                  onTap: () {
                    // Saqlangan surani ijro etish
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PlayerScreen(audioPath: filePath.split(",")[0]),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
