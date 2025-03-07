import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/utils/compress_image_file.dart';

Future<File?> pickImageFile() async {
  ImagePicker imagePicker = ImagePicker();
  final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
  return xFile == null ? null : await compressImageFile(File(xFile.path));
}

Future<List<File?>> pickMultiImageFile() async {
  ImagePicker imagePicker = ImagePicker();
  final xFiles = await imagePicker.pickMultiImage();

  if (xFiles.isNotEmpty) {
    final files = await Future.wait(xFiles.map((e) async {
      return await compressImageFile(File(e.path));
    }));
    return files;
  } else {
    return [];
  }
}

