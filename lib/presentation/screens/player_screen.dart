import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerScreen extends StatefulWidget {
  final String audioPath;
  String? number;
  String? arabicName;
  String? lotinName;
  String? nazil;
  String? jumlaAyat;

  PlayerScreen({required this.audioPath,
    this.number,
    this.arabicName,
    this.lotinName,
    this.nazil,
    this.jumlaAyat,
    Key? key})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false; // Bitta flag ishlatamiz
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
 String url="";
  Future<void> loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url =  prefs.getString('selected_value') ?? "05"; // Default qiymat
    });
  }
  @override
  void initState() {
    super.initState();
    loadSelectedValue();
    _audioPlayer = AudioPlayer();
    _initializeAudio();

    // Play/Pause stream bilan UI yangilanadi
    _audioPlayer.playingStream.listen((isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });

    // Audio tugashini kuzatish
    _audioPlayer.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        _audioPlayer.pause();
        _audioPlayer.seek(Duration.zero); // Tugaganda boshiga qaytaramiz
        setState(() {
          _isPlaying = false; // Holatni to‘g‘irlaymiz
        });
      }
    });

    // Slider uchun pozitsiyani yangilash
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audioPath);
      _duration = _audioPlayer.duration ?? Duration.zero;
      setState(() {});
    } catch (e) {
      print("Audio yuklashda xatolik: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _seekAudio(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff285359),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff285359),
        title: Text(
          "${widget.lotinName!} - ${widget.arabicName!}",
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.lotinName!,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.arabicName!,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.nazil!,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.jumlaAyat!} oyat",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Material(
            elevation: 12,
            shadowColor: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: InkWell(
              onTap: () {
                print(widget.audioPath);
              },
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: AssetImage(url == "01"
                          ? "assets/sheyhs/AbdullahAlJuhany.jpg"
                          : url == "02"
                          ? "assets/sheyhs/AbdulMuhsinAlQasim.jpg":
                      url == "03"
                          ? "assets/sheyhs/AbdurrahmanasSudais.jpg":
                      url == "04"
                          ? "assets/sheyhs/YosiralDavsariy.jpg":
                      "assets/sheyhs/mishary.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 70,
              color: Colors.white,
            ),
            onPressed: _togglePlayPause,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Slider(
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds
                      .toDouble()
                      .clamp(0.0, _duration.inSeconds.toDouble()),
                  onChanged: (value) {
                    final newPosition = Duration(seconds: value.toInt());
                    _seekAudio(newPosition);
                  },
                  activeColor: const Color(0xff457E8D),
                  inactiveColor: Colors.grey[300],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _formatDuration(_duration),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
