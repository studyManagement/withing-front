import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/button/label_circle_button.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/sns_content_share/sns_content_share_factory.dart';
import 'package:modi/common/theme/theme_resources.dart';

class StudyMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int studyId;
  final bool isLeader;
  final bool? hasLike;
  final Function()? action;

  const StudyMainAppBar(
      {super.key,
      required this.studyId,
      required this.isLeader,
      this.hasLike,
      this.action});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => {
          if (studyId == -1) {context.go('/')} else {context.pop()}
        },
      ),
      centerTitle: true,
      foregroundColor: AppColors.black,
      elevation: 0,
      actions: <Widget>[makeShareButton(context), makeLikeButton()],
    );
  }

  Widget makeShareButton(context) {
    return IconButton(
      onPressed: () {
        ModiModal.openBottomSheet(
            context,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  const Text(
                    '공유하기',
                    style: TextStyle(
                      color: AppColors.gray800,
                      fontSize: 16,
                      fontWeight: AppFonts.fontWeight600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      children: [
                        LabelCircleButton(
                          '복사',
                          Image.asset(
                            'asset/share/clipboard.png',
                            width: 50,
                            height: 50,
                          ),
                          () => SNSContentShareFactory.getProvider(
                                  SNSContentShareProviders.Clipboard)
                              .send('모디에서 스터디를 시작해 보세요.',
                                  '테스트 스터디\nhttps://modi.tips/s/DiLopA'),
                        ),
                        LabelCircleButton(
                          '카카오톡',
                          Image.asset(
                            'asset/share/kakao.png',
                            width: 50,
                            height: 50,
                          ),
                          () => SNSContentShareFactory.getProvider(
                                  SNSContentShareProviders.KAKAO)
                              .send('모디에서 스터디를 시작해 보세요.',
                                  '테스트 스터디\nhttps://modi.tips/s/DiLopA'),
                        ),
                        LabelCircleButton(
                          '인스타그램',
                          Image.asset(
                            'asset/share/instagram.png',
                            width: 50,
                            height: 50,
                          ),
                          () => SNSContentShareFactory.getProvider(
                                  SNSContentShareProviders.INSTAGRAM)
                              .send('모디에서 스터디를 시작해 보세요.',
                                  '테스트 스터디\nhttps://modi.tips/s/DiLopA'),
                        ),
                        LabelCircleButton(
                          '더보기',
                          Image.asset(
                            'asset/share/more.png',
                            width: 50,
                            height: 50,
                          ),
                          () => SNSContentShareFactory.getProvider(
                                  SNSContentShareProviders.OS)
                              .send('모디에서 스터디를 시작해 보세요.',
                                  '테스트 스터디\nhttps://modi.tips/s/DiLopA'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            221);
      },
      icon: Image.asset('asset/share.png'),
    );
  }

  Widget makeLikeButton() {
    return (hasLike == null)
        ? Offstage(
            offstage: (isLeader) ? false : true,
            child: IconButton(
              icon: Image.asset(
                'asset/setting.png',
                width: 32,
                height: 32,
              ),
              onPressed: action,
            ),
          )
        : IconButton(
            icon: (hasLike == true)
                ? Image.asset(
                    'asset/heart_filled_32.png',
                    width: 32,
                    height: 32,
                  )
                : Image.asset(
                    'asset/heart_lined_32.png',
                    width: 32,
                    height: 32,
                  ),
            onPressed: () => {
              // 찜
            },
          );
  }
}
