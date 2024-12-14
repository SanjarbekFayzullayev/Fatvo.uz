import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  static Future<String> downloadFile(String url, String fileName) async {
    try {
      // Mahalliy saqlash joyini olish
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Fayl allaqachon yuklanganligini tekshirish
      if (File(filePath).existsSync()) {
        return filePath;
      }

      // Faylni yuklash
      final dio = Dio();
      await dio.download(url, filePath);
      return filePath;
    } catch (e) {
      throw Exception('Faylni yuklashda xato: $e');
    }
  }
}
