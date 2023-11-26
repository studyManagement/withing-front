import 'package:flutter/material.dart';
import 'package:withing/common/components/badge_multi_selector.dart';
import 'package:withing/common/layout/default_layout.dart';

class NewStudyScreen extends StatelessWidget {
  const NewStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xFFEBF1F5),
                shape: OvalBorder(),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const TextInputGroup(
            title: '스터디 이름',
            placeholder: '스터디 이름을 입력해주세요.',
            validationDescription: '2-20자 사이의 이름을 설정해주세요.',
          ),
          const SizedBox(height: 20),
          const TextInputGroup(
            title: '스터디 설명',
            placeholder: '스터디를 소개할 수 있는 설명을 추가해보세요.',
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
  }
}

class TextInputGroup extends StatelessWidget {
  final String title;
  final String placeholder;
  final String? validationDescription;

  const TextInputGroup({
    super.key,
    required this.title,
    required this.placeholder,
    this.validationDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6E7986),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                color: Color(0xFFCED7E1),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E8F0)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // if (validationDescription != null)
          // const Row(
          //   children: [
          //     Expanded(
          //       child: SizedBox(
          //         child: Text(
          //           '멋진 스터디 이름이네요!',
          //           style: TextStyle(
          //             color: Color(0xFF4182FF),
          //             fontSize: 12,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 10),
          //     Text(
          //       '10/20',
          //       textAlign: TextAlign.right,
          //       style: TextStyle(
          //         color: Color(0xFF6E7986),
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // ),
        ],
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
