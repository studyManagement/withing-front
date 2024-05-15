import 'package:flutter/cupertino.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/service/image/image_update_service.dart';
import 'package:modi/service/user/user_service.dart';
import 'package:modi/view_models/my/update_profile_viewmodel.dart';
import 'package:modi/views/my/update_profile_form.dart';
import 'package:provider/provider.dart';
import '../../di/injection.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: '프로필 수정',
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ChangeNotifierProvider(
                create: (context) => UpdateProfileViewModel(
                    context, getIt<UserService>()),
                child: Consumer<UpdateProfileViewModel>(
                    builder: (context, consumer, child) {
                      consumer.fetchUserProfileImage();
                  return const UpdateProfileForm();
                }))));
  }
}
