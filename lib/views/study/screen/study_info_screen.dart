import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/study_bottom_button.dart';
import 'package:modi/common/modal/withing_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/view_models/study/model/study_view.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/views/study/widgets/input_password_modal.dart';
import 'package:modi/views/study/widgets/study_main_appbar.dart';
import 'package:modi/views/study/widgets/study_main_buttons.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../widgets/study_details.dart';
import '../widgets/study_notices.dart';
import '../widgets/study_header.dart';

class StudyInfoScreen extends StatelessWidget {
  final int studyId;

  const StudyInfoScreen({
    super.key,
    required this.studyId,
  });

  @override
  Widget build(BuildContext context) {
    StudyViewModel vm = context.watch<StudyViewModel>();
    vm.fetchStudyInfo(context, studyId);
    if (vm.study != null && vm.study!.private) {
      vm.checkRegistered(vm.users, 28); // 임시값
      //  vm.checkRegistered(vm.users, Authentication.instance.userId);
    }
    bool offstage = vm.isMember;

    return Scaffold(
      appBar: (vm.study == null)
          ? StudyMainAppBar(studyId: studyId, leaderId: -1)
          : StudyMainAppBar(
              studyId: studyId,
              leaderId: vm.study!.leaderId,
              hasLike: (vm.isMember) ? null : false),
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
                            onTap: () {},
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
                        child: Notice(studyId: studyId, isMember: vm.isMember)),
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
      WithingModal.openDialog(
          context, '스터디 가입 실패', '', false, () => null, () => null);
    }
  }
}
