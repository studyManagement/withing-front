import 'package:flutter/material.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import '../../model/board/board_model.dart';
import '../../model/board/post_exception.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;

  BoardViewModel(this._service);

  static const int SIZE = 20;

  int? _studyId;
  int? _boardId;
  bool isRefreshed = true;
  bool _isLoading = false;
  bool _isValid = false;
  bool _isAddedComment = false;
  bool _isFirst = true;
  bool hasNextNotices = true;
  bool hasNextPosts = true;
  bool hasPost = false;
  bool? _isNotice;

  List<BoardModel> posts = [];
  List<BoardModel> notices = [];
  List<BoardModel> allPost = [];

  List<CommentModel> comments = [];
  BoardModel? _post;

  BoardModel? get post => _post;

  bool get isValid => _isValid;

  bool get isAddedComment => _isAddedComment;

  bool get isFirst => _isFirst;
  String _title = '';
  String _contents = '';
  String _comment = '';

  String get title => _title;

  String get contents => _contents;

  String get comment => _comment;

  int? get studyId => _studyId;
  int? get boardId => _boardId;

  Future<void> scrollListener(bool isNotice) async {
    if (_isLoading) return;
    _isLoading = true;
    if (isNotice == true) {
      await fetchNotices();
    } else {
      await fetchBoardList();
    }
    _isLoading = false;
  }

  Future<void> fetchNotices() async {
    List<BoardModel> newNotices = [];
    int page = notices.isEmpty ? 0 : (notices.length ~/ SIZE);
    if (hasNextNotices) {
      newNotices = await _service.fetchBoardList(_studyId!, true, SIZE, page);
      if (newNotices.length < SIZE) {
        hasNextNotices = false;
      }
    }
    if (newNotices.isNotEmpty) {
      notices.addAll(newNotices);
      hasPost = true;
      // print(notices.length);
      notifyListeners();
    }
  }

  Future<void> fetchBoardList() async {
    List<BoardModel> newPosts = [];
    int page = posts.isEmpty ? 0 : (posts.length ~/ SIZE);
    if (hasNextPosts == true) {
      newPosts = await _service.fetchBoardList(_studyId!, false, SIZE, page);
      if (newPosts.length < SIZE) {
        hasNextPosts = false;
      }
    }
    if (newPosts.isNotEmpty) {
      posts.addAll(newPosts);
      hasPost = true;
      // print(posts.length);
      notifyListeners();
    }
  }

  Future<void> fetchBoardInfo(int boardId) async {
    try {
      _post = await _service.fetchBoardInfo(_studyId!, boardId);
      boardTitle = _post!.title;
      boardContents = post!.content;
      _isNotice = post!.notice;
      notifyListeners();
      isValidInput(BoardInputType.boardTitle, _post!.title);
      isValidInput(BoardInputType.boardContents, post!.content);
    } on NoPostException catch (e) {
      throw const NoPost();
    }
  }

  Future<void> deletePost(int boardId) async {
    await _service.deletePost(_studyId!, boardId);
    notifyListeners();
  }

  Future<void> createPost() async {
    if (_isValid) {
      BoardModel newPost = await _service.createPost(_studyId!, Post(_title, _contents));
      _boardId = newPost.id;
      }
      notifyListeners();
    }

  Future<void> updatePost(int boardId) async {
    if (_isValid) {
      BoardModel boardModel = await _service.updatePost(
          _studyId!, boardId, Post(_title, _contents));
      _post = boardModel;
      _boardId = boardModel.id;
      notifyListeners();
    }
  }

  Future<void> fetchComments(int boardId) async {
    try {
      _isAddedComment = false;
      _isFirst = false;
      comments = await _service.fetchComments(_studyId!, boardId);
      if (comments.isNotEmpty) notifyListeners();
    } on NoPostException catch (e) {
      return;
    }
  }

  Future<void> createComment(int boardId) async {
    if (_isValid && _comment.trim().isNotEmpty) {
      CommentModel newComment =
          await _service.createComments(_studyId!, boardId, _comment);
      comments.add(newComment);
      comment = '';
      _isAddedComment = true;
      notifyListeners();
    }
  }

  Future<void> setNotice(int boardId) async {
    await _service.setNotice(_studyId!, boardId);
    refreshBoardList();
    notifyListeners();
  }

  Future<void> unsetNotice(int boardId) async {
    await _service.unsetNotice(_studyId!, boardId);
    refreshBoardList();
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

  set isValid(bool value) {
    _isValid = value;
    notifyListeners();
  }

  void setOrUnsetNotice() {
    if (post?.notice == true) {
      unsetNotice(post!.id);
      _isNotice = false;
    } else {
      setNotice(post!.id);
      _isNotice = true;
    }
  }

  void refreshBoardList() {
    posts = [];
    notices = [];
    hasPost = false;
    hasNextPosts = true;
    hasNextNotices = true;
    isRefreshed = true;
  }

  void isValidInput(BoardInputType type, String value) {
    // print('유효성 검사');
    switch (type) {
      case BoardInputType.boardTitle:
        _isValid = (value.trim().isNotEmpty && _contents.trim().isNotEmpty)
            ? true
            : false;
        boardTitle = value;

      case BoardInputType.boardContents:
        _isValid = (value.trim().isNotEmpty && _title.trim().isNotEmpty)
            ? true
            : false;
        boardContents = value;

      case BoardInputType.comment:
        _isValid = (value.trim().isNotEmpty) ? true : false;
        comment = value;
    }
    if (type != BoardInputType.comment) notifyListeners();
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

  String getToSetNoticeText() {
    if (post?.notice == true || _isNotice!) {
      return '공지 등록 취소하기';
    } else {
      return '공지로 등록하기';
    }
  }

  String toastText() {
    if (post?.notice == true || !_isNotice!) {
      return '공지 등록이 취소되었어요.';
    } else {
      return '공지로 등록되었어요.';
    }
  }
}
