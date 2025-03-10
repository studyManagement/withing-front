import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authenticator.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/components/gray100_divider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/board/board_model.dart';
import '../../board/widgets/board_item.dart';

class Notice extends StatelessWidget {
  final int studyId;
  final bool isMember;
  final bool isPrivate;

  const Notice(
      {super.key,
      required this.studyId,
      required this.isMember,
      required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    BoardViewModel boardViewModel = context.watch<BoardViewModel>();
    boardViewModel.setStudyId = studyId;
    if (isMember || !isPrivate) {
      boardViewModel.fetchNotices();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Text(
                '공지',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.push('/studies/$studyId/notice/$isMember');
                },
                child: Offstage(
                  offstage: (boardViewModel.hasPost) ? false : true,
                  child: Text(
                    '전체보기',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.gray400,
                          fontSize: 13.0,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        (!isMember && isPrivate)
            ? const StudyNoticeException(isPrivate: true)
            : (boardViewModel.hasPost)
                ? _NoticeCarousel(
                    viewModel: boardViewModel,
                    studyId: studyId,
                  )
                : const StudyNoticeException(isPrivate: false)
      ],
    );
  }
}

class _NoticeCarousel extends StatefulWidget {
  final int studyId;
  final BoardViewModel viewModel;

  const _NoticeCarousel({required this.studyId, required this.viewModel});

  @override
  State<_NoticeCarousel> createState() => _NoticeCarouselState();
}

class _NoticeCarouselState extends State<_NoticeCarousel> {
  final CarouselController carouselController =
      CarouselController(); // 캐러셀 컨트롤러
  int currentIndex = 0; // 캐러셀 인디케이터 인덱스

  @override
  Widget build(BuildContext context) {
    int numOfNotice = widget.viewModel.notices.length;
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            onPageChanged: ((index, reason) {
              widget.viewModel.fetchNotices();
              setState(() {
                currentIndex = index;
              });
            }),
            height: 270,
            viewportFraction: 1.0,
          ),
          itemCount: (numOfNotice / 3).ceil(),
          itemBuilder: (context, index, realIndex) {
            final int startIndex = index * 3;
            final int endIndex = (index + 1) * 3;
            final List<BoardModel> sublist = widget.viewModel.notices.sublist(
              startIndex,
              endIndex > numOfNotice ? numOfNotice : endIndex,
            );
            return _buildCarouselItem(widget.studyId, sublist);
          },
          // 한 슬라이드에 공지글 최대 3개까지 표시.
        ),
        if (numOfNotice > 3) slideIndicator(currentIndex, numOfNotice),
      ],
    );
  }
}

Widget _buildCarouselItem(int studyId, List<BoardModel> sublist) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return BoardItem(
        isOnlyNotice: true,
        boardItem: sublist[index],
      );
    },
    separatorBuilder: (context, index) {
      return const Gray100Divider();
    },
    itemCount: sublist.length,
  );
}

Widget slideIndicator(int currentIndex, int numOfItem) {
  int page = (numOfItem + 2) ~/ 3;
  return SizedBox(
    width: 31,
    height: 5,
    child: Wrap(
      spacing: 8.0,
      alignment: WrapAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < page; i++)
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

class StudyNoticeException extends StatelessWidget {
  final bool isPrivate;

  const StudyNoticeException({super.key, required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(height: 70),
        (isPrivate)
            ? Image.asset(
                'asset/lock_40.png',
                width: 40,
                height: 40,
              )
            : Image.asset(
                'asset/exclamation.png',
                width: 40,
                height: 40,
              ),
        const SizedBox(height: 12.0),
        (isPrivate)
            ? Text(
                "비공개 스터디는\n멤버만 열람이 가능해요.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400),
              )
            : Text(
                "등록된 공지가 없어요.",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400),
              ),
      ]),
    );
  }
}
