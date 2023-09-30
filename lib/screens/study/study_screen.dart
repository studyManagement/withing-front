import 'package:flutter/material.dart';

import '../../common/components/study_categories.dart';
import '../../common/layout/default_layout.dart';

class StudyScreen extends StatelessWidget {
  final int studyId;

  const StudyScreen({
    super.key,
    required this.studyId,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              '매주 목요일 저녁 9시, Zoom으로 진행.\n2회 무단 결석 시 퇴출입니다. 온/오프라인 병행입니다.',
              style: TextStyle(
                color: Color(0xFF3A4149),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFEBF1F5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16),
              Flexible(
                child: Container(
                  height: 100,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F7FC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Flexible(
                child: Container(
                  height: 100,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF4F7FC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '참여 인원',
                      style: TextStyle(
                        color: Color(0xFF8B97A4),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '30/30',
                      style: TextStyle(
                        color: Color(0xFF22262B),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '정기 모임',
                      style: TextStyle(
                        color: Color(0xFF8B97A4),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '매주 목요일 21:00',
                      style: TextStyle(
                        color: Color(0xFF22262B),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '다음 만남',
                      style: TextStyle(
                        color: Color(0xFF8B97A4),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '2023. 08. 03 (목) 21:00',
                      style: TextStyle(
                        color: Color(0xFF22262B),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            thickness: 6,
            color: Color(0xFFF4F7FC),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0E8F0),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '네이버 면접 스터디',
                style: TextStyle(
                  color: Color(0xFF22262B),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              StudyCategories(categories: ["취미", "프로그래밍"]),
            ],
          ),
        ],
      ),
    );
  }
}
