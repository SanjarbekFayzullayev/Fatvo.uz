import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class QuranService {
  final Dio _dio = Dio();
  final Map<String, CancelToken> _cancelTokens = {}; // CancelToken saqlash uchun xarita

  // Suralarni olish
  Future<List<dynamic>> fetchSurahs() async {
    final response = await _dio.get("https://equran.id/api/v2/surat");
    return response.data['data'];
  }

  // Audio faylni yuklab olish
  Future<String> downloadAudio(String url, String fileName,
      {Function(int, int)? onProgress}) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName.mp3";

    if (File(filePath).existsSync()) {
      return filePath; // Fayl allaqachon mavjud
    }

    final cancelToken = CancelToken();
    _cancelTokens[fileName] = cancelToken;

    try {
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        throw Exception("Yuklab olish bekor qilindi!");
      }
      throw Exception("Yuklab olish xatoligi: ${e.message}");
    } catch (e) {
      throw Exception("Xatolik yuz berdi: $e");
    } finally {
      _cancelTokens.remove(fileName); // CancelToken o'chirilsin
    }

    return filePath;
  }

  // Yuklab olishni bekor qilish
  void cancelDownload(String fileName) {
    if (_cancelTokens.containsKey(fileName)) {
      _cancelTokens[fileName]?.cancel();
      _cancelTokens.remove(fileName);
    }
  }
}
