import 'dart:ui';
import 'package:fatvo_uz/data/core/utils/home_page/home_page_cubit.dart';
import 'package:fatvo_uz/presentation/screens/dua.dart';
import 'package:fatvo_uz/presentation/screens/fatvolar.dart';
import 'package:fatvo_uz/presentation/screens/fatwa_details.dart';
import 'package:fatvo_uz/presentation/screens/masjidlar.dart';
import 'package:fatvo_uz/presentation/screens/namoz_vaqtalari.dart';
import 'package:fatvo_uz/presentation/screens/qibla.dart';
import 'package:fatvo_uz/presentation/screens/quran.dart';
import 'package:fatvo_uz/presentation/screens/tasbih.dart';
import 'package:fatvo_uz/presentation/screens/yangilklar.dart';
import 'package:fatvo_uz/presentation/widgets/home_page_widgets/mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../data/core/utils/namoz_vaqtlari/namoz_vaqtlari_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NamozVaqtlariListCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<NamozVaqtlariListCubit>();
    _cubit.updatePrayerTimes();
    _cubit.initPrefs();
    super.initState();
  }
  String getUzbekDate(DateTime date) {
    // Oyni so'z bilan chiqarish
    String oyNominiOlish(int oy) {
      switch (oy) {
        case 1: return 'yanvar';
        case 2: return 'fevral';
        case 3: return 'mart';
        case 4: return 'aprel';
        case 5: return 'may';
        case 6: return 'iyun';
        case 7: return 'iyul';
        case 8: return 'avgust';
        case 9: return 'sentyabr';
        case 10: return 'oktyabr';
        case 11: return 'noyabr';
        case 12: return 'dekabr';
        default: return '';
      }
    }

    // Haftaning kunini so'z bilan chiqarish
    String haftaNominiOlish(int haftaKuni) {
      switch (haftaKuni) {
        case 1: return 'dushanba';
        case 2: return 'seshanba';
        case 3: return 'chorshanba';
        case 4: return 'payshanba';
        case 5: return 'juma';
        case 6: return 'shanba';
        case 7: return 'yakshanba';
        default: return '';
      }
    }

    String yil = '${date.year} yil';
    String oy = oyNominiOlish(date.month);
    String kun = '${date.day}';
    String hafta = haftaNominiOlish(date.weekday);

    return '$yil $kun $oy, $hafta';
  }

  @override
  Widget build(BuildContext context) {
    var _today = HijriCalendar.now();
    final now = DateTime.now();

    String formattedDate = DateFormat('y d MMMM, EEEE',).format(now);
    return BlocBuilder<NamozVaqtlariListCubit, List<String>>(
      builder: (context, namozVaqtlari) {
        var namozVatlariMin = [
          _cubit.extractTime(namozVaqtlari[0]),
          _cubit.extractTime(namozVaqtlari[1]),
          _cubit.extractTime(namozVaqtlari[2]),
          _cubit.extractTime(namozVaqtlari[3]),
          _cubit.extractTime(namozVaqtlari[4]),
          _cubit.extractTime(namozVaqtlari[5])
        ];

        String currentTime = _cubit.getCurrentTime(); // Hozirgi vaqt
        String closestPrayerTime =
        _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
        int differenceInMinutes = _cubit.calculateTimeDifference(
          closestPrayerTime == "" ? currentTime : closestPrayerTime,
          currentTime,
        );
        _cubit.findClosestPrayerTime(namozVatlariMin, currentTime);
        int indexa = _cubit.findIndex(namozVatlariMin,  closestPrayerTime == ""
            ? namozVatlariMin[0]
            : closestPrayerTime);
        String vaqt= closestPrayerTime == ""
            ? namozVatlariMin[0]
            : closestPrayerTime;
      String qoldi=  "${differenceInMinutes ~/ 60}:${differenceInMinutes % 60}";

        // Stringni soat va daqiqaga ajratamiz
        List<String> parts = vaqt.split(":");
        int hours = int.parse(parts[0]); // Soat qismi
        int minutes = int.parse(parts[1]); // Daqiqa qismi

        // Soatni minutga aylantirib, daqiqalarni qo'shamiz
        int totalMinutes = (hours * 60) + minutes;
        // Stringni soat va daqiqaga ajratamiz
        List<String> partsMin = qoldi.split(":");
        int hoursMin = int.parse(partsMin[0]); // Soat qismi
        int minutesMin = int.parse(partsMin[1]); // Daqiqa qismi

        // Soatni minutga aylantirib, daqiqalarni qo'shamiz
        int qold = (hoursMin * 60) + minutesMin;
        int currentStep = ((qold / totalMinutes) * 100).round();
        int difference = minutesUntilBomdod( _cubit.extractTime(DateTime.now().toString()),_cubit.extractTime(namozVaqtlari[0]));

        double currentStepp = (difference / 1440) * 100;

        print('Foiz: ${currentStepp.toStringAsFixed(2)}%');

        print(currentStepp);
        return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Add some spacing between the TextField and the Container
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewsPage(),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/fatvouzlogo.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NewsPage(),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 56,
                                  width: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.notifications,
                                    color: Color(0xff285359),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xff285359),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showPrayerTimesDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: CircularStepProgressIndicator(
                                  totalSteps: 100,
                                  currentStep: currentStep == 0 ? currentStepp.toInt() : currentStep.toInt(), // To'g'ri o'zgartirish
                                  stepSize: 12,
                                  selectedColor: const Color(0xff4B878F),
                                  unselectedColor: Colors.grey[200],
                                  padding: 0,
                                  width: 150,
                                  height: 150,
                                  selectedStepSize: 12,
                                  roundedCap: (_, __) => true,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _cubit.names[indexa],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        closestPrayerTime == ""
                                            ? namozVatlariMin[0]
                                            : closestPrayerTime,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                      Text(
                                        differenceInMinutes == 0
                                            ? "- ${difference ~/ 60} s ${difference % 60}m"
                                            : "- ${differenceInMinutes ~/ 60} s ${differenceInMinutes % 60}m",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                    Text(
                                      state is HomePageLoaded
                                          ? state.address
                                          : "Loading...",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                _today.toFormat("dd MMMM yyyy"),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                     Text(
                                       "${getUzbekDate(now).split(',')[0]}\n${getUzbekDate(now).split(',')[1]}" ,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Image.asset("assets/images/masjid.png"),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 208,
                        decoration: BoxDecoration(
                          color: const Color(0xffF0F0F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const QuranPage(),
                                    ),
                                  ),
                                  child: MiniCard(
                                      FlutterIslamicIcons.solidQuran2,
                                      "Qurʼon"),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const DuaPage(),
                                      ),
                                    );
                                  },
                                  child: MiniCard(
                                      FlutterIslamicIcons.solidPrayingPerson,
                                      "Duolar"),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Tasbih(),
                                        ),
                                      );
                                    },
                                    child: MiniCard(
                                        FlutterIslamicIcons.solidTasbih2,
                                        "Tasbeh")),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const QiblahPage(),
                                          ),
                                        ),
                                    child: MiniCard(
                                        Icons.menu_book_outlined, "Kitoblar")),
                                InkWell(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MasjidlarPage(),
                                    ),
                                  ),
                                  child: MiniCard(
                                      FlutterIslamicIcons.locationMosque,
                                      "Masjidlar"),
                                ),
                                InkWell(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const QiblahPage(),
                                          ),
                                        ),
                                    child: MiniCard(
                                        FlutterIslamicIcons.solidQibla2,
                                        "Qibla")),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Fatvolar",
                            style: TextStyle(
                                color: Color(0xff285359),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FatwasPage(),
                                  )),
                              child: const Text(
                                "barchasi..",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          color: Colors.white,
                        ),
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsFatwa(),
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/fatvouzlogo.png",
                                width: 80,
                                // Rasm uchun kenglik belgilanmoqda
                                height: 80,
                                // Rasm uchun balandlik belgilanmoqda
                                fit: BoxFit
                                    .cover, // Rasmni konteynerga to'liq sig'dirish
                              ),
                              const SizedBox(width: 10),
                              // Matn va rasm orasidagi bo'shliq
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // Matnni chapga hizalash
                                  children: [
                                    Text(
                                      "❓1266-САВОЛ: МАЙЙИТНИНГ ТИЛЛА ТИШЛАРИНИ ОЛИБ ҚЎЙИЛАДИМИ?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      // Sig'magan qismni kesib tashlash
                                      maxLines:
                                          3, // Matnni maksimal 3 qatorgacha cheklash
                                    ),
                                    SizedBox(height: 8),
                                    // Matnlar orasidagi bo'shliq
                                    Text(
                                      "15-mart, 18:00 . Fatvo.uz",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  },
);
  }
}

void showPrayerTimesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return NamozVaqtlari();
    },
  );
}
int minutesUntilBomdod(String currentTime, String bomdodTime) {
  // Vaqtni umumiy daqiqalarga o'tkazuvchi yordamchi funksiya
  int toMinutes(String time) {
    List<String> parts = time.split(":");
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  // Bomdod va joriy vaqtni umumiy daqiqalarga o'tkazamiz
  int bomdodMinutes = toMinutes(bomdodTime);
  int currentMinutes = toMinutes(currentTime);

  // Farqni hisoblaymiz
  int difference;
  if (currentMinutes <= bomdodMinutes) {
    // Hozirgi vaqt bomdoddan oldin
    difference = bomdodMinutes - currentMinutes;
  } else {
    // Hozirgi vaqt bomdoddan keyin, ertangi bomdodgacha hisoblash
    difference = (1440 - currentMinutes) + bomdodMinutes;
  }

  return difference;
}
