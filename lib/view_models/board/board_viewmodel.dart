import 'package:flutter/material.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import '../../common/requester/api_exception.dart';
import '../../model/board/board_model.dart';
import '../../model/board/post_exception.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;

  BoardViewModel(this._service);

  int? _studyId;
  bool _isValid = false;
  bool _isDeleted = false;
  bool hasPost = false;
  int numOfPosts = 0;
  List<BoardModel> posts = [];
  List<CommentModel> comments = [];
  BoardModel? _post;

  BoardModel? get post => _post;

  bool get isValid => _isValid;
  bool get isDeleted => _isDeleted;
  String _title = '';
  String _contents = '';
  String _comment = '';

  String get title => _title;

  String get contents => _contents;

  String get comment => _comment;

  int? get studyId => _studyId;

  Future<void> fetchNotices() async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoardList(_studyId!, true);
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

  Future<void> fetchBoardList() async {
    if (posts.isEmpty) {
      try {
        posts = await _service.fetchBoardList(_studyId!, true);
        List<BoardModel> _posts =
            await _service.fetchBoardList(_studyId!, false);
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

  Future<void> fetchBoardInfo(int boardId) async {
    if (_post == null) {
      try {
        _post = await _service.fetchBoardInfo(_studyId!, boardId);
        boardTitle=_post!.title;
        boardContents=post!.content;
        notifyListeners();
        isValidInput(BoardInputType.boardTitle,_post!.title );
        isValidInput(BoardInputType.boardContents,post!.content);
      } on NoPostException catch (e) {
        throw const NoPost();
      }
    }
  }

  Future<void> deletePost(int boardId) async {
    await _service.deletePost(_studyId!, boardId);
    _isDeleted = true;
    notifyListeners();
  }

  Future<void> createPost() async {
    await _service.createPost(_studyId!, Post(_title, _contents));
    notifyListeners();
  }

  Future<void> updatePost(int boardId) async {
    await _service.updatePost(_studyId!, boardId, Post(_title, contents));
    notifyListeners();
  }

  Future<void> fetchComments(int boardId) async {
    try {
      comments = await _service.fetchComments(_studyId!, boardId);
      if (comments.isNotEmpty) notifyListeners();
    } on NoPostException catch (e) {
      return;
    }
  }
  Future<void> createComment(int boardId) async {
    await _service.createComments(_studyId!,boardId, _comment);
    notifyListeners();
  }

  Future<void> setNotice(int boardId) async {
    await _service.setNotice(_studyId!,boardId);
    notifyListeners();
  }
  Future<void> unsetNotice(int boardId) async {
    await _service.unsetNotice(_studyId!,boardId);
    notifyListeners();
  }

  set setStudyId(int studyId) {
    _studyId = studyId;
  }

  set boardTitle(String title) {
    _title = title;
    notifyListeners();
  }

  set boardContents(String contents) {
    _contents = contents;
    notifyListeners();
  }

  set comment(String comment) {
    _comment = comment;
    notifyListeners();
  }


  void isValidInput(BoardInputType type, String value) {
    switch (type) {
      case BoardInputType.boardTitle:
        _isValid = (value.isNotEmpty && _contents.isNotEmpty) ? true : false;
        boardTitle = value;
      case BoardInputType.boardContents:
        _isValid = (value.isNotEmpty && _title.isNotEmpty) ? true : false;
        boardContents = value;
      case BoardInputType.comment:
        _isValid = (value.isNotEmpty) ? true : false;
        comment = value;
    }
    notifyListeners();
  }

  void resetPosts() {
    posts = [];
    _post = null;
    hasPost = false;
    numOfPosts = 0;
    notifyListeners();
  }

  void setOrUnsetNotice(){
    if(post?.notice == true){
      unsetNotice(post!.id);
    }
    else{
      setNotice(post!.id);
    }
    notifyListeners();
  }


  String getHintText(BoardInputType type) {
    switch (type) {
      case BoardInputType.boardTitle:
        return '제목';
      case BoardInputType.boardContents:
        return '내용을 입력해주세요.';
      case BoardInputType.comment:
        return '댓글을 남겨주세요.';
    }
  }

  String getNoticeTitle(bool isNew) {
    if (isNew == true) {
      return '등록 완료';
    } else {
      return '수정 완료';
    }
  }

  String getNoticeContents(bool isNew) {
    if (isNew == true) {
      return '게시글 등록이 완료되었습니다.';
    } else {
      return '게시글 수정이 완료되었습니다.';
    }
  }
  String getToSetNoticeText(){
    if(post?.notice == true){
      return '공지 등록 취소하기';
    }
    else{
      return '공지로 등록하기';
    }

  }
  String toastText(){
    if(post?.notice == true){
      return '공지 등록이 취소되었어요.';
    }
    else{
      return '공지로 등록되었어요.';
    }

  }



}
