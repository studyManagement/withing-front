import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/view_models/image/image_picker_viewmodel.dart';
import 'package:modi/view_models/my/update_profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../common/components/debouncer/debouncer.dart';
import '../../common/components/image/profile.dart';
import '../../common/components/input/text_input.dart';
import '../../common/components/picker/image/image_picker.dart';
import '../../common/modal/modi_modal.dart';
import '../../di/injection.dart';
import '../../service/image/image_update_service.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final debounce = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context){
    final viewModel = context.watch<UpdateProfileViewModel>();
    ShapeDecoration? shapeDecoration;
    var image = (viewModel.isOldImage)
        ? NetworkImage(viewModel.userImagePath.isEmpty ? "https://static.moditeam.io/asset/default/representative/default.png" :viewModel.userImagePath)
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
                onTap: () {
                  ModiModal.openBottomSheet(context,
                      widget: ChangeNotifierProvider(
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
                              onSelected: () {
                                imgVm.createImage().then((value) =>
                                viewModel.userImageUuid = imgVm.imageUuid);
                                viewModel.isOldImage = false;
                                context.pop();
                              },
                              type: ObjectType.USER,
                            );
                          })),
                      height: 496);
                },
                bottomImagePath: 'asset/camera.png'),
          ),
        ),
        const SizedBox(height: 60),
        TextInput(
            '닉네임',
            '사용할 닉네임을 설정해주세요.',
            10,
            initialValue: Authentication.instance.nickname,
            (value) => debounce.run(() {
                  viewModel.changeNickname(value);
                })),
        const SizedBox(height: 8),
        Text(
          viewModel.message,
          style: TextStyle(
            fontSize: 12,
            color: Color(viewModel.rgb),
          ),
        ),
        const SizedBox(height: 50),
        TextInput(
          '자기소개',
          '짧은 문장으로 본인을 소개해보세요.',
          30,
          initialValue: Authentication.instance.introduce,
          (value) {
            viewModel.changeDescription(value);
          },
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
                    viewModel
                        .updateUserProfile()
                        .then((value) => context.pop());
                  },
                  child: Container(
                    width: 343,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff1F3358),
                    ),
                    child: const Center(
                      child: Text(
                        '수정 완료',
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
