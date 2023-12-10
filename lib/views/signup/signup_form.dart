import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/view_models/signup/signup_viewmodel.dart';
import 'package:withing/views/signup/signup_profile.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    SignupViewModel viewModel = context.read();
    String message = context.select((SignupViewModel vm) => vm.message);
    int rgb = context.select((SignupViewModel vm) => vm.rgb);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Profile(),
          ),
        ),
        const SizedBox(height: 60),
        const Text(
          '닉네임',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            hintText: '사용할 닉네임을 설정해주세요.',
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          autofocus: true,
          maxLength: 10,
          onChanged: (value) => viewModel.changeNickname(value),
        ),
        const SizedBox(height: 8),
        Text(
          message,
          style: TextStyle(
            fontSize: 12,
            color: Color(rgb),
          ),
        ),
        const SizedBox(height: 50),
        const Text(
          '자기소개',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: '짧은 문장으로 본인을 소개해보세요.',
            hintStyle: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          maxLength: 30,
          onChanged: (value) => viewModel.changeDescription(value),
        ),
        Expanded(
          child: Padding(
            padding: Platform.isAndroid
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
