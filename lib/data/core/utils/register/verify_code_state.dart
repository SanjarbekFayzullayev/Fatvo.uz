part of 'verify_code_cubit.dart';

abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}

class VerifyCodeLoading extends VerifyCodeState {}

class VerifyCodeSuccess extends VerifyCodeState {
  final String secretKey;

  VerifyCodeSuccess(this.secretKey);
}

class VerifyCodeFailure extends VerifyCodeState {
  final String error;

  VerifyCodeFailure(this.error);
}
