import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFile() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

  if (xFile == null) return null;
  File imageFile = File(xFile.path);

  return imageFile;
}
