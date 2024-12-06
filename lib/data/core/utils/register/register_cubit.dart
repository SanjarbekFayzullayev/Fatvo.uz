import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> sendCode(String email) async {
    emit(RegisterLoading());
    const String url = 'https://backfatvo.salyam.uz/api_v1/register/send_code/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure('Failed: ${response.statusCode}'));
      }
    } catch (e) {
      emit(RegisterFailure('Error: $e'));
    }
  }
}
