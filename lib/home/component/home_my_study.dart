import 'package:flutter/material.dart';
import 'package:withing/common/dio.dart';

class HomeMyStudy extends StatefulWidget {
  const HomeMyStudy({super.key});

  @override
  State<HomeMyStudy> createState() => _HomeMyStudyState();
}

class _HomeMyStudyState extends State<HomeMyStudy> {
  final _valueList = ['가입한 순', '인기 순', '최신 순'];
  var _selectValue = '가입한 순';

  @override
  Widget build(BuildContext context) {
    // 스터디 유무
    bool hasStudy = true;

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
                hasStudy
                    ? const MyStudyList()
                    : Column(
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
    );
  }
}

class MyStudyList extends StatelessWidget {
  const MyStudyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: getMyStudyList(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.separated(
            itemBuilder: (_, index) {
              final item = snapshot.data![index];

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
                          '${item['team_name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          '정기 모임',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '매주 목요일 21:00',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          '다음 만남',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '2023.08.03 (목) 21:00',
                          style: TextStyle(
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
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
