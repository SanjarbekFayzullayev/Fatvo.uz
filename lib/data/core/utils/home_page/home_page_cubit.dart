import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  String _locationMessage = "Joylashuvni olish uchun kuting...";

  void getCurrentLocation() async {
    emit(HomePageLoading());
    bool serviceEnabled;
    LocationPermission permission;

    // Joylashuv xizmati yoqilganligini tekshirish
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _locationMessage = "Joylashuv xizmatlari o'chirilgan.";
      emit(HomePageError(_locationMessage));
      return;
    }

    // Ruxsatlarni tekshirish
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _locationMessage = "Joylashuvga ruxsat berilmadi.";
        emit(HomePageError(_locationMessage));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _locationMessage = "Joylashuvga ruxsat abadiy bekor qilingan.";
      emit(HomePageError(_locationMessage));
      return;
    }

    // Joylashuvni olish
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      _locationMessage =
      "Koodrinatalar: ${position.latitude}, ${position.longitude}";
      print("Mana ku: ${place.locality}, ${place.country}");
      String address = "${place.locality}, ${place.country}";

      // Address is successfully retrieved, emit the loaded state
      emit(HomePageLoaded(address));
    } catch (e) {
      _locationMessage = "Joylashuvni olishda xato: $e";
      emit(HomePageError(_locationMessage));
    }
  }
}
