import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

Future<File?> compressImageFile(File imageFile, {int quality = 80, int width = 800}) async {
  // 이미지를 byte 배열로 읽기
  List<int> imageBytes = await imageFile.readAsBytes();

  // image 패키지로 이미지 디코딩
  img.Image? image = img.decodeImage(Uint8List.fromList(imageBytes));

  if (image == null) {
    return null;
  }

  // 이미지 압축 (해상도 축소 및 품질 설정)
  img.Image compressedImage = img.copyResize(image, width: width); // 해상도 축소
  List<int> compressedBytes = img.encodeJpg(compressedImage, quality: quality); // 품질 설정하여 압축

  // 압축된 이미지를 새로운 파일로 저장
  File compressedFile = File('${imageFile.path}_compressed.jpg')
    ..writeAsBytesSync(compressedBytes);

  return compressedFile;
}