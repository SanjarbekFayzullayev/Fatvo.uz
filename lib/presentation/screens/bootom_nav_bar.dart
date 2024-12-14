import 'package:fatvo_uz/data/core/utils/questions/fatwas_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
import 'package:fatvo_uz/presentation/screens/namoz_vaqtalari.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/login_cubit.dart';
import 'package:fatvo_uz/presentation/screens/fatvolar.dart';
import 'package:fatvo_uz/presentation/screens/home.dart';
import 'package:fatvo_uz/presentation/screens/profile.dart';
import 'package:fatvo_uz/presentation/screens/register/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;


  final List<Widget> _pages2 = [
     HomePage(),
    FatwasPage(),
    NamozVaqtlari(),
  ];





  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => FatwasCubit(),
      child: BlocConsumer<FatwasCubit, FatwasState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: SalomonBottomBar(
              backgroundColor: Colors.white,
              unselectedItemColor: Colors.grey,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: [

                /// Home
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home, size: 26,),
                  title: const Text(
                    "Bosh menyu",
                    style: TextStyle(color: Color(0xff3F666B)),
                  ),
                  selectedColor: const Color(0xff19505D),
                ),

                /// Fatwas
                SalomonBottomBarItem(
                  icon: const Icon(Icons.messenger, size: 20,),
                  title: const Text(
                    "Fatvolar",
                    style: TextStyle(color: Color(0xff3F666B)),
                  ),
                  selectedColor: const Color(0xff3F666B),
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: const Icon(Icons.access_time_filled_rounded, size: 26,),
                  title: const Text(
                    "Namoz vaqtlari",
                    style: TextStyle(color: Color(0xff3F666B)),
                  ),
                  selectedColor: const Color(0xff3F666B),
                ),
              ],
            ),
            body: _pages2[_currentIndex],
          );
        },
      ),
    );
  }
}

