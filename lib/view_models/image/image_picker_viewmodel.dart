import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/image/image_update_service.dart';
import '../../common/components/picker/image/image_picker.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../common/utils/get_image_file.dart';
import '../../common/utils/pick_image_file.dart';
import '../../common/utils/take_photo.dart';

class ImagePickerViewModel extends ChangeNotifier {
  final List<String> representativeImagePaths = [
    'asset/user_default_image.png',
   'asset/search_category/2_certification.png',
    'asset/search_category/4_exam.png',
    'asset/search_category/5_hobby.png',
    'asset/search_category/3_employment.png',
    'asset/search_category/6_programming.png',
    'asset/search_category/1_language.png'
  ];

  final ImageUpdateService? _imageUpdateService;
  final ImageCreateService? _imageCreateService;
  final BuildContext _context;
  String _imagePath = '';
  String _imageUuid = '';
  File? imageFile;
  Image? image;
  bool isDefault = true;
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  String get imagePath => _imagePath;

  String get imageUuid => _imageUuid;

  set isSelected(bool value) {
    _isSelected = value;
    notifyListeners();
  }

  ImagePickerViewModel(
      this._imageUpdateService, this._imageCreateService, this._context);

  // Future<void> updateImage() async {
  //   try {
  //     _imageUuid = await _imageUpdateService!.callImageUpdateApi(imageFile!);
  //   } on ApiException catch (e) {
  //     if (!_context.mounted) return;
  //     ModiModal.openDialog(
  //         _context, '오류가 발생했어요.', e.cause, false, _context.pop, () => null);
  //   }
  // }

  Future<void> createImage() async {
    try {
      _imageUuid = await _imageCreateService!.callImageCreateApi(imageFile!);
      isSelected = true;
    } on ApiException catch (e) {
      isSelected = false;
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요.', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  ImageProvider? get selectedImageProvider {
    if (imageFile != null && imageFile!.existsSync()) {
      return FileImage(imageFile!);
    } else if (imagePath.isNotEmpty) {
      return NetworkImage(imagePath);
    }
    return null; // 이미지가 없으면 null을 반환
  }

  takeOrPickPhoto(ImageSource source, ObjectType type) async {
    int index = (type == ObjectType.USER) ? 0 : 1;
    File? file;
    if (source == ImageSource.camera) {
      file = await takePhoto();
    } else {
      file = await pickImageFile();
    }
    setImageFile((file == null) ? representativeImagePaths[index] : file.path);
  }

  setImageFile(String imageUrl) async {
    _imagePath = imageUrl;
    if (representativeImagePaths.contains(_imagePath)) {
      // 대표 이미지
      isDefault = true;
      imageFile = await getImageFileFromAssets(_imagePath);
      image = Image.asset(_imagePath, fit: BoxFit.cover);
    } else {
      // 사용자 선택 이미지
      isDefault = false;
      imageFile = File(imageUrl);
      image = Image.file(imageFile!, fit: BoxFit.cover);
    }
    if (imageFile != null) {
      isSelected = true;
    }
    notifyListeners();
  }
}
