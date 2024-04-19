import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/user/token_model.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/service/signup/signup_service.dart';
import 'package:modi/service/user/user_service.dart';
import '../../di/injection.dart';
import '../../model/signup/signup_exception.dart';

class UpdateProfileViewModel extends ChangeNotifier{
  final UserService _userService;
  final ImageUpdateService _imageUpdateService;
  final BuildContext _context;

  String _nickname = Authentication.instance.nickname;
  String _introduce = Authentication.instance.introduce;
  String _userImagePath = "https://static.moditeam.io/asset/default/representative/default.webp";
  String _userImageUuid = '';
  File? _userImageFile;
  String message = '2-10자, 띄어쓰기 및 특수문자 불가';
  int rgb = 0xFF8B97A4;
  bool isOldImageLoaded = false;

  String get nickname => _nickname;
  String get introduce => _introduce;
  String get userImagePath => _userImagePath;
  File? get userImageFile => _userImageFile;

  set userImageFile(File? file) {
    _userImageFile = file;
    notifyListeners();
  }


  set userImagePath(String value) {
    _userImagePath = value;
    notifyListeners();
  }


  UpdateProfileViewModel(this._context, this._userService ,this._imageUpdateService);

  Future<void> updateProfileImage() async{
    try{
      _userImageUuid = await _imageUpdateService.callImageUpdateApi(File(_userImagePath));
    } on ApiException catch(e){
      if(!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요.', e.cause, false, () => null, () => null);
    }
  }

  Future<void> updateUserProfile() async {
    try {
      TokenModel token = await _userService.edit(_nickname, _introduce, _userImageUuid);

      Authentication.from(token.accessToken, token.refreshToken);
      Authentication.instance.save();

      notifyListeners();
    } on ApiException catch (e){
      if(!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요.', e.cause, false, () => null, () => null);
    }

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

      bool isDuplicate = await getIt<SignupService>().isDuplicate(nickname) && nickname != _nickname;
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


}