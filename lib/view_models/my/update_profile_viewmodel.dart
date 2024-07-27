import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/root_tab.dart';
import 'package:modi/common/router/router_service.dart';
import 'package:modi/model/user/token_model.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/service/signup/signup_service.dart';
import 'package:modi/service/user/user_service.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';
import '../../common/theme/app/app_colors.dart';
import '../../common/utils/get_image_file.dart';
import '../../di/injection.dart';
import '../../model/signup/signup_exception.dart';
import '../../model/user/user_model.dart';
import '../../service/image/image_create_service.dart';
import '../../views/my/my_screen.dart';

class UpdateProfileViewModel extends ChangeNotifier {
  final UserService _userService;
  final BuildContext _context;

  String _nickname = Authentication.instance.nickname;
  String _introduce = Authentication.instance.introduce;
  String _userImagePath = '';
  String _userImageUuid = '';
  File? _userImageFile;
  String message = '2-10자, 띄어쓰기 및 특수문자 불가';
  int rgb = 0xFF8B97A4;
  bool isOldImage = true;
  bool isDefault = false;
  String appVersion = '';
  bool isLoading = true;

  String get nickname => _nickname;

  String get introduce => _introduce;

  String get userImagePath => _userImagePath;

  File? get userImageFile => _userImageFile;
  Color buttonColor = AppColors.blue600;

  set userImageFile(File? file) {
    _userImageFile = file;
    notifyListeners();
  }

  set userImagePath(String value) {
    _userImagePath = value;
    notifyListeners();
  }

  set userImageUuid(String value) {
    _userImageUuid = value;
    notifyListeners();
  }

  UpdateProfileViewModel(this._context, this._userService);

  refreshData(){
    _userImagePath = '';
    fetchUserProfileImage();
    getAppVersion();
    notifyListeners();
  }

  Future<void> getAppVersion() async {
    rootBundle
        .loadString("pubspec.yaml")
        .then((yamlValue) => appVersion = loadYaml(yamlValue)['version']);
  }

  Future<void> fetchUserProfileImage() async {
    // 프로필 수정 화면으로 이동 시
    if (_userImagePath.isEmpty) {
      try {
        UserModel user = await _userService.fetchMe();
        _nickname = user.nickname;
        _introduce = user.introduce;
        _userImagePath = user.profileImage!;
        _userImageFile = File(_userImagePath);
        isLoading = false;
        notifyListeners();
      } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요.', e.cause, false,
            () => _context.pop(), () => null);
      }
    }
  }

  Future<void> updateUserProfile() async {
    try {
      if (_userImageUuid.isEmpty) {
        _userImageFile = (isDefault)
            ? await getImageFileFromAssets(_userImagePath)
            : await fileFromImageUrl(_userImagePath);
        _userImageUuid = await getIt<ImageCreateService>()
            .callImageCreateApi(_userImageFile!);
      }
      TokenModel token =
          await _userService.edit(_nickname, _introduce, _userImageUuid);
      Authentication.from(token.accessToken, token.refreshToken);
      Authentication.instance.save();
      _userImagePath = '';
      notifyListeners();
      if(!_context.mounted) return;
      _context.pop();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요.', e.cause, false,
          () => _context.pop(), () => null);
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

      bool isDuplicate = await getIt<SignupService>().isDuplicate(nickname) &&
          nickname != _nickname;
      if (isDuplicate) {
        throw SignupException('이미 사용중인 닉네임이에요.');
      }

      message = '사용 가능한 닉네임이에요.';
      rgb = 0xFF4282FF;
      buttonColor = AppColors.blue600;
      _nickname = nickname;
    } on SignupException catch (error) {
      message = error.cause;
      rgb = 0xFFFF416A;
      buttonColor = AppColors.gray200;
    } finally {
      notifyListeners();
    }
  }

  changeDescription(String introduce) {
    _introduce = introduce;
  }
}
