import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fatvo_uz/data/domain/models/my_questions.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'my_questions_state.dart';

class MyQuestionsCubit extends Cubit<MyQuestionsState> {
  MyQuestionsCubit() : super(MyQuestionsInitial());

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchQuestions() async {
    emit(MyQuestionsLoading());
    const url = 'https://backfatvo.salyam.uz/api_v1/questions/mine/';
    final token = await getToken();

    if (token != null) {
      try {
        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> responseData = jsonDecode(response.body);
          final questions =
              responseData.map((json) => MyQuestions.fromJson(json)).toList();
          emit(
            MyQuestionsLoaded(questions),
          );
        } else {
          emit(
            MyQuestionsError('Failed to load questions'),
          );
        }
      } catch (e) {
        emit(
          MyQuestionsError('Error: $e'),
        );
      }
    } else {
      emit(
        MyQuestionsError('Token not found'),
      );
    }
  }
}
