import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/model/study/study_info_model.dart';
import 'package:withing/service/study/study_service.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';
import 'package:withing/views/study/widgets/study_main_appbar.dart';
import 'package:withing/views/study/widgets/study_main_buttons.dart';
import '../../common/components/study_details.dart';
import '../../common/components/study_notices.dart';
import '../../di/injection.dart';
import 'widgets/study_header.dart';



class StudyScreen extends StatelessWidget {
  final int studyId;

  const StudyScreen({
    super.key,
    required this.studyId,
  });
  

  @override
  Widget build(BuildContext context) {
    bool hasNotice = true; // 공지글 존재 여부 (임시)
    int userId = 1 ;

    return ChangeNotifierProvider<StudyInfoViewModel>(
      create: (context) => StudyInfoViewModel(studyId),
      child: Scaffold(
            appBar: StudyMainAppBar(context),
            body: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Header(),
               const SizedBox(height: 16),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Consumer<StudyInfoViewModel>(
                   builder: (context,data,_) {
                     final ex;
                     data.studyInfoApi(context);
                     if(data.studyInfo?.studyName != null){
                       ex=data.studyInfo?.studyName;
                     }
                     else ex = '스터디 없음';
                     return Text(
                      ex,
                       //   '매주 목요일 저녁 9시, Zoom으로 진행.\n2회 무단 결석 시 퇴출입니다. 온/오프라인 병행입니다.',
                       style: Theme
                           .of(context)
                           .textTheme
                           .bodySmall,
                     );
                   }
                 ),
               ),
               const SizedBox(height: 20),
               const Divider(
                 thickness: 1,
                 indent: 16,
                 endIndent: 16,
                 color: AppColors.gray100,
               ),
               const SizedBox(height: 20),
               const Row(
                 children: [
                   SizedBox(width: 16),
                  StudyMainButtons(Path: "", title: "일정"),
                   SizedBox(width: 9),
                   StudyMainButtons(Path: "", title: "게시판"),
                   SizedBox(width: 16),
                 ],
               ),
               const SizedBox(height: 20),
               const Padding(
                 padding: EdgeInsets.symmetric(horizontal: 16),
                 child: StudyDetails(),
               ),
               const SizedBox(height: 20),
               const Divider(
                 thickness: 6,
                 color: AppColors.gray100,
               ),
               const SizedBox(height: 10),
               Notice(hasNotice: hasNotice),
             ],
                        ),






      ),
    );
  }
}

