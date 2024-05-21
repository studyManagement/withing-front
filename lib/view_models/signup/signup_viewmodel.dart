import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/utils/get_image_file.dart';
import 'package:modi/model/signup/signup_exception.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/signup/signup_service.dart';

import '../../di/injection.dart';

class SignupViewModel extends ChangeNotifier {
  final SignupService _service;

  final String _provider;
  final String _uuid;
  late String _introduce;
  late String _nickname;
  String _userImagePath = '';
  late String _userImageUuid;
  File? _userImageFile;
  bool isOldImage = true;

  String get userImagePath => _userImagePath;
  File? get userImageFile => _userImageFile;

  String message = '2-10자, 띄어쓰기 및 특수문자 불가';
  int rgb = 0xFF8B97A4;

  SignupViewModel(this._provider, this._uuid, this._service);

  set userImageUuid(String value){
    _userImageUuid = value;
    notifyListeners();
  }
  set userImageFile(File? file) {
    _userImageFile = file;
    notifyListeners();
  }

  set userImagePath(String value){
    _userImagePath = value;
    notifyListeners();
  }

  _checkViolationWords(String nickname) {
    final matchPattern = RegExp(r'(\s|[^a-zA-Zㄱ-힣0-9])');
    return matchPattern.hasMatch(nickname);
  }

  changeNickname(String nickname) async {
    try {
      if (nickname.length < 2) {
        throw SignupException('닉네임은 2-10글자여야해요.');
      }

      if (_checkViolationWords(nickname)) {
        throw SignupException('특수문자, 띄어쓰기는 사용 불가능해요.');
      }

      bool isDuplicate = await _service.isDuplicate(nickname);
      if (isDuplicate) {
        throw SignupException('이미 사용중인 닉네임이에요.');
      }

      message = '사용 가능한 닉네임이에요.';
      rgb = 0xFF4282FF;

      _nickname = nickname;
    } on SignupException catch (error) {
      message = error.cause;
      rgb = 0xFFFF416A;
    } finally {
      notifyListeners();
    }
  }

  changeDescription(String introduce) {
    _introduce = introduce;
  }

  createImage(BuildContext context) async {
    try{
      if(_userImagePath.isEmpty) _userImagePath = "https://static.moditeam.io/asset/default/representative/default.png";
      _userImageFile = await fileFromImageUrl(_userImagePath);
      _userImageUuid = await getIt<ImageCreateService>().callImageCreateApi(_userImageFile!);
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }

  signup(BuildContext context) async {
    try {
      await createImage(context);
      await _service.signup(_provider, _nickname, _uuid, _userImageUuid, _introduce);

      if (!context.mounted) return;
      context.go('/');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }
}
