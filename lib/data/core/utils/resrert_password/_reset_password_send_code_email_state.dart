part of '_reset_password_send_code_email_cubit.dart';
abstract class ResetPasswordSendCodeEmailState {}

class ResetPasswordSendCodeEmailInitial extends ResetPasswordSendCodeEmailState {}
class ResetPasswordSendCodeEmailLoading extends ResetPasswordSendCodeEmailState{}
class ResetPasswordSendCodeEmailSuccess extends ResetPasswordSendCodeEmailState{}
class ResetPasswordSendCodeEmailFailure extends ResetPasswordSendCodeEmailState{
  final String error;
  ResetPasswordSendCodeEmailFailure(this.error);

}