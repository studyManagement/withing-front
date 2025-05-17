import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/utils/get_image_file.dart';
import 'package:modi/model/board/comment_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../common/utils/pick_image_file.dart';
import '../../di/injection.dart';
import '../../model/board/board_model.dart';
import 'model/post.dart';

class BoardViewModel extends ChangeNotifier {
  final BoardService _service;

  BoardViewModel(this._service);

  final int SIZE = 20;
  int? _studyId;
  int? _boardId;
  PostCategoryType selectedPostCategoryType = PostCategoryType.ALL;
  bool isRefreshed = true;
  bool _isLoading = false;
  bool _isValid = false;
  bool _isAddedComment = false;
  bool _isFirst = true;
  bool hasNextPosts = true;
  bool hasPost = false;
  bool isMember = false;
  bool isPrivate = false;
  bool _isShowUserList = false;

  String _boardTitle = '';
  String _boardContents = '';
  PostCategory? _boardCategory;
  List<String> _boardImageUrls = []; // 기존 게시글의 이미지 url

  String _comment = '';
  BoardModel? _post;
  List<BoardModel> posts = [];

  List<BoardModel> allPost = [];
  List<UserModel> _users = [];
  List<CommentModel> comments = [];
  List<PostCategory> postCategories = [
    PostCategory(
      id: 0,
      name: "전체",
      type: PostCategoryType.ALL,
      activeIcon: '',
      inactiveIcon: '',
    ),
    PostCategory(
      id: 1,
      name: '자유',
      type: PostCategoryType.FREE,
      activeIcon: 'asset/board/paper_active.png',
      inactiveIcon: 'asset/board/paper_inactive.png',
    ),
    PostCategory(
      id: 2,
      name: '인증',
      type: PostCategoryType.CERT,
      activeIcon: 'asset/board/camera_active.png',
      inactiveIcon: 'asset/board/camera_inactive.png',
    ),
    PostCategory(
      id: 3,
      name: '공지',
      type: PostCategoryType.NOTICE,
      activeIcon: 'asset/board/pin_active.png',
      inactiveIcon: 'asset/board/pin_inactive.png',
    ),
  ];

  final List<int> _mentionedUserList = [];

  List<File> imageFiles = []; // 이미지 업로드 시 파일 저장
  List<String> get boardImageUrls => _boardImageUrls; //  이미지 업로드 시 파일 경로 저장

  BoardModel? get post => _post;

  List<UserModel> get studyMembers => _users;

  bool get isLoading => _isLoading;

  bool get isValid => _isValid;

  bool get isAddedComment => _isAddedComment;

  bool get isFirst => _isFirst;

  bool get isShowUserList => _isShowUserList;

  int? get studyId => _studyId;

  int? get boardId => _boardId;

  set setStudyId(int studyId) {
    _studyId = studyId;
  }

  set boardTitle(String title) {
    _boardTitle = title;
    notifyListeners();
  }

  set boardContents(String contents) {
    _boardContents = contents;
    notifyListeners();
  }

  set boardCategory(PostCategory category) {
    _boardCategory = category;
    notifyListeners();
  }

  set boardImageUrls(List<String> imageUrls) {
    _boardImageUrls = imageUrls;
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
  Future<void> scrollListener(BuildContext context) async {
    if (_isLoading) return;
    _isLoading = true;
    await fetchBoardList(context);
    _isLoading = false;
  }

  Future<void> fetchBoardList(BuildContext context,
      {bool reset = false}) async {
    try {
      if (reset) {
        posts = [];
        hasPost = false;
        hasNextPosts = true;
      }

      List<BoardModel> newPosts = [];
      int page = posts.isEmpty ? 0 : (posts.length ~/ SIZE);

      if (hasNextPosts == true) {
        newPosts = await _service.fetchBoardList(
            _studyId!, selectedPostCategoryType.name, SIZE, page);
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
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        e.cause,
        false,
        () => context.pop(),
        () => null,
      );
    }
  }

  Future<void> fetchBoardInfo(BuildContext context, int boardId) async {
    try {
      _isShowUserList = false;
      _post = await _service.fetchBoardInfo(_studyId!, boardId);
      boardTitle = _post!.title;
      boardContents = post!.content;
      boardImageUrls = post!.images;
      if (boardImageUrls.isNotEmpty) {
        final filesWithNull = await Future.wait(
          boardImageUrls.map((url) => getImageFileFromUrl(url)),
        );
        imageFiles = filesWithNull.whereType<File>().toList();
      }
      boardCategory =
          postCategories.firstWhere((e) => e.type.name == post!.category);
      selectedPostCategoryType =
          (_boardCategory?.type ?? postCategories[1].type);
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
        // 이미지 먼저 등록 후 uuid 리스트 보냄.
        final imageUuidList = await getImageUuidList(imageFiles);
        BoardModel newPost = await _service.createPost(
            _studyId!,
            Post(
                title: _boardTitle,
                contents: _boardContents,
                category: selectedPostCategoryType.name,
                images: imageUuidList));
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
        final imageUuidList = await getImageUuidList(imageFiles);
        BoardModel boardModel = await _service.updatePost(
            _studyId!,
            boardId,
            Post(
                title: _boardTitle,
                contents: _boardContents,
                category: selectedPostCategoryType.name,
              images: imageUuidList));
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
    final study = await getIt<StudyService>().fetchStudyInfo(studyId!);
    _users = study.users;
  }

  Future<void> pickMultiPhoto() async {
    final pickedFiles = await pickMultiImageFile();
    if (pickedFiles.isNotEmpty) {
      imageFiles += pickedFiles.whereType<File>().toList();
    }
    notifyListeners();
  }

  Future<List<String>> getImageUuidList(List<File> files) async {
    if (files.isEmpty) {
      return [];
    }
    List<String> imageUuidList = [];
    if (files.isNotEmpty) {
      final imageCreateService = getIt<ImageCreateService>();
      imageUuidList = await Future.wait(files.map(
              (file) => imageCreateService.callImageCreateApi(file)));
    }
    return imageUuidList;
  }

  void updatePostCategoryType(PostCategoryType type) {
    selectedPostCategoryType = type;
    notifyListeners();
  }

  void removeImage(int index) {
    if (index >= 0 && index < imageFiles.length) {
      imageFiles.removeAt(index);
      notifyListeners();
    }
  }

  void addMentionedUserList(
      BoardInputType type, UserModel user, String newValue) {
    isValidInput(type, newValue);
    if (!_mentionedUserList.contains(user.id)) {
      _mentionedUserList.add(user.id);
    }
    isShowUserList = false;
  }

  void isValidInput(BoardInputType type, String value) {
    switch (type) {
      case BoardInputType.boardTitle:
        _isValid = (value.trim().isNotEmpty && _boardContents.trim().isNotEmpty)
            ? true
            : false;
        boardTitle = value;

      case BoardInputType.boardContents:
        _isValid = (value.trim().isNotEmpty && _boardTitle.trim().isNotEmpty)
            ? true
            : false;
        boardContents = value;

      case BoardInputType.comment:
        _isValid = (value.trim().isNotEmpty) ? true : false;
        comment = value;
    }
    if (type != BoardInputType.comment) notifyListeners();
  }

  void refreshBoardList({PostCategoryType? category}) {
    posts = [];
    hasPost = false;
    hasNextPosts = true;
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
}
