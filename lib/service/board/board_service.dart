import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:retrofit/http.dart';
import '../../exception/study/study_exception.dart';
import '../../model/board/board_model.dart';
import '../../model/board/comment_model.dart';
import '../../view_models/board/model/post.dart';

part 'board_service.g.dart';

@RestApi()
abstract class BoardApi {
  factory BoardApi(Dio dio, {String baseUrl}) = _BoardApi;

  @GET('/studies/{id}/boards')
  Future<List<BoardModel>> fetchBoardList(
    @Path("id") int id,
    @Query("isNotice") bool isNotice,
    @Query("size") int size,
    @Query("page") int page,
  );

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

  @POST('/studies/{id}/boards/{boardId}/comments')
  Future<CommentModel> createComments(@Path("id") int id,
      @Path("boardId") int boardId, @Body() Map<String, dynamic> data);

  @POST('/studies/{id}/boards/{boardId}/notice')
  Future<dynamic> setNotice(@Path("id") int id, @Path("boardId") int boardId);

  @DELETE('/studies/{id}/boards/{boardId}/notice')
  Future<dynamic> unsetNotice(@Path("id") int id, @Path("boardId") int boardId);
}

class BoardService {
  final BoardApi _boardApi;

  BoardService(this._boardApi);

  Future<List<BoardModel>> fetchBoardList(
      int studyId, bool isNotice, int size, int page) async {
    try {
      final List<BoardModel> notices =
          await _boardApi.fetchBoardList(studyId, isNotice, size, page);
      return notices;
    } on ApiException catch (e) {
      throw StudyException(e.cause, e.code);
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
      throw StudyException(e.cause, e.code);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deletePost(int studyId, int boardId) async {
    try {
      var response = await _boardApi.deletePost(studyId, boardId);
      return response;
    } on ApiException catch (e) {
      throw StudyException(e.cause, e.code);
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
      throw StudyException(e.cause, e.code);
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
      throw StudyException(e.cause, e.code);
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
      throw StudyException(e.cause, e.code);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<CommentModel> createComments(
      int studyId, int boardId, String contents) async {
    try {
      final CommentModel comment = await _boardApi
          .createComments(studyId, boardId, {'contents': contents});
      return comment;
    } on ApiException catch (e) {
      throw StudyException(e.cause, e.code);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> setNotice(int studyId, int boardId) async {
    try {
      var response = await _boardApi.setNotice(studyId, boardId);
      return response;
    } on ApiException catch (e) {
      throw StudyException(e.cause, e.code);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> unsetNotice(int studyId, int boardId) async {
    try {
      var response = await _boardApi.unsetNotice(studyId, boardId);
      return response;
    } on ApiException catch (e) {
      throw StudyException(e.cause, e.code);
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
