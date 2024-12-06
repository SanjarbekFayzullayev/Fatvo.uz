import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit() : super(VerifyCodeInitial());

  Future<void> verifyCode(String email, String code) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/register/verify_code/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['ok'] == true) {
        final secretKey = responseBody['secret_key'];

        emit(VerifyCodeSuccess(secretKey));
      } else {
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        emit(
          VerifyCodeFailure(errorMessage),
        );
      }
    } catch (e) {
      emit(
        VerifyCodeFailure('Error: $e'),
      );
    }
  }

}
