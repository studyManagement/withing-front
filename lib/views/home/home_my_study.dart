import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';

class HomeMyStudy extends StatelessWidget {
  HomeMyStudy({super.key});

  final _valueList = ['가입한 순', '인기 순', '최신 순'];
  final _selectValue = '가입한 순';

  @override
  Widget build(BuildContext context) {
    List<StudyView> studies = context.select<StudyViewModel, List<StudyView>>(
        (provider) => provider.studyViewsInSelectedDay);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '내 스터디',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // DropdownMenuItem,
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectValue,
                    items: _valueList.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                studies.isNotEmpty
                    ? const MyStudyList()
                    : const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 120),
                            MyStudyListException(),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyStudyListException extends StatelessWidget {
  const MyStudyListException({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      constraints: const BoxConstraints(maxHeight: 72),
      child: Column(
        children: [
          Image.asset('asset/exclamation.png', width: 40, height: 40),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              '진행 중인 스터디가 없어요.',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class MyStudyList extends StatelessWidget {
  const MyStudyList({super.key});

  @override
  Widget build(BuildContext context) {
    String weekString = context
        .select<StudyViewModel, String>((provider) => provider.weekString);
    DateTime selectedDate = context
        .select<StudyViewModel, DateTime>((provider) => provider.selectedDate);
    List<StudyView> studies = context.select<StudyViewModel, List<StudyView>>(
        (provider) => provider.studyViewsInSelectedDay);

    return Expanded(
        child: ListView.separated(
      itemBuilder: (_, index) {
        final item = studies[index];

        return Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item.studyName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    '정기 모임',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '매주 ${weekString}요일 ${item.regularMeetings.first.startTime}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    '다음 만남',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${item.getNextDay(selectedDate)} (${item.getNextWeek(selectedDate)}) ${item.regularMeetings.first.startTime}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, index) => Divider(
        height: 10,
        color: Colors.grey[100],
        thickness: 2,
        indent: 20,
        endIndent: 20,
      ),
      itemCount: studies.length,
    ));
  }
}
