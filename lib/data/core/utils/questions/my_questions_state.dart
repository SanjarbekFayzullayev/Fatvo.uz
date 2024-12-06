part of 'my_questions_cubit.dart';

abstract class MyQuestionsState {}

class MyQuestionsInitial extends MyQuestionsState {}
class MyQuestionsLoading extends MyQuestionsState {}
class MyQuestionsLoaded extends MyQuestionsState {
  final List<MyQuestions> questions;
  MyQuestionsLoaded(this.questions);
}
class MyQuestionsError extends MyQuestionsState {
  final String message;
  MyQuestionsError(this.message);
}


