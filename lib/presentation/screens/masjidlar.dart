import 'dart:ui';

import 'package:flutter/material.dart';

class MasjidlarPage extends StatelessWidget {
  const MasjidlarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/masjidlarbg.png"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
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
                          hintStyle: const TextStyle(color: Colors.grey),
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
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        height: 148,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              Container(
                                height: 86,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/masjidfoto.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Text(
                                "Hasanboy jome masjidi",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xff3F666B),
                                    size: 22,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Toshkent, Yunusobod tumani, Sharq Haqiqati mahalla fuqarolar yigʻini",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff757272),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
