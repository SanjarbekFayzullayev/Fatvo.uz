// lib/cubits/auth_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String token;

  AuthSuccess(this.token);
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class AuthCubit extends Cubit<AuthState> {


  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/auth/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          responseBody['access'].toString().isNotEmpty) {
        final token = responseBody['access'];

        // Save token in SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token.toString());
        await prefs.setString('email', email.toString());
        await prefs.setString('password', password.toString());

        print('Login muvaffaqiyatli: Token - $token');
        saveToken(token);
        print("Token shareddda");
        emit(AuthSuccess(token));
      } else {
        final errorMessage =
            responseBody['password'] ?? "Parol noto'g'ri kiritilgan";
        emit(AuthFailure(errorMessage));
      }
    } catch (e) {
      emit(AuthFailure('Error: $e'));
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    }

    Future<void> removeToken() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    }
  }
  static Future<void> savePass(String pass) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_pass', pass);

    Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    }

    Future<void> removeToken() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    }
  }

   Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }


}

class SharedPreferencesHelper {

  Future<String?> getPass() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
  allClear() async {
    final prefs = await SharedPreferences.getInstance();
     prefs.clear();
     print("Sharred bosh");
  }
  // Tokenni olish
   Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token').toString(); // Token mavjud bo'lmasa, null qaytaradi
  }
}
