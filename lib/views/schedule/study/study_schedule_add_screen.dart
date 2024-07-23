import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/input/text_input.dart';
import 'package:modi/common/components/selector/DateTimeRangeSelector.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';

LoggingInterface logger = getIt<LoggingInterface>();

class StudyScheduleAddScreen extends StatelessWidget {
  const StudyScheduleAddScreen(this._studyId, this._studyScheduleId,
      {super.key});

  final int _studyId;
  final int? _studyScheduleId;

  bool get isCreate => _studyScheduleId == null;

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel vm = context.watch<ScheduleViewModel>();

    // logger.info(
    //     'StudyScheduleAddScreen: _studyId: $_studyId, _studyScheduleId: $_studyScheduleId');

    if (!isCreate && vm.schedule.id == -1) {
      vm.fetchSchedule(_studyId, _studyScheduleId!);
    } else{
      vm.initialize();
    }

    return DefaultLayout(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (vm.isLoading)
          ? null
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ConfirmButton(
                width: MediaQuery.of(context).size.width,
                onTap: () {
                  if (isCreate) {
                    vm.postSchedule(context, _studyId);
                  } else {
                    vm.putSchedule(context, _studyId, _studyScheduleId!);
                  }
                },
                text: (isCreate) ? '생성하기' : '수정하기',
                backgroundColor: AppColors.blue600,
              ),
            ),
      leader: CircleButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onTap: () => context.pop()),
      title: '일정 ${(isCreate) ? '생성' : '수정'}',
      child: (vm.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const StudyScheduleRegisterInformation(),
                const SizedBox(height: 24),
                const Divider(
                  thickness: 6,
                  color: AppColors.gray50,
                ),
                const SizedBox(height: 24),
                DateTimeRangeSelector(
                  startAt: vm.schedule.startAt,
                  endAt: vm.schedule.endAt,
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
    ScheduleViewModel vm = context.read<ScheduleViewModel>();
    print(vm.schedule);
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
              initialValue: vm.schedule.title,
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
              initialValue: vm.schedule.description,
            ),
          ],
        ));
  }
}
