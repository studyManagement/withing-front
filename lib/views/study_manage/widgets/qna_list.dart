import 'package:flutter/material.dart';
import 'package:modi/common/components/gray_container.dart';
import 'package:provider/provider.dart';

import '../../../common/components/image/circle_image.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../view_models/study/add_member_viewmodel.dart';

class QnaList extends StatelessWidget {
  const QnaList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AddMemberViewModel>();
    return Column(children: [
      ...List.generate(
        viewModel.questions.length,
        (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 16), child: _QnaItem()),
      ),
    ]);
  }
}

class _QnaItem extends StatelessWidget {
  const _QnaItem();

  @override
  Widget build(BuildContext context) {
    const imageUrl = '';
    final List<Map<String, String>> items = [
      {
        'question': '질문 1',
        'answer': '답변 1',
      },
      {
        'question': '질문 1',
        'answer': '답변 1',
      },
      {
        'question': '질문 1',
        'answer': '답변 1',
      }
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleImage(
                  size: 38,
                  image: (imageUrl != null)
                      ? Image.network(
                          imageUrl,
                          width: 38,
                          height: 38,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const GrayContainer(size: 38);
                          },
                        )
                      : null),
              const SizedBox(width: 12),
              Text('이름', style: TextTheme.of(context).titleSmall),
              const Spacer(),
              OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(50, 30),
                    padding: EdgeInsets.zero,
                    side: const BorderSide(color: AppColors.blue400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    "수락",
                    style: TextTheme.of(context)
                        .bodySmall
                        ?.copyWith(color: AppColors.blue500),
                  )),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  fixedSize: const Size(50, 30),
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: AppColors.red400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  "거절",
                  style: TextTheme.of(context)
                      .bodySmall
                      ?.copyWith(color: AppColors.red500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              // 내부 높이만큼만 사용
              physics: const NeverScrollableScrollPhysics(),
              // 스크롤 비활성화 (부모 스크롤 사용)
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("질문 1",
                            style: TextTheme.of(context)
                                .bodySmall
                                ?.copyWith(color: AppColors.blue500)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item['question']!,
                              style: TextTheme.of(context)
                                  .bodySmall
                                  ?.copyWith(color: AppColors.gray600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text("답변 1",
                            style: TextTheme.of(context)
                                .bodySmall
                                ?.copyWith(color: AppColors.blue500)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(item['answer']!,
                              style: TextTheme.of(context)
                                  .bodySmall
                                  ?.copyWith(color: AppColors.gray600)),
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: AppColors.gray150),
              ),
            ),
          )
        ],
      ),
    );
  }
}
