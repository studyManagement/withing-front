import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFile() async {
  ImagePicker imagePicker = ImagePicker();
  final xFile = await imagePicker.pickImage(source: ImageSource.gallery);
  return xFile == null ? null : File(xFile.path);
}

Future<List<File>?> pickMultiImageFile() async {
  ImagePicker imagePicker = ImagePicker();
  final xFiles = await imagePicker.pickMultiImage();
  return xFiles.isNotEmpty ? xFiles.map((e) => File(e.path)).toList() : null;
}
