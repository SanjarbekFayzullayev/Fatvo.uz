import 'package:flutter/material.dart';

class SurahWidget extends StatelessWidget {
  const SurahWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 18,top: 10),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/numberbg.png"),
                            fit: BoxFit.cover),
                      ),
                      child: const Text(
                        "1",
                        style: TextStyle(
                            color: Color(0xff285359),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 18,),
                    const Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Al-Fatiah",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff3F666B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Makkaiy 7 Oyat",
                          style: TextStyle(
                              color: Color(0xff8789A3),
                              fontSize: 14),
                        )
                      ],
                    ),
                  ],
                ),
                const Text(
                  "سورة الفاتحة",
                  style: TextStyle(
                    color: Color(0xff3F666B),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xffBBC4CE),),
        ],
      ),
    );
  }
}
