import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool nicknameDuplicateCheckSuccessful = true;

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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: '사용할 닉네임을 설정해주세요.',
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: Image.asset(
                  'asset/duplicationCheck.png',
                  width: 65,
                  height: 31,
                ),
              ),
              autofocus: true,
              maxLength: 10,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: nicknameDuplicateCheckSuccessful ? const Color(0xFF1F3358) : const Color(0xFFCED7E1),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

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
          child: Image.asset(
            'asset/camera.png',
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
