import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/components/share/share.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/action_sheet_params.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/circle_button.dart';

class StudyScheduleVoteDetailScreen extends StatelessWidget {
  const StudyScheduleVoteDetailScreen(this.studyId, this.voteId, {super.key});

  final int studyId;
  final int voteId;

  Widget _makeShareButton(
      BuildContext context, String title, String message, String path) {
    return CircleButton(
      onTap: () {
        ModiModal.openBottomSheet(
          context,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Share(
              title: title,
              message: message,
              path: path,
              contentType: 'study_schedule_vote',
              itemId: '$voteId',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          height: 221,
        );
      },
      image: Image.asset('asset/share.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    StudyViewModel studyViewModel = context.read<StudyViewModel>();
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    String studyName = context.select<StudyViewModel, String>(
        (provider) => provider.study?.studyName ?? '');

    if (vote == null) {
      studyViewModel.fetchStudyInfo(studyId);
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
      title: '',
      actions: [
        _makeShareButton(
          context,
          '[$studyName] ${vote?.title}',
          '스터디 일정을 투표해 주세요',
          '/studies/$studyId/schedules/vote/$voteId',
        ),
        const SizedBox(width: 12),
        CircleButton(
          onTap: () {
            ModiModal.openActionSheet(
              context,
              [
                ActionSheetParams(title: '마감하기', onTap: () {}),
                ActionSheetParams(
                  title: '삭제하기',
                  onTap: () {},
                  titleColor: AppColors.red400,
                ),
              ],
            );
          },
          icon: const Icon(Icons.more_horiz),
        ),
      ],
      child: (vote == null)
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const StudyScheduleVoteDetailHeader(),
                  const Divider(color: AppColors.gray50, thickness: 6),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ScheduleTable(
                      dateTimes: vote.votes.map((e) => e.voteDay).toList(),
                      startAt: vote.votes.first.startAt,
                      endAt: vote.votes.first.endAt,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class StudyScheduleVoteDetailHeader extends StatelessWidget {
  const StudyScheduleVoteDetailHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    if (vote == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Tag('미참여', TagColorSet.BLUE),
              const SizedBox(width: 8),
              Text(
                vote.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: AppFonts.fontWeight600,
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            vote.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.gray150),
          const SizedBox(height: 16),
          const Text(
            '확정 일정',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '투표 인원',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '투표 생성',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class ScheduleTable extends StatelessWidget {
  const ScheduleTable({
    required this.dateTimes,
    required this.startAt,
    required this.endAt,
    super.key,
  });

  final List<DateTime> dateTimes;
  final TimeOfDay startAt;
  final TimeOfDay endAt;

  List<TimeOfDay> getTimeRangeWithoutMinutes(
      TimeOfDay startTime, TimeOfDay endTime) {
    List<TimeOfDay> timeRangeList = [];

    int startHour = startTime.hour;
    int endHour = endTime.hour;

    for (int hour = startHour; hour <= endHour; hour++) {
      timeRangeList.add(TimeOfDay(hour: hour, minute: 0));
    }

    return timeRangeList;
  }

  Row _makeProfile(String nickname, String? profileImage) {
    return Row(
      children: [
        CircleImage(
          22,
          22,
          image: Image.asset('asset/default_image.png'),
        ),
        const SizedBox(width: 6),
        Text(
          nickname,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekDayFormat = DateFormat('E', 'ko');
    final dateFormat = DateFormat('M/d', 'ko');

    dateTimes.sort((a, b) => a.compareTo(b));

    List<TableCell> headers = dateTimes
        .map(
          (dateTime) => TableCell(
            child: Column(
              children: [
                Text(
                  weekDayFormat.format(dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: AppFonts.fontWeight500,
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateFormat.format(dateTime),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: AppFonts.fontWeight500,
                    color: AppColors.gray800,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        )
        .toList();

    List<TableRow> rows = getTimeRangeWithoutMinutes(startAt, endAt)
        .map(
          (time) => TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.top,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  alignment: Alignment.topRight,
                  child: Text(
                    '${time.hour}:00',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: AppFonts.fontWeight500,
                      color: AppColors.gray500,
                    ),
                  ),
                ),
              ),
              ...dateTimes.map(
                (dateTime) => TableCell(
                  child: PopupMenuButton(
                    offset: const Offset(0, 50),
                    tooltip: '',
                    color: AppColors.white,
                    surfaceTintColor: AppColors.white,
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          enabled: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '3명 투표',
                                style: TextStyle(
                                  color: AppColors.blue400,
                                  fontSize: 12,
                                  fontWeight: AppFonts.fontWeight600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 100,
                                width: 120,
                                child: ListView.builder(
                                  itemExtent: 30,
                                  itemBuilder: (context, index) {
                                    return _makeProfile('김모모', null);
                                  },
                                  itemCount: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blue400,
                        border: Border.all(color: AppColors.gray50),
                      ),
                      child: (time.hour >= 6 && time.hour <= 18)
                          ? const Icon(
                              Icons.sunny,
                              size: 20,
                              color: AppColors.gray200,
                            )
                          : const Icon(
                              FontAwesomeIcons.solidMoon,
                              size: 20,
                              color: AppColors.gray200,
                            ),
                    ),
                  ),
                  /*
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray50),
                      ),
                      child: (time.hour >= 6 && time.hour <= 18)
                          ? const Icon(
                              Icons.sunny,
                              size: 20,
                              color: AppColors.gray200,
                            )
                          : const Icon(
                              FontAwesomeIcons.solidMoon,
                              size: 20,
                              color: AppColors.gray200,
                            ),
                    ),
                  ),
                  */
                ),
              ),
            ],
          ),
        )
        .toList();

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: FractionColumnWidth(.1)},
      children: [
        TableRow(
          children: [const TableCell(child: SizedBox()), ...headers],
        ),
        ...rows,
      ],
    );
  }
}
