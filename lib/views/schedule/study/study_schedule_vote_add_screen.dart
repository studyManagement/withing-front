import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/input/text_input.dart';
import 'package:modi/common/components/selector/DateRangeSelector.dart';
import 'package:modi/common/components/selector/TimeRangeSelector.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';

LoggingInterface logger = getIt<LoggingInterface>();

class StudyScheduleVoteAddScreen extends StatelessWidget {
  const StudyScheduleVoteAddScreen(this._studyId, {super.key});

  final int _studyId;

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel vm = context.read<ScheduleVoteViewModel>();

    logger.info('StudyScheduleVoteAddScreen: _studyId: $_studyId');

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
          onTap: () {
            vm.postScheduleVote(_studyId);
          },
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
    ScheduleVoteViewModel vm = context.read<ScheduleVoteViewModel>();

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
          DateRangeSelector(
            onChange: (List<DateTime> selectedDates) =>
                vm.setSelectedDates(selectedDates),
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
            onChange: (DateTime startAt, DateTime endAt) {
              vm.setStartAt(startAt);
              vm.setEndAt(endAt);
            },
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
    ScheduleVoteViewModel vm = context.read<ScheduleVoteViewModel>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              '일정 이름',
              '일정 이름을 입력해 주세요.',
              20,
              (value) => vm.setTitle(value),
            ),
            const SizedBox(height: 8),
            const Text(
              '2-20자 사이의 이름을 설정해주세요.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.gray400,
              ),
            ),
            const SizedBox(height: 40),
            TextInput(
              '일정 설명',
              '일정 설명을 입력해 주세요.',
              65,
              (value) => vm.setDescription(value),
            ),
          ],
        ));
  }
}
