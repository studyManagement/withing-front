import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study/screen/study_manage_screen.dart';
import 'package:modi/views/study/widgets/input_password_modal.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';
import 'package:modi/views/study/widgets/study_main_buttons.dart';
import 'package:provider/provider.dart';

import '../../../common/authenticator/authentication.dart';
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
    StudyViewModel vm = context.watch<StudyViewModel>();
     vm.userId = Authentication.instance.userId;
     vm.fetchStudyInfo(context, studyId).then((_) {
       vm.getRegularMeetingString();
       vm.checkRegistered();
     });

    bool offstage = vm.isMember;
    bool isLeader = (vm.study?.leaderId == Authentication.instance.userId);

    return Scaffold(
      appBar: (vm.study == null)
          ? StudyMainAppBar(studyId: studyId, isLeader: false)
          : StudyMainAppBar(
              studyId: studyId,
              isLeader: isLeader,
              action: (isLeader)
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudyManageScreen(viewModel: vm)));
                    }
                  : null,
            ),
      body: (vm.study == null)
          ? Container()
          : SafeArea(
              child: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 16),
                          StudyMainButtons(
                            onTap: () {
                              context.push('/studies/$studyId/schedules');
                            },
                            title: "Schedule",
                            subtitle: "일정",
                            image: Image.asset('asset/schedule.png'),
                          ),
                          const SizedBox(width: 9),
                          StudyMainButtons(
                              onTap: () {
                                context.push('/studies/$studyId/boards');
                              },
                              title: "Community",
                              subtitle: "게시판",
                              image: Image.asset('asset/community.png')),
                          const SizedBox(width: 16),
                        ],
                      ),
                    const SizedBox(height: 20),
                    const Divider(
                      thickness: 6,
                      color: AppColors.gray100,
                    ),
                    const SizedBox(height: 10),
                    ChangeNotifierProvider(
                        create: (_) => BoardViewModel(getIt<BoardService>()),
                        child: Notice(
                            studyId: studyId,
                            isMember: vm.isMember,
                            isPrivate: vm.study!.private)),
                    if (!offstage) const SizedBox(height: 190),
                    if (!offstage)
                      Center(
                          child: StudyBottomButton(
                              onTap: () {
                                (vm.study!.private)
                                    ? showDialog(
                                        context: context,
                                        builder: (_) => ChangeNotifierProvider(
                                            create: (_) => StudyViewModel(
                                                getIt<StudyService>()),
                                            child: InputPasswordModal(
                                                studyId: studyId)))
                                    : joinToPublicStudy(vm, context);
                              },
                              text: '가입하기')),
                  ],
                ),
              ),
            ),
    );
  }

  void joinToPublicStudy(StudyViewModel vm, BuildContext context) {
    vm.joinStudy(studyId, null);
    if (vm.successToJoin) {
      print('가입 성공');
      context.go('/studies/$studyId');
    } else {
      ModiModal.openDialog(
          context, '스터디 가입 실패', '', false, () => null, () => null);
    }
  }
}
