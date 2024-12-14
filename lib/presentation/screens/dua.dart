import 'dart:ui';

import 'package:flutter/material.dart';

class DuaPage extends StatelessWidget {
  const DuaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xff4B878F),
        title: const Text(
          "Duolar",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xff4B878F),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
                left: 12,
                top: 12,
              ),
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
                          hintStyle: const TextStyle(
                            color: Color(0xff285359),
                          ),
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
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                      top: 12,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      height: 72,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xffEFF7DE),
                            ),
                            child: const Text(
                              '1',
                              style: TextStyle(
                                  color: Color(0xff2B3032), fontSize: 20),
                            ),
                          ),
                          const Text(
                            "Tongda o’qiladigan duo",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff2B3032),
                            ),
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
