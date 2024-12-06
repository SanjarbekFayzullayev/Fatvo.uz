import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part '_reset_password_send_code_email_state.dart';

class ResetPasswordSendCodeEmailCubit
    extends Cubit<ResetPasswordSendCodeEmailState> {
  ResetPasswordSendCodeEmailCubit()
      : super(ResetPasswordSendCodeEmailInitial());

  Future<void> sendCode(String email) async {
    emit(ResetPasswordSendCodeEmailLoading());
    const String url = 'https://backfatvo.salyam.uz/api_v1/auth/reset_password/send_code/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        emit(ResetPasswordSendCodeEmailSuccess());
      } else {
        emit(ResetPasswordSendCodeEmailFailure(
            'Failed: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ResetPasswordSendCodeEmailFailure('Error: $e'));
    }
  }
}
