import 'package:flutter/material.dart';

import '../common/layout/default_layout.dart';
import '../component/main_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _valueList = ['가입한 순', '인기 순', '최신 순'];
  var _selectValue = '가입한 순';

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    // 스터디 유무
    bool hasStudy = true;

    return DefaultLayout(
      title: '이번주 일정',
      child: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              onDaySelected: onDaySelected,
              selectedDate: selectedDate,
            ),
            // 만약 스터디가 있으면
            if (hasStudy)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey[100],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('11:00'),
                            SizedBox(width: 8),
                            VerticalDivider(thickness: 1, width: 10, indent: 20, endIndent: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '최강 마지막 네이버 면접 스터디 파이팅 테스트 테스트',
                                    style: TextStyle(color: Colors.blue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text('실무 면접 및 대면 피드백'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey[100],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('15:00'),
                            SizedBox(width: 8),
                            VerticalDivider(thickness: 1, width: 10, indent: 20, endIndent: 20, color: Colors.grey),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '스터디 관리 사이드 프로젝트',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                SizedBox(height: 2),
                                Text('5차 정기 회의(07:30'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (!hasStudy)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: const Center(
                    child: Text(
                      '해당 날짜에는\n등록된 일정이 없어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Divider(
              thickness: 5,
              height: 1,
              color: Colors.grey[200],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '내 스터디',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
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
                      onChanged: (val) {
                        setState(() {
                          _selectValue = val!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 만약 스터디가 있으면
                  if (hasStudy) Container(),
                  // 스터디 없으면
                  if (!hasStudy)
                    Column(
                      children: [
                        const SizedBox(height: 70),
                        Image.asset('asset/exclamation.png', width: 40, height: 40),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            '진행 중인 스터디가 없어요.',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
