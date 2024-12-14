import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../data/core/utils/tasbih/tasbih_cubit.dart';
import '../../data/core/utils/tasbih/tasbih_total_cubit.dart';

class Tasbih extends StatefulWidget {
  const Tasbih({Key? key}) : super(key: key);

  @override
  State<Tasbih> createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  late TasbihCubit cubit = context.read<TasbihCubit>();
  late TasbihTotalCubit cubit2 = context.read<TasbihTotalCubit>();

  @override
  void initState() {
    cubit.getVibration();
    cubit.getCount();
    cubit.getVolume();
    cubit2.getTotal();
    cubit.getAllCount();
    cubit.getRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(cubit.vibration);
    return BlocBuilder<TasbihCubit, int>(
      builder: (context, tasbih) {
        return BlocBuilder<TasbihTotalCubit, int>(
          builder: (context, total) {
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
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        overlayColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        onTap: () {
                          cubit.vibration == true
                              ? HapticFeedback.lightImpact()
                              : const SizedBox();
                          cubit.volume == true
                              ? cubit.playSound("assets/audios/tasbih.mp3")
                              : const SizedBox();

                          cubit.setAllCount(++cubit.allCount);
                          tasbih++;
                          cubit.setCount(tasbih, total);
                        },
                        child: GestureDetector(
                          child: CircularStepProgressIndicator(
                            totalSteps: total,
                            currentStep: tasbih,
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
                                "${tasbih.toString()}/${total.toString()}",
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cubit.setCount(0, total);
                                      cubit.setAllCount(0);
                                      cubit.getAllCount();
                                    },
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                    iconSize: 50,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cubit.volume = !cubit.volume;
                                      });
                                      cubit.setVolume(cubit.volume);
                                    },
                                    icon: Icon(
                                      cubit.volume == true
                                          ? Icons.volume_up
                                          : Icons.volume_off,
                                      color: Colors.white,
                                    ),
                                    iconSize: 50,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        cubit.vibration = !cubit.vibration;
                                      });
                                      cubit.setVibration(cubit.vibration);
                                    },
                                    icon: Icon(
                                      cubit.vibration == true
                                          ? Icons.vibration
                                          : Icons.phone_android_outlined,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (total == 33) {
                                        cubit2.setTotal(99);
                                      } else {
                                        cubit2.setTotal(33);
                                        cubit.setCount(0, 33);
                                      }
                                    },
                                    icon: Icon(
                                      total == 33
                                          ? FlutterIslamicIcons.tasbih2
                                          : FlutterIslamicIcons.allah99,
                                      color: Colors.white,
                                    ),
                                    iconSize: 50,
                                  ),
                                ],
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
          },
        );
      },
    );
  }
}
