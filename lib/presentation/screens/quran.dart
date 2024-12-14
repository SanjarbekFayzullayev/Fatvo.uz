import 'dart:io';

import 'package:fatvo_uz/data/core/utils/quran_page/services/quran_service.dart';
import 'package:fatvo_uz/presentation/screens/downloaded_surahs_screen.dart';
import 'package:fatvo_uz/presentation/screens/player_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final QuranService _quranService = QuranService();
  List<dynamic> _surahs = [];
  List<String> _downloadedSurahs = [];

  bool _isLoading = true;

  Map<String, double> _downloadProgress = {}; // Download progress map
  // Tanlangan qiymatni saqlash uchun
  String selectedValue = "05"; // Default qiymat

  @override
  void initState() {
    super.initState();

    loadSelectedValue();
    _loadDownloadedSurahs();

    _loadSurahs();
  }

  // SharedPreferences dan qiymatni yuklash
  Future<void> loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedValue =
          prefs.getString('selected_value') ?? "05"; // Default qiymat
    });
  }

  // SharedPreferences ga tanlangan qiymatni saqlash
  Future<void> saveSelectedValue(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('selected_value', value);
  }

  // Method to build the downloading widget (Progress bar + cancel button)
  Widget _buildDownloadingWidget(String fileName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                color: const Color(0xff285359),
                value: _downloadProgress[fileName],
              ),
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Color(0xff285359),
                ),
                onPressed: () {
                  _cancelDownload(fileName);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to build the widget for already downloaded surahs
  Widget _buildDownloadedSurahWidget(String fileName, String name) {
    return GestureDetector(
      onLongPress: () {
        final downloadedSurah = _downloadedSurahs
            .firstWhere((element) => element.contains(fileName));
        final filePath = downloadedSurah.split(',')[0];
        _deleteDownloadedSurah(name, filePath);
      },
      onTap: () {
        final downloadedSurah = _downloadedSurahs
            .firstWhere((element) => element.contains(fileName));
        final filePath = downloadedSurah.split(',')[0];
        final filePath2 = downloadedSurah.split(',');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlayerScreen(
              audioPath: filePath,
              number: filePath2[1],
              lotinName: filePath2[2],
              arabicName: filePath2[3],
              nazil: filePath2[4],
              jumlaAyat: filePath2[5],
            ),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.check, color: Color(0xff285359)),
      ),
    );
  }

  // Method to build the download button for surahs
  Widget _buildDownloadButton(String fileName, String name, dynamic surah) {
    return IconButton(
      icon: const Icon(
        Icons.download,
        color: Color(0xff285359),
      ),
      onPressed: () {
        _downloadAudio(
          url: surah['audioFull'][selectedValue],
          number: surah['nomor'].toString(),
          arabicName: surah['nama'],
          latinName: surah['namaLatin'],
          nazil: surah['tempatTurun'],
          jumlahAyat: surah['jumlahAyat'].toString(),
          fileName: fileName,
        );
      },
    );
  }

  // Method to load surahs
  Future<void> _loadSurahs() async {
    final data = await _quranService.fetchSurahs();
    setState(() {
      _surahs = data;
      _isLoading = false;
    });
  }

  // Method to load downloaded surahs
  Future<void> _loadDownloadedSurahs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _downloadedSurahs = prefs.getStringList('downloadedSurahs') ?? [];
    });
  }

  // Method to handle the download of audio files
  Future<void> _downloadAudio(
      {String? url,
      String? fileName,
      String? number,
      String? arabicName,
      String? latinName,
      String? nazil,
      String? jumlahAyat}) async {
    if (_downloadProgress.containsKey(fileName)) return;

    setState(() {
      _downloadProgress[fileName!] = 0.0;
      print(url);
    });

    try {
      final filePath = await _quranService.downloadAudio(
        url!,
        fileName!,
        onProgress: (received, total) {
          setState(() {
            _downloadProgress[fileName] = received / total;
          });
        },
      );

      setState(() {
        _downloadProgress.remove(fileName);
        _downloadedSurahs
            .add("$filePath,$number,$latinName,$arabicName,$nazil,$jumlahAyat");
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('downloadedSurahs', _downloadedSurahs);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlayerScreen(
            audioPath: _downloadedSurahs.last.split(",")[0],
            number: _downloadedSurahs.last.split(",")[1],
            lotinName: _downloadedSurahs.last.split(",")[2],
            arabicName: _downloadedSurahs.last.split(",")[3],
            nazil: _downloadedSurahs.last.split(",")[4],
            jumlaAyat: _downloadedSurahs.last.split(",")[5],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: const Color(0xff285359),
            content: Text("$latinName surasini yuklash to'xtatildi!")),
      );
      setState(() {
        _downloadProgress.remove(fileName);
      });
    }
  }

  // Method to handle download cancellation
  void _cancelDownload(String fileName) {
    _quranService.cancelDownload(fileName);
    setState(() {
      _downloadProgress.remove(fileName);
    });
  }

  // Method to delete downloaded surah
// Fayl bilan ishlash uchun

  Future<void> _deleteDownloadedSurah(String name, String filePath) async {
    final prefs = await SharedPreferences.getInstance();

    // Faylni o'chirish
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete(); // Faylni o'chirish
    }

    // SharedPreferences dan surani o'chirish
    setState(() {
      _downloadedSurahs.removeWhere((element) => element.contains(name));
    });
    prefs.setStringList('downloadedSurahs', _downloadedSurahs);

    // SnackBar orqali bildirish
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff285359),
        content:
            Text("$name surasi yuklamalardan va lokal fayllardan o'chirildi"),
      ),
    );
  }


  Future<void> deleteAllAudioFilesAndClearSharedPrefs() async {
    try {
      // 1. Application documents katalogini olish
      final directory = await getApplicationDocumentsDirectory();

      // 2. Papka ichidagi barcha fayllarni olish
      final files = directory.listSync();

      // 3. Faqat .mp3 fayllarni filtrlash va o'chirish
      for (var file in files) {
        if (file is File && file.path.endsWith('.mp3')) {
          await file.delete(); // Faylni o'chirish
        }
      }

      print("Barcha audio fayllar muvaffaqiyatli o'chirildi!");

      // 4. SharedPreferences ni tozalash
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('downloadedSurahs')) {
        await prefs.remove('downloadedSurahs');
        print("SharedPreferences tozalandi!");
      }

      // 5. UI-ni yangilash uchun setState
      setState(() {
        _downloadedSurahs.clear(); // Mahalliy ro'yxatni tozalash
      });

      // Snackbar orqali foydalanuvchiga xabar berish
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff285359),
          content: Text("Kerakli ovozga sozlandi!"),
        ),
      );
    } catch (e) {
      print("Xatolik yuz berdi: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profilebg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 14, left: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_sharp),
                    ),
                    const Text(
                      "Qur'on",
                      style: TextStyle(
                        color: Color(0xff515151),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton<String>(
                          color: Colors.white,
                          onSelected: (value) {
                            setState(() {
                              selectedValue =
                                  value; // Tanlangan qiymatni yangilash
                            });
                            deleteAllAudioFilesAndClearSharedPrefs();
                            saveSelectedValue(value); // Saqlash
                            print("Tanlangan: $value");
                          },
                          icon: const Icon(Icons.more_vert, size: 30),
                          // uchta nuqta ikonchasi
                          itemBuilder: (BuildContext context) {
                            return [
                              buildMenuItem("05", "Misyari-Rasyid-Al-Afasi"),
                              buildMenuItem("01", "Abdullah-Al-Juhany"),
                              buildMenuItem("02", "Abdul-Muhsin-Al-Qasim"),
                              buildMenuItem("03", "Abdurrahman-as-Sudais"),
                              buildMenuItem("04", "Ibrahim-Al-Dossari"),
                            ];
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    _downloadedSurahs.isEmpty
                        ? const SizedBox()
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                audioPath: _downloadedSurahs.last.split(",")[0],
                                number: _downloadedSurahs.last.split(",")[1],
                                lotinName: _downloadedSurahs.last.split(",")[2],
                                arabicName:
                                    _downloadedSurahs.last.split(",")[3],
                                nazil: _downloadedSurahs.last.split(",")[4],
                                jumlaAyat: _downloadedSurahs.last.split(",")[5],
                              ),
                            ),
                          );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 130,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Quran.png"),
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.scaleDown,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(14),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment(0.4, -1.5),
                        end: Alignment(1, 0),
                        colors: [
                          Color(0xff285359),
                          Color(0xff457E8D),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              CupertinoIcons.book_solid,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              " Yaqinda o’qilgan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _downloadedSurahs.isEmpty
                                  ? ""
                                  : _downloadedSurahs.last.split(",")[2] ?? "",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Oyatlar soni: ${_downloadedSurahs.isEmpty ? "" : _downloadedSurahs.last.split(",")[5] ?? ""}",
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0, // Number of tabs
                    child: Column(
                      children: [
                        const TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: Color(0xff3F666B),
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(
                            color: Color(0xff3F666B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          tabs: [
                            Tab(text: "Suralar"),
                            Tab(text: "Yuklanganlar"),
                          ],
                        ),
                        Expanded(
                          // Wrap TabBarView with Expanded
                          child: TabBarView(
                            children: [
                              //Oline page
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: Color(0xff285359),
                                    ))
                                  : ListView.builder(
                                      itemCount: _surahs.length,
                                      itemBuilder: (context, index) {
                                        final surah = _surahs[index];
                                        final fileName =
                                            "surah_${surah['nama']}";
                                        final name = surah['namaLatin'];
                                        bool isDownloaded =
                                            _downloadedSurahs.contains(name);
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 18,
                                              top: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 40,
                                                          width: 40,
                                                          decoration:
                                                              const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/images/numberbg.png"),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                          child: Text(
                                                            surah["nomor"]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff285359),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 18,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              surah["namaLatin"]
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0xff3F666B),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${surah["tempatTurun"].toString() ?? ""} ${surah["jumlahAyat"].toString() ?? ""} Oyat",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff8789A3),
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          surah["nama"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xff3F666B),
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: _downloadProgress
                                                                  .containsKey(
                                                                      fileName)
                                                              ? _buildDownloadingWidget(
                                                                  fileName)
                                                              : (_downloadedSurahs.any(
                                                                      (element) =>
                                                                          element.contains(
                                                                              fileName))
                                                                  ? _buildDownloadedSurahWidget(
                                                                      fileName,
                                                                      name)
                                                                  : _buildDownloadButton(
                                                                      fileName,
                                                                      name,
                                                                      surah)),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const Divider(
                                                color: Color(0xffBBC4CE),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                              //Offline page
                              _downloadedSurahs.isEmpty
                                  ? const Center(
                                      child: Text(
                                          "Hech qanday sura yuklab olinmagan."))
                                  : ListView.builder(
                                      itemCount: _downloadedSurahs.length,
                                      itemBuilder: (context, index) {
                                        var filePath = _downloadedSurahs[index];

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              bottom: 18,
                                              top: 10),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayerScreen(
                                                    audioPath:
                                                        filePath.split(",")[0],
                                                    number:
                                                        filePath.split(",")[1],
                                                    lotinName:
                                                        filePath.split(",")[2],
                                                    arabicName:
                                                        filePath.split(",")[3],
                                                    nazil:
                                                        filePath.split(",")[4],
                                                    jumlaAyat:
                                                        filePath.split(",")[5],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                const BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      "assets/images/numberbg.png"),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            child: Text(
                                                              filePath
                                                                  .split(",")[1]
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff285359),
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 18,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                filePath
                                                                    .split(
                                                                        ",")[2]
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color(
                                                                      0xff3F666B),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${filePath.split(",")[4].toString() ?? ""} ${filePath.split(",")[5].toString() ?? ""} Oyat",
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff8789A3),
                                                                    fontSize:
                                                                        14),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            filePath
                                                                .split(",")[3],
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff3F666B),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            onPressed: () {
                                                              _deleteDownloadedSurah(
                                                                filePath.split(
                                                                    ",")[2],
                                                                filePath.split(
                                                                    ",")[0],
                                                              );
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Color(
                                                                  0xff3F666B),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Color(0xffBBC4CE),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Menyu elementlarini yaratish uchun funksiya
  PopupMenuItem<String> buildMenuItem(String value, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        title,
        style: TextStyle(
          color: value == selectedValue
              ? const Color(0xff457E8D)
              : Colors.black, // Tanlangan rangi
          fontWeight:
              value == selectedValue ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
