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
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
