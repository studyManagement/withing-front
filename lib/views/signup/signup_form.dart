import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modi/common/components/debouncer/debouncer.dart';
import 'package:modi/common/components/picker/image/image_picker.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/utils/get_image_file.dart';
import 'package:modi/view_models/signup/signup_viewmodel.dart';
import 'package:modi/common/components/image/profile.dart';
import 'package:provider/provider.dart';

import '../../common/components/input/text_input.dart';
import '../../common/theme/app/app_colors.dart';
import '../../di/injection.dart';
import '../../service/image/image_create_service.dart';
import '../../service/image/image_update_service.dart';
import '../../view_models/image/image_picker_viewmodel.dart';

class SignupForm extends StatelessWidget {
  SignupForm({super.key});

  final debounce = Debouncer(milliseconds: 300);

  ImageProvider _getImageProvider(ImagePickerViewModel imgVm) {
    return imgVm.selectedImageProvider ??
        const AssetImage('asset/user_default_image.png');
  }

  @override
  Widget build(BuildContext context) {
    SignupViewModel viewModel = context.watch();
    String message = context.select((SignupViewModel vm) => vm.message);
    int rgb = context.select((SignupViewModel vm) => vm.rgb);

    return ChangeNotifierProvider<ImagePickerViewModel>(
      create: (context) => ImagePickerViewModel(
          getIt<ImageUpdateService>(), getIt<ImageCreateService>(), context),
      child: Consumer<ImagePickerViewModel>(builder: (context, imgVm, _) {

        final shapeDecoration = ShapeDecoration(
            shape: const OvalBorder(),
            image: DecorationImage(
              image: _getImageProvider(imgVm),
              fit: BoxFit.cover,
            ));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Profile(
                  shapeDecoration: shapeDecoration,
                  bottomImagePath: 'asset/camera.png',
                  onTap: () {
                    ModiModal.openBottomSheet(
                      context,
                      widget: UserImageBottomSheet(
                          onSelected: () {
                            viewModel.isDefault = false;
                            context.pop();
                          },
                          onDefault: () {
                            viewModel.isDefault = true;
                            context.pop();
                          },
                          viewModel: imgVm),
                      height: 168,
                    );
                  },
            ))),
            const SizedBox(height: 60),
            TextInput(
                '닉네임',
                '사용할 닉네임을 설정해주세요.',
                10,
                (value) => debounce.run(() {
                      viewModel.changeNickname(value);
                    })),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 12,
                color: Color(rgb),
              ),
            ),
            const SizedBox(height: 50),
            TextInput(
              '자기소개',
              '짧은 문장으로 본인을 소개해보세요.',
              30,
              (value) => viewModel.changeDescription(value),
            ),
            Expanded(
              child: Padding(
                padding: kIsWeb || Platform.isAndroid
                    ? const EdgeInsets.symmetric(vertical: 16)
                    : const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: () {
                        viewModel.signup(context, imgVm.imageFile);
                      },
                      child: Container(
                        width: 343,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: viewModel.buttonColor,
                        ),
                        child: const Center(
                          child: Text(
                            '가입 완료',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
