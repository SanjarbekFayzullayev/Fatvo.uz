import 'dart:ui';
import 'package:fatvo_uz/data/core/utils/home_page/home_page_cubit.dart';
import 'package:fatvo_uz/presentation/screens/dua.dart';
import 'package:fatvo_uz/presentation/screens/fatvolar.dart';
import 'package:fatvo_uz/presentation/screens/fatwa_details.dart';
import 'package:fatvo_uz/presentation/screens/masjidlar.dart';
import 'package:fatvo_uz/presentation/screens/qibla.dart';
import 'package:fatvo_uz/presentation/screens/quran.dart';
import 'package:fatvo_uz/presentation/screens/tasbih.dart';
import 'package:fatvo_uz/presentation/screens/yangilklar.dart';
import 'package:fatvo_uz/presentation/widgets/home_page_widgets/mini_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: Color(0xff285359),
                                    ),
                                    hintText: 'Qidirish...',
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
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
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                    height: 160,
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
                              currentStep: 74,
                              stepSize: 12,
                              selectedColor: const Color(0xff4B878F),
                              unselectedColor: Colors.grey[200],
                              padding: 0,
                              width: 150,
                              height: 150,
                              selectedStepSize: 12,
                              roundedCap: (_, __) => true,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Peshin",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "12:21",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                  Text(
                                    "-00:12:00",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
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
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white70,
                                  size: 14,
                                ),

              Text(
                state is HomePageLoaded ? state.address:"Loading...",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "1445 yil 23 zulqa'da",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "2024 yil 31 may, juma",
                                  style: TextStyle(
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
                                  FlutterIslamicIcons.solidQuran2, "Qurʼon"),
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
                                ),child: MiniCard(Icons.menu_book_outlined, "Kitoblar")),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MasjidlarPage(),
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
                                    FlutterIslamicIcons.solidQibla2, "Qibla")),
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
                     InkWell(onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => FatwasPage(),)), child:  const Text(
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
                          builder: (context) =>  DetailsFatwa(),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/fatvouzlogo.png",
                            width: 80, // Rasm uchun kenglik belgilanmoqda
                            height: 80, // Rasm uchun balandlik belgilanmoqda
                            fit: BoxFit
                                .cover, // Rasmni konteynerga to'liq sig'dirish
                          ),
                          const SizedBox(width: 10),
                          // Matn va rasm orasidagi bo'shliq
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
  }
}

void showPrayerTimesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Namoz vaqtlari",
                  style: TextStyle(
                      fontSize: 26,
                      color: Color(0xff446C71),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Bomdod: 05:00 - 06:00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Peshin: 12:30 - 13:30',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Asr: 16:00 - 17:00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Shom: 19:00 - 20:00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Xufton: 21:00 - 22:00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xff446C71),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Ortga",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
