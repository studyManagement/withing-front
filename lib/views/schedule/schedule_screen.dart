import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

import '../../common/layout/default_layout.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '알림',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.gray150,
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '네이버 면접 스터디',
                            style: TextStyle(
                              color: AppColors.blue500,
                              fontWeight: AppFonts.fontWeight600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '방금',
                            style: TextStyle(
                              color: AppColors.red400,
                              fontWeight: AppFonts.fontWeight600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '실무 면접 및 대면 피드백',
                        style: TextStyle(
                          color: AppColors.gray800,
                          fontWeight: AppFonts.fontWeight500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '일정이 변경되었어요.',
                        style: TextStyle(
                          color: AppColors.gray400,
                          fontWeight: AppFonts.fontWeight500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 1,
                  color: AppColors.gray50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
