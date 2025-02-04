import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import '../../common/components/bottom_toast.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../exception/study/study_exception.dart';
import '../../model/board/board_model.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;
  final BuildContext _context;

  BoardViewModel(this._context, this._service);

  final int SIZE = 20;

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
  bool isMember = false;

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
    try {
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
        notifyListeners();
      }
    }on StudyException catch (e){
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
              () => _context.pop(), () => null);
    }
  }

  Future<void> fetchBoardList() async {
    try {
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
        notifyListeners();
      }
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
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
    } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
    }
  }

  Future<void> deletePost(int boardId) async {
    try {
      await _service.deletePost(_studyId!, boardId);
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  Future<void> createPost() async {
    if (_isValid) {
      try {
        BoardModel newPost =
            await _service.createPost(_studyId!, Post(_title, _contents));
        _boardId = newPost.id;
        notifyListeners();
      } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
      }
    }
  }

  Future<void> updatePost(int boardId) async {
    if (_isValid) {
      try {
        BoardModel boardModel = await _service.updatePost(
            _studyId!, boardId, Post(_title, _contents));
        _post = boardModel;
        _boardId = boardModel.id;
        notifyListeners();
      } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
      }
    }
  }

  Future<void> fetchComments(int boardId) async {
    try {
      _isAddedComment = false;
      _isFirst = false;
      comments = await _service.fetchComments(_studyId!, boardId);
      if (comments.isNotEmpty) notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  Future<void> createComment(int boardId) async {
    if (_isValid && _comment.trim().isNotEmpty) {
      try {
        CommentModel newComment =
            await _service.createComments(_studyId!, boardId, _comment);
        comments.add(newComment);
        comment = '';
        _isAddedComment = true;
        notifyListeners();
      } on ApiException catch (e) {
        if (!_context.mounted) return;
        ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
            () => _context.pop(), () => null);
      }
    }
  }

  Future<void> setNotice(int boardId) async {
    try {
      await _service.setNotice(_studyId!, boardId);
      refreshBoardList();
      BottomToast(context: _context, text: toastText()).show();
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  Future<void> unsetNotice(int boardId) async {
    try {
      await _service.unsetNotice(_studyId!, boardId);
      refreshBoardList();
      BottomToast(context: _context, text: toastText()).show();
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
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
    if (_isNotice == true) {
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
        return (isMember) ? '댓글을 남겨주세요.' : '스터디 멤버만 댓글을 남길 수 있어요.';
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
    if (_isNotice!) {
      return '공지 등록 취소하기';
    } else {
      return '공지로 등록하기';
    }
  }

  String toastText() {
    if (!_isNotice!) {
      return '공지 등록이 취소되었어요.';
    } else {
      return '공지로 등록되었어요.';
    }
  }

  String postCreatedText(String createdAt) {
    DateTime now = DateTime.now();
    DateTime createdTime = DateTime.parse(createdAt);
    Duration difference = now.difference(createdTime);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return DateFormat('HH:mm').format(createdTime);
    } else if (difference.inDays < 365) {
      return DateFormat('MM.dd').format(createdTime);
    } else {
      return DateFormat('yyyy.MM.dd').format(createdTime);
    }
  }

}
