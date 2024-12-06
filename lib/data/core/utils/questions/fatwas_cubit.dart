import 'package:bloc/bloc.dart';
import 'package:fatvo_uz/data/domain/models/fatwas.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'fatwas_state.dart';

class FatwasCubit extends Cubit<FatwasState> {
  FatwasCubit() : super(FatwasInitial());

  Future<void> fetchFatwas(int page) async {
    emit(FatwasLoading());

    final url = 'https://backfatvo.salyam.uz/api_v1/questions/?page=$page';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final fatwas = FatwasModel.fromJson(jsonData);
        emit(FatwasLoaded(fatwas));
      } else {
        emit(FatwasError('Failed to load fatwas'));
      }
    } catch (e) {
      emit(FatwasError('Error: $e'));
    }
  }
}
