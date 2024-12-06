import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:fatvo_uz/presentation/screens/bootom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final Map<String, dynamic> userProfile;

  UserProfileLoaded(this.userProfile);
}

class UserProfileError extends UserProfileState {
  final String error;

  UserProfileError(this.error);
}

// Cubit
class UserProfileCubit extends Cubit<UserProfileState> {

  UserProfileCubit() : super(UserProfileInitial());
  bool sendQues=false;
  void showLogoutDialog(BuildContext context, UserProfileCubit userProfileCubit,
      String firstName, String lastName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$firstName \nakkauntingizdan chiqishni istaysizmi?'),
          actions: [
            OutlinedButton(
              child: const Text('Yo\'q',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
                fontSize: 20,
              ),),
              onPressed: () {
                Navigator.of(context).pop(); // Dialogni yopish
              },
            ),
            OutlinedButton(
              child: const Text(
                'Ha',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
              onPressed: () async {
                var pass = await SharedPreferencesHelper().getPass();
                var email = await SharedPreferencesHelper().getEmail();

                // Cubit orqali logoutni chaqirish
                userProfileCubit.logoutAccount(
                  firstName: firstName,
                  lastName: lastName,
                  password: pass.toString(),
                  email: email.toString(),
                );

                SharedPreferencesHelper()
                    .allClear(); // Saqlangan ma'lumotlarni tozalash
                print(email.toString());

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getUserProfile() async {
    const url =
        'https://backfatvo.salyam.uz/api_v1/user/profile/'; // Profil uchun API manzili
    final token = await getToken(); // Saqlangan tokenni olish

    if (token != null) {
      try {
        emit(UserProfileLoading()); // Yuklanayotgan holatni chiqarish
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // Tokenni headerda jo'natish
          },
        );

        if (response.statusCode == 200) {
          sendQues=true;
          print("$sendQues true boldi");
          // Javob muvaffaqiyatli bo'lsa, foydalanuvchi ma'lumotlarini olish
          final data = jsonDecode(response.body);
          emit(UserProfileLoaded(data),); // Foydalanuvchi ma'lumotlarini yuklash
        } else {
          // Xatolik bo'lsa, kodni va xabarni ko'rsatish
          final errorMessage =
              'Xatolik: ${response.statusCode} - ${response.reasonPhrase}';
          emit(UserProfileError(errorMessage)); // Xatolikni chiqarish
        }
      } catch (e) {
        // Agar so'rovda xato bo'lsa
        final errorMessage = 'So\'rovda xatolik: $e';
        emit(UserProfileError(errorMessage)); // Xatolikni chiqarish
      }
    } else {
      emit(UserProfileError(
          'Token mavjud emas')); // Token mavjud emas xatolik holati
    }
  }

  Future<void> logoutAccount({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
  }) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/auth/logout/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Akkaunt o'shirildi");
      } else {
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        emit(UserProfileError(errorMessage));
      }
    } catch (e) {
      emit(UserProfileError('Error: ${e.toString()}'));
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('auth_token')
        .toString(); // Token mavjud bo'lmasa, null qaytaradi
  }
}
