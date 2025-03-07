import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/utils/compress_image_file.dart';

Future<File?> pickImageFile() async {
  ImagePicker imagePicker = ImagePicker();

  XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

  if (xFile == null) return null;
  File? imageFile = await compressImageFile(File(xFile.path));

  return imageFile;
}
