import 'package:fatvo_uz/data/core/utils/questions/fatwas_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
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
    const HomePage(),
    FatwasPage(),
    ProfileScreen(),
  ];


  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Ilovadan chiqmoqchimisiz?'),
            content: const Text(""),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false), // Rad etish
                child: const Text(
                  'Yo\'q', style: TextStyle(color: Colors.blueGrey),),
              ),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(true), // Tasdiqlash
                child: const Text(
                  'Ha', style: TextStyle(color: Colors.blueGrey),),
              ),
            ],
          ),
    );

    return shouldExit ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocProvider(
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
                    icon: const Icon(Icons.person, size: 26,),
                    title: const Text(
                      "Profil",
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
      ),
    );
  }
}

