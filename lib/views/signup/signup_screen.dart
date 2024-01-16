import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/di/injection.dart';
import 'package:withing/service/signup/signup_service.dart';
import 'package:withing/view_models/signup/signup_viewmodel.dart';
import 'package:withing/views/signup/signup_form.dart';

class SignupScreen extends StatelessWidget {
  String provider;
  String accessToken;

  SignupScreen(this.provider, this.accessToken, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '프로필 설정',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ChangeNotifierProvider(
          create: (context) => SignupViewModel(getIt<SignupService>()),
          child: const SignupForm(),
        ),
      ),
    );
  }
}
