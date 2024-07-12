import 'package:flutter/material.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/utils/get_created_string.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/gray_container.dart';
import '../../../common/theme/app/app_colors.dart';

class BoardHeader extends StatelessWidget {
  const BoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = context.watch<BoardViewModel>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleImage(
                  size: 22,
                  image: (vm.post!.user.profileImage == null)
                      ? null
                      : Image.network(
                          vm.post!.user.profileImage!,
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const GrayContainer(size: 38);
                          },
                        )),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if(vm.post!.notice)
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Image.asset('asset/notice_pin.png',
                            width: 16, height: 16),
                      ),
                      Text(
                        vm.post!.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        vm.post!.user.nickname,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.gray400, fontSize: 13.0),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '|',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.gray150, fontSize: 13.0),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        getCreatedAt(vm.post!.createdAt.toString()),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.gray400, fontSize: 13.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(vm.post!.content, style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}
