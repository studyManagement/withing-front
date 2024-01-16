import 'package:flutter/cupertino.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/model/study/study_info_model.dart';
import '../../service/study/study_service.dart';

class StudyInfoViewModel with ChangeNotifier {
  StudyInfo? studyInfo; // 각 데이터 모델 저장
  StudyService studyService = StudyService(StudyApi(RequestBuilder.getInstance()));

  int studyId;

  StudyInfoViewModel(this.studyId);

  /// study main api
  Future<void> studyInfoApi(BuildContext context) async {

    try {
      studyInfo = await studyService.callStudyInfoApi(studyId);
      if(studyInfo == null) print("해당하는 스터디 정보가 없습니다");
    }on ApiException catch (e) {
      rethrow;
    }



    // if (studyInfoModel!.data != null) {
    //   if (studyInfoModel!.data!.leaderId == userId) {
    //     isLeader = true;
    //   } else {
    //     isLeader = false;
    //   }
    // }
    notifyListeners();

  }


  // Future<void> studyCategoryApi(BuildContext context) async {
  //   studyCategory = await studyService.callStudyCategoryApi(studyId);
  //   notifyListeners();
  // }
  //
  // Future<void> studyRegularMeetingApi(BuildContext context) async {
  //   studyRegularMeeting = await studyService.callStudyRegularMeetingApi(studyId);
  //   notifyListeners();
  // }


}
