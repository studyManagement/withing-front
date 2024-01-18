import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/components/badge_multi_selector.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/view_models/new_study/text_input_validation_provider.dart';
import 'package:withing/views/new_study/widgets/text_input_group.dart';
import '../../common/theme/app/app_colors.dart';

class NewStudyScreen extends StatelessWidget {
  const NewStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextInputValidationProvider(),
      child: Consumer<TextInputValidationProvider>(
        builder: (context, validate, child) {
          return DefaultLayout(
            title: '스터디 생성하기',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 105,
                    height: 105,
                    decoration: const ShapeDecoration(
                      color: AppColors.gray150,
                      shape: OvalBorder(),
                    ),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        debugPrint('프로필 사진 선택');
                      },
                      child: Image.asset(
                        'asset/camera.png',
                        scale: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                TextInputGroup(
                  title: '스터디 이름',
                  hintText: '스터디 이름을 입력해주세요.',
                  errorText: '2 ~ 20자 사이의 이름을 설정해주세요.',
                  type: NewStudyType.studyName,
                  isValidation: validate.isStudyNameError!,
                  validationCheck: (value) => validate.validateStudyName(value),
                ),
                const SizedBox(height: 20),
                TextInputGroup(
                  title: '스터디 설명',
                  hintText: '스터디를 소개할 수 있는 설명을 추가해보세요.',
                  errorText: '10 ~ 65자 사이의 설명을 추가해주세요.',
                  maxLength: 65,
                  type: NewStudyType.studyDescription,
                  isValidation: validate.isStudyDescriptionError!,
                  validationCheck: (value) =>
                      validate.validateStudyDescription(value),
                ),
                const SizedBox(height: 20),
                const _CategorySelector(),
                const SizedBox(height: 40),
                const _StudyMemberCount(),
                const Spacer(),
                const _CreateButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '카테고리 선택',
                style: TextStyle(
                  color: Color(0xFF6E7986),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '최대 3개',
                style: TextStyle(
                  color: Color(0xFFABB6C2),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          BadgeMultiSelector(
            maxSelectedOptions: 3,
            options: [
              '어학',
              '자격증',
              '취업',
              '시험',
              '취미',
              '프로그래밍',
              '기타',
            ],
          ),
        ],
      ),
    );
  }
}

class _StudyMemberCount extends StatelessWidget {
  const _StudyMemberCount();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '스터디 인원',
                style: TextStyle(
                  color: Color(0xFF6E7986),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '최대 00명',
                style: TextStyle(
                  color: Color(0xFFABB6C2),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: const Color(0xFF1F3258),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => {},
        child: const Text(
          '생성하기',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
