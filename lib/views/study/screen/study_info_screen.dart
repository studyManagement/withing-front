import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/layout/responsive_size.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study/screen/study_manage_screen.dart';
import 'package:modi/views/study/widgets/input_password_modal.dart';
import 'package:modi/views/study/widgets/study_main_buttons.dart';
import 'package:provider/provider.dart';

import '../../../common/authenticator/authentication.dart';
import '../../../common/components/share/share.dart';
import '../../../di/injection.dart';
import '../widgets/study_details.dart';
import '../widgets/study_header.dart';
import '../widgets/study_notices.dart';

class StudyInfoScreen extends StatelessWidget {
  final int studyId;

  const StudyInfoScreen({
    super.key,
    required this.studyId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTabletPrt = screenWidth >= tabletPortrait;
    StudyViewModel vm = context.watch<StudyViewModel>();
    bool offstage = vm.isMember;
    vm.userId = Authentication.instance.userId;
    vm.fetchStudyInfo(studyId).then((_) {
      vm.getRegularMeetingString();
      vm.checkRegistered();
    });
    return DefaultLayout(
      leader: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => {
          if (studyId == -1) {context.go('/')} else {context.pop()}
        },
      ),
      actions: [
        makeShareButton(context, vm.study?.studyName ?? ''),
        makeLikeButton(context)
      ],
      centerTitle: true,
      title: '',
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Offstage(
        offstage: offstage,
        child: StudyBottomButton(
            onTap: () {
                (vm.study!.private)
                    ? showDialog(
                        context: context,
                        builder: (_) {
                          vm.initPasswordProperties();
                          return ChangeNotifierProvider.value(
                              value: vm,
                              child: InputPasswordModal(studyId: studyId));
                        })
                    : joinToPublicStudy(vm, context);
            },
            text: '가입하기'),
      ),
      child: (vm.study == null)
          ? Container()
          : SingleChildScrollView(
              child: SizedBox(
                height: (isTabletPrt) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Header(),
                    const SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          vm.study!.explanation,
                          style: Theme.of(context).textTheme.bodySmall,
                        )),
                    const SizedBox(height: 20),
                    const Divider(
                      thickness: 1,
                      indent: 16,
                      endIndent: 16,
                      color: AppColors.gray100,
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: StudyDetails(),
                    ),
                    if (offstage) const SizedBox(height: 20),
                    if (offstage)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StudyMainButtons(
                              onTap: () {
                                context.push('/studies/$studyId/schedules');
                              },
                              title: "Schedule",
                              subtitle: "일정",
                              width: screenWidth * 0.4,
                              image: Image.asset('asset/schedule.png'),
                            ),
                            SizedBox(width: screenWidth * 0.024),
                            StudyMainButtons(
                                onTap: () {
                                  context.push('/studies/$studyId/boards');
                                },
                                title: "Community",
                                subtitle: "게시판",
                                width: screenWidth * 0.4,
                                image: Image.asset('asset/community.png')),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 6,
                      color: AppColors.gray100,
                    ),
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                        create: (_) => BoardViewModel(context, getIt<BoardService>()),
                        child: Notice(
                            studyId: studyId,
                            isMember: vm.isMember,
                            isPrivate: vm.study!.private)),
                  ],
                ),
              ),
            ),
    );
  }

  Widget makeShareButton(BuildContext context, String studyName) {
    return IconButton(
      onPressed: () {
        ModiModal.openBottomSheet(
          context,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Share(
              title: '[$studyName] 초대가 왔어요!',
              message: '가입 후 스터디를 시작해보세요',
              path: '/studies/$studyId',
              contentType: 'study',
              itemId: '$studyId',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          height: 221,
        );
      },
      icon: Image.asset('asset/share.png'),
    );
  }

  Widget makeLikeButton(BuildContext context) {
    final viewModel = context.watch<StudyViewModel>();
    bool isLeader =
        (viewModel.study?.leaderId == Authentication.instance.userId);
    return (viewModel.isMember)
        ? Offstage(
            offstage: (isLeader) ? false : true,
            child: IconButton(
              icon: Image.asset(
                'asset/setting.png',
                width: 32,
                height: 32,
              ),
              onPressed: (isLeader)
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudyManageScreen(viewModel: viewModel)));
                    }
                  : null,
            ),
          )
        : IconButton(
            icon: (viewModel.hasLike)
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
            onPressed: () {
              (viewModel.hasLike)
                  ? viewModel.cancelFavoriteStudy()
                  : viewModel.pickFavoriteStudy();
            },
          );
  }

  void joinToPublicStudy(StudyViewModel vm, BuildContext context) {
    vm.joinStudy(null).then((_) => {
          if (vm.successToJoin)
            {context.go('/studies/$studyId')}
        });
  }
}
