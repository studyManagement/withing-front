import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/cupertino.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import 'package:retrofit/retrofit.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:retrofit/http.dart';
import '../../model/board/board_model.dart';
import '../../model/board/comment_model.dart';
import '../../model/board/post_exception.dart';
import '../../view_models/board/model/post.dart';

part 'board_service.g.dart';

@RestApi()
abstract class BoardApi {
  factory BoardApi(Dio dio, {String baseUrl}) = _BoardApi;

  @GET('/studies/{id}/boards')
  Future<List<BoardModel>> fetchBoardList(
      @Path("id") int id, @Query("isNotice") bool isNotice);

  @GET('/studies/{id}/boards/{boardId}')
  Future<BoardModel> fetchBoardInfo(
      @Path("id") int id, @Path("boardId") int boardId);

  @DELETE('/studies/{id}/boards/{boardId}')
  Future<dynamic> deletePost(@Path("id") int id, @Path("boardId") int boardId);

  @POST('/studies/{id}/boards')
  Future<BoardModel> createPost(
      @Path("id") int id, @Body() Map<String, dynamic> data);

  @PATCH('/studies/{id}/boards/{boardId}')
  Future<BoardModel> updatePost(@Path("id") int id,
      @Path("boardId") int boardId, @Body() Map<String, dynamic> data);

  @GET('/studies/{id}/boards/{boardId}/comments')
  Future<List<CommentModel>> fetchComments(
      @Path("id") int id, @Path("boardId") int boardId);

// @POST('/studies/{id}/boards/{boardId}/comments')
// Future<CommentModel> createComments(
//     @Path("id") int id, @Path("boardId") int boardId);
}

class BoardService {
  final BoardApi _boardApi;

  BoardService(this._boardApi);

  Future<List<BoardModel>> fetchBoardList(int studyId, bool isNotice) async {
    try {
      final List<BoardModel> notices =
          await _boardApi.fetchBoardList(studyId, isNotice);
      return notices;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // 공지 없음
        throw List.empty();
      }
      if (e.code == 400) {
        // 참여 중인 스터디가 아님
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<BoardModel> fetchBoardInfo(int studyId, int boardId) async {
    try {
      final BoardModel boardModel =
          await _boardApi.fetchBoardInfo(studyId, boardId);
      return boardModel;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // 게시글 없음
        throw NoPostException(e.cause);
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deletePost(int studyId, int boardId) async {
    try {
      var response = await _boardApi.deletePost(studyId, boardId);
      debugPrint('[API]: 게시글 삭제됨');
      return response;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // 게시글 없음
        debugPrint('[API]: ${e.cause}');
        rethrow;
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<BoardModel> createPost(int studyId, Post newPost) async {
    try {
      final BoardModel boardModel = await _boardApi.createPost(
          studyId, {"title": newPost.title, "content": newPost.contents});
      return boardModel;
    } on ApiException catch (e) {
      debugPrint('[API]: ${e.cause}');
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<BoardModel> updatePost(
      int studyId, int boardId, Post updatedPost) async {
    try {
      final BoardModel boardModel = await _boardApi.updatePost(studyId, boardId,
          {"title": updatedPost.title, "content": updatedPost.contents});
      return boardModel;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // 게시글 없음
        debugPrint('[API]: ${e.cause}');
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<List<CommentModel>> fetchComments(int studyId, int boardId) async {
    try {
      final List<CommentModel> commentList =
          await _boardApi.fetchComments(studyId, boardId);
      return commentList;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // 게시글 없음
        throw NoPostException(e.cause);
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

// Future<CommentModel> createComments(int studyId, int boardId) async {
//   try {
//     final CommentModel comment =
//     await _boardApi.createPost(id);
//     return comment;
//   } on ApiException catch (e) {
//     if (e.code == 404) {
//       // 게시글 없음
//       throw NoPost();
//     }
//     rethrow;
//   } on NetworkException catch (e) {
//     rethrow;
//   }
// }
}
