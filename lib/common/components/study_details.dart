import 'package:flutter/material.dart';
import '../theme/app/app_colors.dart';

class StudyDetails extends StatelessWidget{
  const StudyDetails({super.key});

  @override
  Widget build(BuildContext context) {
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
              '30/30',
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
                print("참여 인원 아이콘 클릭")
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
              '매주 목요일 21:00',
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

