import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/utils/compress_image_file.dart';

Future<File?> takePhoto() async {
  final picker = ImagePicker();
  final imageFile = await picker.pickImage(
    source: ImageSource.camera,
  );
  if (imageFile != null) {
    return compressImageFile(File(imageFile.path));
  } else {
    print('No image selected.');
    return null;
  }
}