import 'package:flutter/cupertino.dart';
import 'package:withing/common/requester/api_response.dart';
import 'package:withing/common/requester/requester.dart';
import 'package:withing/models/study/study_model.dart';

enum StudyTypes {
  running('mystudy'),
  finished('finished');

  final String state;
  const StudyTypes(this.state);
}

class StudyService extends ChangeNotifier {
  Future<List<StudyModel>> fetchStudies(StudyTypes stateType) async {
    final queryParameters = {
      'key': stateType.state,
    };

    ApiResponse apiResponse =
        await Requester.get('/studies/users/1', queryParameters);

    final studies = apiResponse.data as List<Map<String, dynamic>>;
    return studies.map((e) => StudyModel.fromJson(e)).toList();
  }
}
