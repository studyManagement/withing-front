import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/api.dart';

class SignupScreen extends StatefulWidget {
  final String kakaoId;
  const SignupScreen({
    super.key,
    required this.kakaoId,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 프로필 이미지
  XFile? profile;
  String validatorText = '2~10자, 띄어쓰기 및 특수문자 불가';

  bool availableNickname = false;

  final nickNameController = TextEditingController();
  final introduceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
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
              controller: nickNameController,
              decoration: const InputDecoration(
                hintText: '사용할 닉네임을 설정 해주세요.',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xffCED7E1),
                  fontWeight: FontWeight.w600,
                ),
                // suffixIcon: InkWell(
                //   onTap: checkDuplicateNickname,
                //   child: Image.asset(
                //     'asset/duplicationCheck.png',
                //     width: 65,
                //     height: 31,
                //   ),
                // ),
              ),
              autofocus: true,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              onChanged: (val) => checkDuplicateNickname(),
            ),
            const SizedBox(height: 5),
            Text(
              validatorText,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _getValidatorTextColor(),
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
              controller: introduceController,
              decoration: const InputDecoration(
                hintText: '짧은 문장으로 본인을 소개해보세요.',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Color(0xffCED7E1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              maxLength: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                      onTap: availableNickname ? signup : null,
                      child: Container(
                        width: 343,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(availableNickname ? 0xff1F3358 : 0xffCED7E1),
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
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Color(availableNickname ? 0xff1F3358 : 0xffCED7E1),
                    //   ),
                    //   onPressed: availableNickname ? signup : null,
                    //   child: const Text(
                    //     '가입완료',
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 유효성 문구 색상(3가지)
  Color _getValidatorTextColor() {
    if (availableNickname) {
      return const Color(0xff4282FF);
    } else if (validatorText == '2~10자, 띄어쓰기 및 특수문자 불가') {
      return const Color(0xff8B97A4);
    } else {
      return const Color(0xffFF416A);
    }
  }

  /// 중복확인
  void checkDuplicateNickname() async {
    final nickname = nickNameController.text;
    final resp = await Api.checkDuplicateNickname(nickname: nickname);
    // 중복 여부
    final duplicateNickname = resp?.data['success'];

    // 정규 표현식 사용하여 띄어쓰기 및 특수문자 검사
    final regex = RegExp(r'^[a-zA-Z0-9가-힣]*$');
    if (!regex.hasMatch(nickname)) {
      setState(() {
        availableNickname = false;
        validatorText = '특수문자, 띄어쓰기는 사용 불가능해요.';
      });
      return;
    }

    int nickNameLength = nickname.length;
    if (nickNameLength < 2 || nickNameLength > 10) {
      setState(() {
        availableNickname = false;
        validatorText = '닉네임은 2~10 글자로 입력해주세요.';
      });
      return;
    }

    // 중복된 닉네임이라면
    if (duplicateNickname) {
      setState(() {
        availableNickname = false;
        validatorText = '이미 사용중인 닉네임이에요';
      });
    } else {
      setState(() {
        availableNickname = true;
        validatorText = '사용 가능한 닉네임이에요';
      });
    }
  }

  /// 가입 완료 버튼
  void signup() async {
    final resp = await Api.singUp(
      userId: widget.kakaoId,
      nickname: nickNameController.text,
      introduce: introduceController.text,
      userImage: 'test.jpg',
    );
    print(resp?.data);
    print('카카오 아이디 : ${widget.kakaoId}');
    context.go('/home');
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);

              print('카메라');
            },
            child: Image.asset(
              'asset/camera.png',
              width: 32,
              height: 32,
            ),
          ),
        ),
      ],
    );
  }
}
