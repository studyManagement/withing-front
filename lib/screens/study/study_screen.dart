import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import '../../common/components/study_details.dart';
import '../../common/components/study_categories.dart';
import '../../common/components/study_notices.dart';



class StudyScreen extends StatelessWidget {
  final int studyId;

  const StudyScreen({
    super.key,
    required this.studyId,
  });

  @override
  Widget build(BuildContext context) {
    bool hasNotice = true; // 공지글 존재 여부 (임시)
    bool isLeader = true; // 관리자 여부 (임시)

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Image.asset(
            'asset/arrowback.png',
            width: 32,
            height: 32,
          ),
          onPressed: () => {
            context.pop()
          },
        ),
        centerTitle: true,
        foregroundColor: AppColors.black,
        elevation: 0,
        actions: <Widget>[
          Offstage(
            offstage: (isLeader == true) ? false : true,
            child: IconButton(
              icon: Image.asset(
                'asset/setting.png',
                width: 32,
                height: 32,
              ),
              onPressed: () => {
               context.push('/studies/:studyId/manage')
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Header(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '매주 목요일 저녁 9시, Zoom으로 진행.\n2회 무단 결석 시 퇴출입니다. 온/오프라인 병행입니다.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: AppColors.gray100,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 16),
              Flexible(
                child: GestureDetector(
                  onTap: (){
                    print("일정 페이지로 이동");
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: ShapeDecoration(
                          color: AppColors.gray50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                       Positioned(
                          left: 14,
                          top: 14,
                          child: Text("일정",
                            style: Theme.of(context).textTheme.titleMedium,))
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Flexible(
                child: GestureDetector(
                  onTap: (){
                    print("게시판 페이지로 이동");
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100,
                        decoration: ShapeDecoration(
                          color: AppColors.gray50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                       Positioned(
                        left: 14,
                        top: 14,
                        child: Text(
                          "게시판",
                         style: Theme.of(context).textTheme.titleMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: StudyDetails(),
          ),
          const SizedBox(height: 20),
          const Divider(
            thickness: 6,
            color: AppColors.gray100,
          ),
          const SizedBox(height: 10),
          Notice(hasNotice: hasNotice),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray150,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '네이버 면접 스터디',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const StudyCategories(categories: ["취업", "프로그래밍"]),
            ],
          ),
        ],
      ),
    );
  }
}

