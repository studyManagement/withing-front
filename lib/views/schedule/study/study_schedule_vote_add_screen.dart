import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/button/value_button.dart';
import 'package:modi/common/components/calendar/calendar.dart';
import 'package:modi/common/components/input/text_input.dart';
import 'package:modi/common/components/spinner/datetime/time_spinner.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "일정 투표 생성",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
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
      body: const SafeArea(
        child: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ModiModal.openBottomSheet(
                      context,
                      widget: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Positioned(
                            top: MediaQuery.of(context).size.height - 380,
                            child: ConfirmButton(
                              onTap: () {},
                              text: '선택 완료',
                              backgroundColor: AppColors.blue600,
                              height: 50,
                              width: MediaQuery.of(context).size.width - 32,
                            ),
                          ),
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 40, left: 16, right: 16, bottom: 20),
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
                              Divider(
                                thickness: 1,
                                color: AppColors.gray150,
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    Calendar(),
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
                  child: const ValueButton('2023. 09. 02 (토) 오전 9:00'),
                ),
              ),
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    ModiModal.openBottomSheet(
                      context,
                      widget: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 40, left: 16, right: 16, bottom: 20),
                            child: Column(
                              children: [
                                Text(
                                  '기간 선택',
                                  style: TextStyle(
                                    color: AppColors.gray800,
                                    fontWeight: AppFonts.fontWeight600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '일정으로 등록할 기간을 선택해주세요.',
                                  style: TextStyle(
                                    color: AppColors.gray400,
                                    fontSize: 14,
                                    fontWeight: AppFonts.fontWeight500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: AppColors.gray50,
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ValueButton('09. 02 (토) 오전 9:00'),
                                SizedBox(width: 4),
                                Text(
                                  '-',
                                  style: TextStyle(color: AppColors.gray200),
                                ),
                                SizedBox(width: 4),
                                ValueButton('09. 02 (토) 오전 9:00'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: TimeSpinner(
                                    DateTime.now(),
                                    (DateTime) {
                                      logger.info(DateTime);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 40),
                                ConfirmButton(
                                  onTap: () {},
                                  text: '선택 완료',
                                  backgroundColor: AppColors.blue600,
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      height: 496,
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ValueButton('09. 02 (토) 오전 9:00'),
                      SizedBox(width: 4),
                      Text(
                        '-',
                        style: TextStyle(color: AppColors.gray200),
                      ),
                      SizedBox(width: 4),
                      ValueButton('09. 02 (토) 오전 9:00'),
                    ],
                  ),
                ),
              ),
            ],
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
