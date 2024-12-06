import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
part 'create_account_state.dart';
class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  Future<void> createAccount({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
    required String key,
  }) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/register/create_account/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
          "email": email,
          "secret_key": key
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("Akkaunt yaratuldi");
        emit(CreateAccountSuccess());
      } else {
        final errorMessage = responseBody['error'] ?? 'Unknown error';
        emit(CreateAccountFailure(errorMessage));
      }
    } catch (e) {
      emit(CreateAccountFailure('Error: ${e.toString()}'));
    }
  }
}

