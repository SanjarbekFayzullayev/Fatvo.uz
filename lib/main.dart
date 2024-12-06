import 'dart:io';

import 'package:fatvo_uz/data/core/utils/home_page/home_page_cubit.dart';
import 'package:fatvo_uz/data/core/utils/questions/fatwas_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/create_account_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/login_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/register_cubit.dart';
import 'package:fatvo_uz/data/core/utils/register/user_profile.dart';
import 'package:fatvo_uz/data/core/utils/register/verify_code_cubit.dart';
import 'package:fatvo_uz/presentation/screens/bootom_nav_bar.dart';
import 'package:fatvo_uz/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: const Color(0xff285359),
          // Kursor rangi
          selectionColor: Colors.yellow.withOpacity(0.5),
          // Tanlangan matn rangi
          selectionHandleColor: const Color(
              0xff285359), // Tanlangan matnning tutqichlari ranglari
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
          BlocProvider<VerifyCodeCubit>(create: (context) => VerifyCodeCubit()),
          BlocProvider(create: (context) => UserProfileCubit()),
          BlocProvider<CreateAccountCubit>(
              create: (context) => CreateAccountCubit()),
          BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
          BlocProvider<FatwasCubit>(create: (context) => FatwasCubit()),
          BlocProvider<HomePageCubit>(create: (context) => HomePageCubit()..getCurrentLocation()),
        ],
        child: const BottomNavBar(),
      ),
    );
  }
}

// 1. lib/presentation:
// screens/: Ekranlar yoki sahifalar uchun papka. Har bir ekranning o'ziga xos papkasi bo'lishi mumkin.
// widgets/: Qayta ishlatiladigan kichik widgetlar va UI komponentlari.
// themes/: Ranglar, shriftlar va boshqa UI parametrlarini o'z ichiga olgan mavzular.
// routes/: Ekranlar orasida navigatsiyani boshqarish uchun marshrutlar.
// 2. lib/domain:
// models/: Ma'lumot modellarini saqlash uchun papka.
// repositories/: Ma'lumot olish, saqlash va boshqarish uchun mas'ul bo'lgan interfeyslar.
// entities/: Obyektlarni va ularning logikasini saqlash uchun.
// 3. lib/data:
// datasources/: API, local storage, va boshqa ma'lumot manbalarini boshqarish uchun.
// repositories/: Domain papkasidagi interfeyslarning amaliyotini saqlash uchun.
// models/: Domain modellarini API yoki ma'lumotlar bazasi bilan mos keladigan formatda saqlash uchun.
// 4. lib/core:
// utils/: Yordamchi funksiyalar va xizmatlar.
// errors/: Xatolarni boshqarish uchun papka.
// constants/: Global o'zgaruvchilar va doimiylar.
// 5. lib/injection:
// dependency_injection.dart: Barcha xizmat va sinflarni injekt qilish.
