import 'package:flutter/material.dart';
import 'package:modi/common/components/button/custom_radio_tile.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/components/gray50_divider.dart';
import 'package:modi/common/components/tab/common_tab_view.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import 'package:modi/views/study_manage/widgets/qna_list.dart';
import 'package:modi/views/study_manage/widgets/question_form_list.dart';
import 'package:provider/provider.dart';
import '../../../view_models/study/add_member_viewmodel.dart';

enum JoinType {
  free,
  approve,
}

class AddMemberScreen extends StatelessWidget {
  final int studyId;

  const AddMemberScreen({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddMemberViewModel>();

    return DefaultLayout(
      title: "스터디 가입 신청",
      child: SingleChildScrollView(
        child: Column(
          children: [
            // 가입 방식 선택
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "가입 방식",
                    style: TextTheme.of(context)
                        .bodyMedium
                        ?.copyWith(color: AppColors.gray500),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomRadioTile(
                        value: JoinType.free,
                        groupValue: viewModel.joinType,
                        onChanged: (value) {
                          if (value != null) viewModel.joinType = value;
                        },
                        title: "자유 가입",
                      ),
                      const SizedBox(width: 20),
                      CustomRadioTile(
                        value: JoinType.approve,
                        groupValue: viewModel.joinType,
                        onChanged: (value) {
                          if (value != null) viewModel.joinType = value;
                        },
                        title: "운영진 승인 가입",
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 구분선
            const Gray50Divider(dividerHeight: 6.0),
            const SizedBox(height: 20),
            // 본문 컨텐츠
           viewModel.joinType == JoinType.free
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: ModiException(
                          ["자유 가입은 별도의\n가입 신청 절차가 없어요."],
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: double.maxFinite,
                      child: CommonTabView(
                        tabTitles: ["  승인 대기자  ", "   가입 질문   "],
                        tabViews: [
                          QnaList(), // ← 실제 승인 리스트 위젯 교체 예정
                          QuestionFormList(),
                        ],
                        indicatorSize: TabBarIndicatorSize.label,
                      ),
                    ),

          ],
        ),
      ),
    );
  }
}
