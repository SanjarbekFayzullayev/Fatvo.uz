import 'package:fatvo_uz/presentation/widgets/quran_page_widgets/surah_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({Key? key}) : super(key: key);

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
                      "Qur'on       ",
                      style: TextStyle(
                        color: Color(0xff515151),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.book_solid,
                            color: Colors.white,
                            size: 14,
                          ),
                          Text(
                            " Yaqinda o’qilgan",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Al-Fatiah",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Oyatlar soni: 7",
                            style:
                                TextStyle(color: Colors.white38, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3, // Number of tabs
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
                            Tab(text: "Sura"),
                            Tab(text: "Pora"),
                            Tab(text: "Hatchop"),
                          ],
                        ),
                        Expanded(
                          // Wrap TabBarView with Expanded
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const SurahWidget();
                                },
                              ),
                              ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const SurahWidget();
                                },
                              ),
                              ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const SurahWidget();
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
}
