import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/debouncer/debouncer.dart';
import 'package:modi/common/components/picker/image/image_picker.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/view_models/signup/signup_viewmodel.dart';
import 'package:modi/common/components/image/profile.dart';
import 'package:provider/provider.dart';

import '../../common/components/input/text_input.dart';
import '../../di/injection.dart';
import '../../service/image/image_create_service.dart';
import '../../service/image/image_update_service.dart';
import '../../view_models/image/image_picker_viewmodel.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final debounce = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    SignupViewModel viewModel = context.watch();
    String message = context.select((SignupViewModel vm) => vm.message);
    int rgb = context.select((SignupViewModel vm) => vm.rgb);

    ShapeDecoration? shapeDecoration;
    var image = (viewModel.isOldImage)
        ? NetworkImage(viewModel.userImagePath)
        : FileImage(viewModel.userImageFile!);
    shapeDecoration = ShapeDecoration(
        shape: const OvalBorder(),
        image: DecorationImage(
          image: image as ImageProvider,
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
                  widget: ChangeNotifierProvider<ImagePickerViewModel>(
                    create: (context) => ImagePickerViewModel(
                        getIt<ImageUpdateService>(),
                        getIt<ImageCreateService>(),
                        context),
                    child: Consumer<ImagePickerViewModel>(
                      builder: (context, imgVm, _) {
                        imgVm.setDefaultImage(ObjectType.USER);
                        if (imgVm.isSelected) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            viewModel.userImageFile = imgVm.imageFile;
                            viewModel.userImagePath = imgVm.imagePath;
                          });
                        }
                        return ImagePicker(
                          onSelected: (){
                            imgVm.createImage().then((value) =>
                            viewModel.userImageUuid = imgVm.imageUuid);
                            viewModel.isOldImage = false;
                            context.pop();
                          },
                          type:ObjectType.USER,
                        );
                      }
                    ),
                  ),
                  height: 496,
                );
              },
            ),
          ),
        ),
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
                    viewModel.signup(context);
                  },
                  child: Container(
                    width: 343,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff1F3358),
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
  }
}
