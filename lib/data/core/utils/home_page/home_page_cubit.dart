import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  String _locationMessage = "Joylashuvni olish uchun kuting...";
  static const String _addressKey = "saved_address";
  static const String _latitudeKey = "saved_latitude";
  static const String _longitudeKey = "saved_longitude";

  // Joylashuvni olish va saqlash
  void getCurrentLocation() async {
    emit(HomePageLoading());
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Joylashuv xizmati yoqilganligini tekshirish
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _locationMessage = "Joylashuv xizmatlari o'chirilgan.";
        await _loadLocationFromSharedPreferences();
        return;
      }

      // Ruxsatlarni tekshirish
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _locationMessage = "Joylashuvga ruxsat berilmadi.";
          await _loadLocationFromSharedPreferences();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _locationMessage = "Joylashuvga ruxsat abadiy bekor qilingan.";
        await _loadLocationFromSharedPreferences();
        return;
      }

      // Joylashuvni olish
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];
      String address = "${place.locality}, ${place.country}";
      _locationMessage =
      "Koordinatalar: ${position.latitude}, ${position.longitude}";

      // SharedPreferences ga joylashuv va koordinatalarni saqlash
      await _saveLocationToSharedPreferences(
          address, position.latitude, position.longitude);

      print("Joylashuv: $address");

      emit(HomePageLoaded(address));
    } catch (e) {
      _locationMessage = "Joylashuvni olishda xato: $e";
      await _loadLocationFromSharedPreferences();
    }
  }

  // SharedPreferences ga joylashuv va koordinatalarni saqlash
  Future<void> _saveLocationToSharedPreferences(
      String address, double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_addressKey, address);
    await prefs.setDouble(_latitudeKey, latitude);
    await prefs.setDouble(_longitudeKey, longitude);

    print("Joylashuv va koordinatalar saqlandi: $address, $latitude, $longitude");
  }

  // SharedPreferences dan joylashuvni yuklash
  Future<void> _loadLocationFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedAddress = prefs.getString(_addressKey);

    if (savedAddress != null) {
      double? latitude = prefs.getDouble(_latitudeKey);
      double? longitude = prefs.getDouble(_longitudeKey);

      print("Saqlangan joylashuv yuklandi: $savedAddress");
      print("Saqlangan koordinatalar: $latitude, $longitude");

      emit(HomePageLoaded(savedAddress));
    } else {
      emit(HomePageError("Saqlangan joylashuv topilmadi."));
    }
  }
}
