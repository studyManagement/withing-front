import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

import '../../common/layout/default_layout.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '알림',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return NotificationItem(
                  "테스트", "테스트", "테스트", "/my/profile", DateTime.now());
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 1,
                  color: AppColors.gray50,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  String channel;
  String title;
  String content;
  String link;
  DateTime createdAt;

  String getRelativeDate(DateTime dateTime) {
    return "방금 전";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => context.push(link),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.gray150,
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      channel,
                      style: const TextStyle(
                        color: AppColors.blue500,
                        fontWeight: AppFonts.fontWeight600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      getRelativeDate(createdAt),
                      style: const TextStyle(
                        color: AppColors.red400,
                        fontWeight: AppFonts.fontWeight600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  content,
                  style: const TextStyle(
                    color: AppColors.gray400,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  NotificationItem(
      this.channel, this.title, this.content, this.link, this.createdAt,
      {super.key});
}
