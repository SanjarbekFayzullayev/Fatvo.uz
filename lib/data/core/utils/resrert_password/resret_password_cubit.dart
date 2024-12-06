import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'resret_password_state.dart';
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> savePass(String new_password, String secret_key) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/auth/reset_password/renew/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'new_password': new_password, 'secret_key': secret_key}),
      );

      print('Response: ${response.body}');  // Debugging log

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 ) {
      } else {
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        print('Error Message: $errorMessage');
      }
    } catch (e) {
    }
  }

  Future<void> verifyCode(String email, String code) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/auth/reset_password/verify_code/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );

      print('Response: ${response.body}');  // Debugging log

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 ) {
        final secretKey = responseBody['secret_key'];
        emit(ResetPasswordSuccess(secretKey));
      } else {
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        print('Error Message: $errorMessage');  // Debugging log
        emit(ResetPasswordFailure(errorMessage));
      }
    } catch (e) {
      emit(ResetPasswordFailure('Error: $e'));
    }
  }

}
