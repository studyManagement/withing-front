import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../view_models/study/study_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';
import '../screen/study_member_screen.dart';

class StudyDetails extends StatelessWidget {
  const StudyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final StudyViewModel vm = context.read<StudyViewModel>();
    return Column(
      children: [
        Row(
          children: [
            Text(
              '참여 인원',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray400,
                    fontSize: 13.0,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              '${vm.study.headcount}/${vm.study.max}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray800,
                    fontSize: 13.0,
                  ),
            ),
            GestureDetector(
              child: Image.asset(
                'asset/arrowright16.png',
                width: 16,
                height: 16,
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyMemberScreen(users: vm.study.users,leaderId: vm.study.leaderId,),
                  ),
                )
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '정기 모임',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray400,
                    fontSize: 13.0,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              vm.regularMeeting, // 추가 수정 필요
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray800,
                    fontSize: 13.0,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
