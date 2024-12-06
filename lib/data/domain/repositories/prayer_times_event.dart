part of 'prayer_times_bloc.dart';

@immutable
abstract class PrayerTimesEvent {}

class LoadPrayerTimes extends  PrayerTimesEvent{
  late String  location;
  LoadPrayerTimes(this.location);

}
