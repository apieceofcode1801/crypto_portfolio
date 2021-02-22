import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IOService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> readFile(String fileName) async {
    try {
      final file = await _localFile(fileName);
      return await file.readAsString();
    } catch (e) {
      print('Could not read file: $e');
      return '';
    }
  }
}
