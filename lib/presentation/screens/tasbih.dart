import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Tasbih extends StatelessWidget {
  const Tasbih({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff4B878F),
        title: const Text(
          "Tasbeh",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff4B878F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              CircularStepProgressIndicator(
                totalSteps: 100,
                currentStep: 74,
                stepSize: 12,
                selectedColor: const Color(0xff40b6c5),
                unselectedColor: Colors.grey[200],
                padding: 0,
                width: 288,
                height: 288,
                selectedStepSize: 12,
                roundedCap: (_, __) => true,
                child: Center(
                  child: Text(
                    "30/33",
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 44,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.volume_up,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.vibration,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            FlutterIslamicIcons.tasbih2,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                        ),
                      ],
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
