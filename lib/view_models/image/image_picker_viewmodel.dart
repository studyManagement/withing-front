import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/utils/take_photo.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/image/image_update_service.dart';
import '../../common/components/picker/image/image_picker.dart';
import '../../common/modal/modi_modal.dart';

import '../../common/requester/api_exception.dart';
import '../../common/utils/get_image_file.dart';
import '../../common/utils/pick_image_file.dart';


class ImagePickerViewModel extends ChangeNotifier {
  final List<String> representativeImagesUrl = [
    'https://static.moditeam.io/asset/default/representative/default.png',
    'https://static.moditeam.io/asset/default/representative/group_default.png',
    'https://static.moditeam.io/asset/default/representative/default2.png',
    'https://static.moditeam.io/asset/default/representative/default3.png',
    'https://static.moditeam.io/asset/default/representative/default4.png',
    'https://static.moditeam.io/asset/default/representative/default5.png',
    'https://static.moditeam.io/asset/default/representative/default6.png',
    'https://static.moditeam.io/asset/default/representative/default7.png',
    'https://static.moditeam.io/asset/default/representative/default8.png',
  ];

  final ImageUpdateService? _imageUpdateService;
  final ImageCreateService? _imageCreateService;
  final BuildContext _context;
  String _imagePath = '';
  String _imageUuid = '';
  File? imageFile;
  Image? image;
  Image? defaultImage;
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
      isSelected = true;
      _imageUuid = await _imageCreateService!.callImageCreateApi(imageFile!);
    } on ApiException catch (e) {
      isSelected = false;
      if (!_context.mounted) return;
      ModiModal.openDialog(
          _context, '오류가 발생했어요.', e.cause, false,()=> _context.pop(), () => null);
    }
  }

  setDefaultImage(ObjectType type) {
    defaultImage = Image.network((type == ObjectType.USER)
        ? representativeImagesUrl[0]
        : representativeImagesUrl[1], fit: BoxFit.cover);
    image ??= defaultImage;
  }

  takeOrPickPhoto(ImageSource source, ObjectType type) async {
    int index = (type == ObjectType.USER) ? 0 : 1;
    File? file;
    if (source == ImageSource.camera) {
      file = await takePhoto();
    } else {
      file = await pickImageFile();
    }
    setImageFile((file == null) ? representativeImagesUrl[index] : file.path);
  }

  setImageFile(String imageUrl) async {
    _imagePath = imageUrl;
    if (representativeImagesUrl.contains(_imagePath)) {
      // 대표 이미지
      imageFile = await fileFromImageUrl(_imagePath);
      image = Image.network(_imagePath,fit: BoxFit.cover);
    } else {
      // 사용자 선택 이미지
      imageFile = File(imageUrl);
      image = Image.file(imageFile!, fit: BoxFit.cover);
    }
    notifyListeners();
  }


}
