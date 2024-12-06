part of '_send_question_cubit.dart';

abstract class SendQuestionAndFileState {}

class SendQuestionAndFileInitial extends SendQuestionAndFileState {}

class SendQuestionAndFileLoading extends SendQuestionAndFileState {}

class SendQuestionAndFileSuccess extends SendQuestionAndFileState {
  final String message;
  final String? fileName;

  SendQuestionAndFileSuccess(this.message, {this.fileName});
}

class SendQuestionAndFileError extends SendQuestionAndFileState {
  final String error;

  SendQuestionAndFileError(this.error);
}
