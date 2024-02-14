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

  int? _studyId;
  bool _isLoading = false;
  bool _isValid = false;
  bool _isFirst = true;
  bool hasNext = true;
  bool hasPost = false;

  List<BoardModel> posts = [];
  List<BoardModel> notices = [];
  List<BoardModel> allPost = [];

  List<CommentModel> comments = [];
  BoardModel? _post;

  BoardModel? get post => _post;

  bool get isValid => _isValid;

  bool get isFirst => _isFirst;
  String _title = '';
  String _contents = '';
  String _comment = '';

  String get title => _title;

  String get contents => _contents;

  String get comment => _comment;

  int? get studyId => _studyId;

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
    int page = notices.isEmpty ? 1 : (notices.length ~/ 100) + 1;
    if (hasNext == true) {
      newNotices = await _service.fetchBoardList(_studyId!, true, 200, page);
      if (newNotices.length < 100) hasNext = false;
    }
    if (newNotices.isNotEmpty) {
      notices.addAll(newNotices);
      hasPost = true;
      notifyListeners();
    }
  }

  Future<void> fetchBoardList() async {
    List<BoardModel> newPosts = [];
    int page = posts.isEmpty ? 1 : (posts.length ~/ 100) + 1;
    if (hasNext == true) {
      newPosts = await _service.fetchBoardList(_studyId!, false, 200, page);
      if (newPosts.length < 100) hasNext = false;
    }
    if (newPosts.isNotEmpty) {
      posts.addAll(newPosts);
      hasPost = true;
      notifyListeners();
    }
  }

  Future<void> fetchBoardInfo(int boardId) async {
    if (_post == null) {
      try {
        _post = await _service.fetchBoardInfo(_studyId!, boardId);
        boardTitle = _post!.title;
        boardContents = post!.content;
        notifyListeners();
        isValidInput(BoardInputType.boardTitle, _post!.title);
        isValidInput(BoardInputType.boardContents, post!.content);
      } on NoPostException catch (e) {
        throw const NoPost();
      }
    }
  }

  Future<void> deletePost(int boardId) async {
    await _service.deletePost(_studyId!, boardId);
   // _isDeleted = true;
    posts.removeWhere((element) => element.id == boardId);
    notifyListeners();
  }

  Future<void> createPost() async {
    BoardModel boardModel =
        await _service.createPost(_studyId!, Post(_title, _contents));
    posts.add(boardModel);
    //  addToBoardList(boardModel);
    notifyListeners();
  }

  Future<void> updatePost(int boardId) async {
    BoardModel boardModel =
        await _service.updatePost(_studyId!, boardId, Post(_title, _contents));
    _post = boardModel;
    notifyListeners();
  }

  Future<void> fetchComments(int boardId) async {
    if (comments.isEmpty && _isFirst == true) {
      try {
        _isFirst = false;
        comments = await _service.fetchComments(_studyId!, boardId);
        if (comments.isNotEmpty) notifyListeners();
      } on NoPostException catch (e) {
        return;
      }
    }
  }

  Future<void> createComment(int boardId) async {
    CommentModel newComment =
        await _service.createComments(_studyId!, boardId, _comment);
    comments.add(newComment);
    comment = '';
    notifyListeners();
  }

  Future<void> setNotice(int boardId) async {
    await _service.setNotice(_studyId!, boardId);
    notifyListeners();
  }

  Future<void> unsetNotice(int boardId) async {
    await _service.unsetNotice(_studyId!, boardId);
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

  void addToBoardList(BoardModel newPost) {
    posts.add(newPost);
    notifyListeners();
  }

  void isValidInput(BoardInputType type, String value) {
    // print('유효성 검사');
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
    if (type != BoardInputType.comment) notifyListeners();
  }

  void setOrUnsetNotice() {
    if (post?.notice == true) {
      unsetNotice(post!.id);
    } else {
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

  String getToSetNoticeText() {
    if (post?.notice == true) {
      return '공지 등록 취소하기';
    } else {
      return '공지로 등록하기';
    }
  }

  String toastText() {
    if (post?.notice == true) {
      return '공지 등록이 취소되었어요.';
    } else {
      return '공지로 등록되었어요.';
    }
  }
}
