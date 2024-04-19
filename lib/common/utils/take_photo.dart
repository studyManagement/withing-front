import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> takePhoto() async {
  final picker = ImagePicker();
  final imageFile = await picker.pickImage(
    source: ImageSource.camera,
  );
  if (imageFile != null) {
    return File(imageFile.path);
  } else {
    print('No image selected.');
    return null;
  }
}