import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import '../../common/components/bottom_toast.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../common/utils/pick_image_file.dart';
import '../../di/injection.dart';
import '../../exception/study/study_exception.dart';
import '../../model/board/board_model.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;

  BoardViewModel(this._service);

  final int SIZE = 20;
  int? _studyId;
  int? _boardId;
  int _selectedPostCategoryIndex = -1;
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
  bool _isShowUserList = false;
  String _title = '';
  String _contents = '';
  String _comment = '';
  BoardModel? _post;
  List<BoardModel> posts = [];
  List<BoardModel> notices = [];
  List<BoardModel> allPost = [];
  List<UserModel> _users = [];
  List<CommentModel> comments = [];
  List<PostCategory> postCategories = [
    PostCategory(
      id: 0,
      name: '자유',
      activeIcon: 'asset/board/paper_active.png',
      inactiveIcon: 'asset/board/paper_inactive.png',
    ),
    PostCategory(
      id: 1,
      name: '인증',
      activeIcon: 'asset/board/camera_active.png',
      inactiveIcon: 'asset/board/camera_inactive.png',
    ),
    PostCategory(
      id: 2,
      name: '공지',
      activeIcon: 'asset/board/pin_active.png',
      inactiveIcon: 'asset/board/pin_inactive.png',
    ),
  ];

  List<int> _mentionedUserList = [];
  List<String> imageFilePaths = []; //  다중 이미지 저장 리스트

  BoardModel? get post => _post;

  List<UserModel> get studyMembers => _users;

  bool get isValid => _isValid;

  bool get isAddedComment => _isAddedComment;

  bool get isFirst => _isFirst;

  bool get isShowUserList => _isShowUserList;

  int? get studyId => _studyId;

  int? get boardId => _boardId;

  int get selectedPostCategoryIndex => _selectedPostCategoryIndex;

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

  set isShowUserList(bool value) {
    _isShowUserList = value;
    notifyListeners();
  }

/// board list scroll
  Future<void> scrollListener(BuildContext context, bool isNotice) async {
    if (_isLoading) return;
    _isLoading = true;
    if (isNotice == true) {
      await fetchNotices(context);
    } else {
      await fetchBoardList(context);
    }
    _isLoading = false;
  }

  /// posts and notices
  Future<void> fetchNotices(BuildContext context) async {
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
    } on StudyException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    }
  }

  Future<void> fetchBoardList(BuildContext context) async {
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
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    }
  }

  Future<void> fetchBoardInfo(BuildContext context, int boardId) async {
    try {
      _post = await _service.fetchBoardInfo(_studyId!, boardId);
      boardTitle = _post!.title;
      boardContents = post!.content;
      _isNotice = post!.notice;
      notifyListeners();
      isValidInput(BoardInputType.boardTitle, _post!.title);
      isValidInput(BoardInputType.boardContents, post!.content);
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    }
  }

  Future<void> deletePost(BuildContext context, int boardId) async {
    try {
      await _service.deletePost(_studyId!, boardId);
      notifyListeners();
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    }
  }

  Future<void> createPost(BuildContext context) async {
    if (_isValid) {
      try {
        BoardModel newPost =
            await _service.createPost(_studyId!, Post(_title, _contents));
        _boardId = newPost.id;
        notifyListeners();
      } on ApiException catch (e) {
        if (!context.mounted) return;
        ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
            () => context.pop(), () => null);
      }
    }
  }

  Future<void> updatePost(BuildContext context, int boardId) async {
    if (_isValid) {
      try {
        BoardModel boardModel = await _service.updatePost(
            _studyId!, boardId, Post(_title, _contents));
        _post = boardModel;
        _boardId = boardModel.id;
        notifyListeners();
      } on ApiException catch (e) {
        if (!context.mounted) return;
        ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
            () => context.pop(), () => null);
      }
    }
  }

  /// comments
  Future<void> fetchComments(BuildContext context, int boardId) async {
    try {
      _isAddedComment = false;
      _isFirst = false;
      comments = await _service.fetchComments(_studyId!, boardId);
      if (comments.isNotEmpty) notifyListeners();
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    }
  }

  Future<void> createComment(BuildContext context, int boardId) async {
    if (_isValid && _comment.trim().isNotEmpty) {
      try {
        CommentModel newComment =
            await _service.createComments(_studyId!, boardId, _comment);
        comments.add(newComment);
        comment = '';
        _isAddedComment = true;
        notifyListeners();
      } on ApiException catch (e) {
        if (!context.mounted) return;
        ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
            () => context.pop(), () => null);
      }
    }
  }

  /// utils
  Future<void> fetchStudyMembers() async {
    final _study = await getIt<StudyService>().fetchStudyInfo(studyId!);
    _users = _study.users
        .where((e) => e.id != Authentication.instance.userId)
        .toList();
  }

  Future<void> pickMultiPhoto() async {
    List<File>? pickedFiles = await pickMultiImageFile();
    if (pickedFiles != null) {
      imageFilePaths = pickedFiles.map((file) => file.path).toList();
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < imageFilePaths.length) {
      imageFilePaths.removeAt(index);
      notifyListeners();
    }
  }

  void updateSelectedCategory(int categoryId) {
    _selectedPostCategoryIndex = categoryId;
    notifyListeners();
  }

  void addMentionedUserList(UserModel user) {
    if (!_mentionedUserList.contains(user.id)) {
      _mentionedUserList.add(user.id);
    }
    isShowUserList = false;
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

  void refreshBoardList() {
    posts = [];
    notices = [];
    hasPost = false;
    hasNextPosts = true;
    hasNextNotices = true;
    isRefreshed = true;
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

  /// notices
  Future<void> setNotice(BuildContext context, int boardId) async {
    try {
      await _service.setNotice(_studyId!, boardId);
      refreshBoardList();
      if (!context.mounted) return;
      BottomToast(context: context, text: toastText()).show();
      notifyListeners();
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
              () => context.pop(), () => null);
    }
  }

  Future<void> unsetNotice(BuildContext context, int boardId) async {
    try {
      await _service.unsetNotice(_studyId!, boardId);
      refreshBoardList();
      if (!context.mounted) return;
      BottomToast(context: context, text: toastText()).show();
      notifyListeners();
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
              () => context.pop(), () => null);
    }
  }

  void setOrUnsetNotice(BuildContext context) {
    if (_isNotice == true) {
      unsetNotice(context, post!.id);
      _isNotice = false;
    } else {
      setNotice(context, post!.id);
      _isNotice = true;
    }
  }

  String toastText() {
    if (!_isNotice!) {
      return '공지 등록이 취소되었어요.';
    } else {
      return '공지로 등록되었어요.';
    }
  }
}
