import 'package:flutter/cupertino.dart';
import 'package:modi/views/study_manage/screen/add_member_screen.dart';
import '../../service/study/study_service.dart';

class Question {
  String content = '질문';
  String example = '지인추천';
}

class AddMemberViewModel extends ChangeNotifier {
  final StudyService _studyService;

  AddMemberViewModel(this._studyService);

  JoinType _joinType = JoinType.free;
  final List<Question> _questions = [
    Question(), // 초기 질문 1개
    Question(), // 초기 질문 1개
    Question(), // 초기 질문 1개
  ];


  JoinType get joinType => _joinType;
  List<Question> get questions => List.unmodifiable(_questions);


  set joinType(JoinType value) {
    _joinType = value;
    notifyListeners();
  }

  void addQuestion() {
    _questions.add(Question());
    notifyListeners();
  }

  void deleteQuestion(int index) {
    if (_questions.length > 1) {
      _questions.removeAt(index);
      notifyListeners();
    }
  }

  void updateQuestionContent(int index, String content) {
    _questions[index].content = content;
    notifyListeners();
  }

  void updateQuestionExample(int index, String example) {
    _questions[index].example = example;
    notifyListeners();
  }


}
