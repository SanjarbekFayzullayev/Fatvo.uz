part of 'fatwas_cubit.dart';
// State'lar
abstract class FatwasState {}

class FatwasInitial extends FatwasState {}

class FatwasLoading extends FatwasState {}

class FatwasLoaded extends FatwasState {
  final FatwasModel fatwas;
  FatwasLoaded(this.fatwas);
}

class FatwasError extends FatwasState {
  final String error;
  FatwasError(this.error);
}
