import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/view_models/my/update_profile_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../common/authenticator/authentication.dart';
import '../../common/components/debouncer/debouncer.dart';
import '../../common/components/image/profile.dart';
import '../../common/components/input/text_input.dart';
import '../../common/components/picker/image/image_picker.dart';
import '../../common/modal/modi_modal.dart';
import '../../di/injection.dart';
import '../../service/image/image_create_service.dart';
import '../../view_models/image/image_picker_viewmodel.dart';

class MyProfileScreen extends StatelessWidget {
  final UpdateProfileViewModel viewModel;

  const MyProfileScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    viewModel.fetchUserProfileImage();
    return DefaultLayout(
        title: '프로필 수정',
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ChangeNotifierProvider.value(
                    value: viewModel, child: const UpdateProfileForm()))));
  }
}

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final debounce = Debouncer(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UpdateProfileViewModel>();
    ShapeDecoration? shapeDecoration;

    var image = viewModel.isDefault || viewModel.userImagePath.isEmpty
        ? const AssetImage('asset/user_default_image.png')
        : viewModel.isOldImage
            ? NetworkImage(viewModel.userImagePath)
            : FileImage(viewModel.userImageFile!);

    shapeDecoration = ShapeDecoration(
        shape: const OvalBorder(),
        image: DecorationImage(
          image: image as ImageProvider,
          fit: BoxFit.cover,
        ));

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
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
                                if (imgVm.isSelected) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    viewModel.userImageFile = imgVm.imageFile;
                                    viewModel.userImagePath = imgVm.imagePath;
                                  });
                                }
                                return UserImageBottomSheet(
                                  onSelected: () {
                                    imgVm.createImage().then((value) =>
                                        viewModel.userImageUuid =
                                            imgVm.imageUuid);
                                    viewModel.isOldImage = false;
                                    viewModel.isDefault = false;
                                    context.pop();
                                  },
                                  onDefault: () async {
                                    viewModel.userImagePath =
                                        'asset/user_default_image.png';
                                    viewModel.isDefault = true;
                                    context.pop();
                                  },
                                );
                              })),
                          height: 168);
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () => viewModel.updateUserProfile(),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: viewModel.buttonColor),
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
            ),
          ],
        ),
      ),
    );
  }
}
