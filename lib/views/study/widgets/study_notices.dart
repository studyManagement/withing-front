import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:withing/view_models/study/study_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';

import '../../../model/study/notice_model.dart';
import 'notice_item.dart';

class Notice extends StatelessWidget {
  const Notice({super.key});

  @override
  Widget build(BuildContext context) {

    StudyViewModel vm = context.read<StudyViewModel>();
    List<NoticeModel> notices = vm.notices;
    bool hasNotice = vm.hasNotice;
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '공지',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("공지글 전체 보기 페이지로 이동");
                    },
                    child: Offstage(
                      offstage: (hasNotice) ? false : true,
                      child: Text(
                        '전체보기',
                        textAlign: TextAlign.right,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          color: AppColors.gray400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (hasNotice)
                ? _NoticeCarousel(notices)
                : Center(
              child: Column(children: [
                const SizedBox(height: 70),
                Image.asset(
                  'asset/exclamation.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 12.0),
                Text(
                  "등록된 공지가 없어요.",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.gray400),
                ),
              ]),
            ),
          ],
        )
    );
  }
}

class _NoticeCarousel extends StatefulWidget {
  const _NoticeCarousel(this.notices);
  final List<NoticeModel> notices;

  @override
  State<_NoticeCarousel> createState() => _NoticeCarouselState();
}

class _NoticeCarouselState extends State<_NoticeCarousel> {
  final CarouselController carouselController =
  CarouselController(); // 캐러셀 컨트롤러
  int currentIndex = 0; // 캐러셀 인디케이터 인덱스
  int numOfNotice = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            onPageChanged: ((index, reason){
              setState(() {
                currentIndex = index;
              });
            }),
            height: 224,
            viewportFraction: 1.0,
          ),
          itemCount: numOfNotice ~/ 3 + 1,
          itemBuilder: (context, index, realIndex) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return NoticeItem(
                    boardId: widget.notices[index].boardId,
                    title: widget.notices[index].title,
                    content: widget.notices[index].contents,
                    date: widget.notices[index].createdAt);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: AppColors.gray100,
                );
              },
              itemCount: (numOfNotice >= 3)
                  ? 3
                  : numOfNotice % 3, // 한 슬라이드에 공지글 최대 3개까지 표시.
            );
          },
        ),
        slideIndicator(currentIndex, numOfNotice),
      ],
    );
  }
}

Widget slideIndicator(int currentIndex, int numOfItem) {
  return SizedBox(
    width: 31,
    height: 5,
    child: Wrap(
      spacing: 8.0,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < numOfItem ~/ 3 + 1; i++)
          Container(
            width: 5.0,
            height: 5.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == i
                  ? AppColors.gray700
                  : AppColors.gray150, // 현재 인덱스일 경우 진하게 표시
            ),
          ),
      ],
    ),
  );
}
