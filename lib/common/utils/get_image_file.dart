import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


Future<File?> fileFromImageUrl(String imageUrl) async {
  var rng = Random();
  Directory tempDir = await getTemporaryDirectory();

  String tempPath = "${tempDir.parent.parent.path}/tmp/";

  File file = File('$tempPath' + (rng.nextInt(10000)).toString() + '.png');

  http.Response response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
  return null;
}


Future<File> getImageFileFromAssets(String path) async {
  // Asset 이미지 로드
  ByteData data = await rootBundle.load(path);

  // ByteData를 파일로 변환
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = '$tempPath.png'; // 임시 파일 경로

  File file = await File(filePath).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));

  return file;
}