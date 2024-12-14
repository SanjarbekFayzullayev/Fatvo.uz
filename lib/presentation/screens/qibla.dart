import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';

class QiblahPage extends StatefulWidget {
  const QiblahPage({super.key});

  @override
  State<QiblahPage> createState() => _QiblahPageState();
}

class _QiblahPageState extends State<QiblahPage> {
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();
    // Sensor o'qishlarini olish
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        // Gyroscope qiymatlarini burish burchagiga o'zgartirish
        _angle += event.z / 20; // `z` o'qi bo'yicha burish
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Compass App"),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Kompas fon rasmi
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset( 'assets/images/com.png',
              ),
            ),
            // Ko'rsatkich
            Transform.rotate(
              angle: _angle,
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image.asset( 'assets/images/com.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
