import 'dart:ui';

import 'package:flutter/material.dart';

class DetailsNews extends StatelessWidget {
  const DetailsNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/masjidlarbg.png"),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Color(0xff515151),
                      ),
                    ),
                    const SizedBox()
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.withOpacity(0.06),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 310,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/fatvouzlogo.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Fatvo.uz",
                                    style: TextStyle(
                                        color: Color(0xff828282), fontSize: 14),
                                  ),
                                  Text(
                                    "Jan 1, 2021 3344 views",
                                    style: TextStyle(
                                        color: Color(0xff828282), fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Fatvo.uz сайти мобил иловаси иш бошлади!",
                                style: TextStyle(
                                  color: Color(0xff2C2C2C),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                """Диний саволларга жавобларни овозли ҳам тинглаш мумкин Диний идора Фатво ҳайъати бир неча ойдан бери шаръий масалаларга асосли жавобларни туну кун “@SavollarMuslimUzBot”, "Дин ва ҳаётга оид саволлар" телеграм канали  ва savollar.muslim.uz сайти орқали тақдим этиб келмоқда.
                              """,
                                style:
                                    TextStyle(color: Color(0xff2C2C2C), fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
