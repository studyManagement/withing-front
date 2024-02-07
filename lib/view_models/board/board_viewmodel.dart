import 'package:flutter/material.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import '../../common/requester/api_exception.dart';
import '../../model/board/board_model.dart';
import '../../model/board/post_exception.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;

  BoardViewModel(this._service);

  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];
  List<CommentModel> comments = [];
  BoardModel? _post;
  BoardModel? get post => _post;
   
  Future<void> fetchNotices(int studyId) async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoardList(studyId, true);
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
  

  Future<void> fetchBoardList(int studyId) async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoardList(studyId, true);
        List<BoardModel> _posts = await _service.fetchBoardList(studyId, false);
        posts.addAll(_posts);
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

  Future<void> fetchBoardInfo(int studyId, int boardId) async {
    if (_post == null) {
      try {
        _post = await _service.fetchBoardInfo(studyId, boardId);
        notifyListeners();
      } on NoPostException catch (e) {
        throw const NoPost();
      }
    }
  }

  Future<void> deletePost(int studyId, int boardId) async {
    await _service.deletePost(studyId, boardId);
    notifyListeners();
  }

  Future<void> createPost(int studyId) async {
    await _service.createPost(studyId);
    notifyListeners();
  }

  Future<void> updatePost(int studyId, int boardId, Post newPost) async {
    await _service.updatePost(studyId, boardId, newPost);
    notifyListeners();
  }

  Future<void> fetchComments(int studyId, int boardId) async {
    comments = await _service.fetchComments(studyId, boardId);
    if(comments.isNotEmpty) notifyListeners();
  }
}
