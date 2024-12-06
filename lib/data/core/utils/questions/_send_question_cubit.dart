import 'package:bloc/bloc.dart';
import 'package:fatvo_uz/data/core/utils/register/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart';

part '_send_question_state.dart';

class SendQuestionAndFileCubit extends Cubit<SendQuestionAndFileState> {
  SendQuestionAndFileCubit() : super(SendQuestionAndFileInitial());

  Future<void> sendQuestionAndFile({
    required String question,
    File? file, // Add token as a required parameter
  }) async {
    const url = 'https://backfatvo.salyam.uz/api_v1/send_question/'; // API URL

    try {
      emit(SendQuestionAndFileLoading()); // Emit loading state

      if (file != null) {
        // If a file is attached
        var request = http.MultipartRequest('POST', Uri.parse(url));

        // Add question
        request.fields['question'] = question;

        // Add file
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        request.files.add(http.MultipartFile(
          'attached_file',
          fileStream,
          length,
          filename: basename(file.path), // Get file name
        ));
        var token = await SharedPreferencesHelper().getToken();
        // Add authentication header
        request.headers['Authorization'] = 'Bearer ${token.toString()}';

        // Send the request
        var response = await request.send();

        // Read response as String
        var responseBody = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          emit(SendQuestionAndFileSuccess(
              'Savol va fayl muvaffaqiyatli jo\'natildi',
              fileName: basename(file.path))); // Send file name
        } else {
          emit(SendQuestionAndFileError(
              'Xatolik yuz berdi: ${response.statusCode} - $responseBody'));
        }
      } else {
        var token = await SharedPreferencesHelper().getToken();
        // If no file is attached
        var response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token.toString()}', // Add authentication header
          },
          body: jsonEncode({'question': question}),
        );

        if (response.statusCode == 200) {
          emit(SendQuestionAndFileSuccess('Savol muvaffaqiyatli jo\'natildi'));
        } else {
          emit(SendQuestionAndFileError(
              'Xatolik yuz berdi: ${response.statusCode} - ${response.body}'));
        }
      }
    } catch (e) {
      emit(SendQuestionAndFileError('Xatolik: $e'));
    }
  }
}
