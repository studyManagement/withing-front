import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/button/value_button.dart';
import 'package:modi/common/components/calendar/calendar.dart';
import 'package:modi/common/components/input/text_input.dart';
import 'package:modi/common/components/selector/TimeRangeSelector.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/di/injection.dart';

import '../../../common/theme/app/app_colors.dart';

LoggingInterface logger = getIt<LoggingInterface>();

class StudyScheduleVoteAddScreen extends StatelessWidget {
  const StudyScheduleVoteAddScreen(this._studyId, {super.key});

  final int _studyId;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      resizeToAvoidBottomInset: false,
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () => context.pop(),
      ),
      title: '일정 투표 생성',
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ConfirmButton(
          width: MediaQuery.of(context).size.width,
          onTap: () => context.pop(),
          text: '생성하기',
          backgroundColor: AppColors.blue600,
        ),
      ),
      child: const Column(
        children: [
          StudyScheduleRegisterInformation(),
          SizedBox(height: 24),
          Divider(
            thickness: 6,
            color: AppColors.gray50,
          ),
          SizedBox(height: 24),
          StudyScheduleRegisterDateTime(),
        ],
      ),
    );
  }
}

class StudyScheduleRegisterDateTime extends StatelessWidget {
  const StudyScheduleRegisterDateTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                '투표를 받고 싶은 날짜',
                style: TextStyle(
                  color: AppColors.gray500,
                  fontWeight: AppFonts.fontWeight600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '최대 7일',
                style: TextStyle(
                  color: AppColors.gray300,
                  fontWeight: AppFonts.fontWeight500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              Widget? deleteButton = index != 0
                  ? GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.red400,
                        ),
                        child: Image.asset('asset/delete.png'),
                      ),
                    )
                  : null;

              return Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gray100,
                    ),
                    child: Center(
                      child: Text(
                        '$index',
                        style: const TextStyle(
                          color: AppColors.gray400,
                          fontSize: 12,
                          fontWeight: AppFonts.fontWeight500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: ValueButton(
                        '2023. 09. 02 (토) 오전 9:00',
                        rightWidget: deleteButton,
                      ),
                      onTap: () {
                        ModiModal.openBottomSheet(
                          context,
                          widget: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).size.height - 524,
                                child: ConfirmButton(
                                  onTap: () {},
                                  text: '선택 완료',
                                  backgroundColor: AppColors.blue600,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width - 32,
                                ),
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 40,
                                        left: 16,
                                        right: 16,
                                        bottom: 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          '날짜 선택',
                                          style: TextStyle(
                                            color: AppColors.gray800,
                                            fontWeight: AppFonts.fontWeight600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '일정 투표를 받고 싶은 날짜를 선택해주세요. (최대 7일)',
                                          style: TextStyle(
                                            color: AppColors.gray400,
                                            fontSize: 14,
                                            fontWeight: AppFonts.fontWeight500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: AppColors.gray150,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        Calendar(
                                          onDaySelected: (DateTime? rangeStart,
                                              DateTime? rangeEnd) {
                                            logger.info(
                                                '[onDaySelected] rangeStart: $rangeStart, rangeEnd: $rangeEnd');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height: 554,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            itemCount: 2,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8);
            },
          ),
          const SizedBox(height: 40),
          const Text(
            '투표를 받고 싶은 시간대',
            style: TextStyle(
              color: AppColors.gray500,
              fontWeight: AppFonts.fontWeight600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          TimeRangeSelector(
            startAt: DateTime.now(),
            endAt: DateTime.now(),
            onChange: (DateTime startAt, DateTime endAt) {},
          ),
        ],
      ),
    );
  }
}

class StudyScheduleRegisterInformation extends StatelessWidget {
  const StudyScheduleRegisterInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput('일정 이름', '일정 이름을 입력해 주세요.', 20, (value) => {}),
            const SizedBox(height: 8),
            const Text(
              '2-20자 사이의 이름을 설정해주세요.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 40),
            TextInput('일정 설명', '일정 설명을 입력해 주세요.', 65, (value) => {}),
          ],
        ));
  }
}
