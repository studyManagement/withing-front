import 'package:flutter/material.dart';
import 'package:modi/service/board/board_service.dart';
import '../../common/requester/api_exception.dart';
import '../../model/board/board_model.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;
  BoardViewModel(this._service);

  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];



  Future<void> fetchBoards(int studyId, bool isNotice) async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoards(studyId, isNotice);
        if (posts.isNotEmpty) {
          hasPost = true;
          numOfPosts = posts.length;
          notifyListeners();
        }
      } on ApiException catch (e) {
        if (e.code == 404) {
          // 공지사항이 없는 경우 처리
          hasPost = false;
          numOfPosts = 0;
        }

        if (e.code == 400) {
          // 접근 권한 x
        }
      }
    }
  }

}