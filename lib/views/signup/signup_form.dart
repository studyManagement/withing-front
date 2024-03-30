import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modi/common/components/picker/image/image_picker.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/view_models/signup/signup_viewmodel.dart';
import 'package:modi/views/signup/signup_profile.dart';
import 'package:provider/provider.dart';

import '../../common/components/input/text_input.dart';

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
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                ModiModal.openBottomSheet(
                  context,
                  widget: const Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 30),
                    child: ImagePicker(),
                  ),
                  height: 440,
                );
              },
              child: const Profile(),
            ),
          ),
        ),
        const SizedBox(height: 60),
        TextInput(
          '닉네임',
          '사용할 닉네임을 설정해주세요.',
          10,
          (value) => viewModel.changeNickname(value),
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
