part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}
class HomePageLoading extends HomePageState {}
class HomePageLoaded extends HomePageState {
  final String address;
  HomePageLoaded(this.address);
}
class HomePageError extends HomePageState {
  String error;
  HomePageError(this.error);

}