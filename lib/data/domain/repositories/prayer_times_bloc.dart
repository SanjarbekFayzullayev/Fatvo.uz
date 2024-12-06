import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/prayer_times.dart';

part 'prayer_times_event.dart';

part 'prayer_times_state.dart';

class PrayerTimesBloc extends Bloc<PrayerTimesEvent, PrayerTimesState> {
  PrayerTimesBloc() : super(PrayerTimesInitial()) {
    @override
    Stream<PrayerTimesState> mapEveentToState(PrayerTimesEvent event) async* {
      if (event is LoadPrayerTimes) {
        yield PrayerTimesLoading();
        try {
          // Assuming location is passed as a parameter to the API
          final response = await http.get(Uri.parse(
              'https://backfatvo.salyam.uz/api_v1/prayer_times/?region=${event.location}'));

          if (response.statusCode == 200) {
            List jsonResponse = json.decode(response.body);
            List<PrayerTimes> prayerTimesList =
                jsonResponse.map((e) => PrayerTimes.fromJson(e)).toList();
            yield PrayerTimesLoaded(prayerTimesList);
          } else {
            yield PrayerTimesError("Error ");
          }
        } catch (e) {
          yield PrayerTimesError(
            e.toString(),
          );
        }
      }
    }
  }
}
