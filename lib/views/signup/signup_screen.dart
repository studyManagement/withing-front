import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/signup/signup_service.dart';
import 'package:modi/view_models/signup/signup_viewmodel.dart';
import 'package:modi/views/signup/signup_form.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  String provider;
  String uuid;

  SignupScreen(this.provider, this.uuid, {super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      resizeToAvoidBottomInset: false,
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () => context.pop(),
      ),
      title: '프로필 설정',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ChangeNotifierProvider(
          create: (context) =>
              SignupViewModel(provider, uuid, getIt<SignupService>()),
          child: const SignupForm(),
        ),
      ),
    );
  }
}
