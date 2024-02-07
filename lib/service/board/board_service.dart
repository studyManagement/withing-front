import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:retrofit/http.dart';
import '../../model/board/board_model.dart';

part 'board_service.g.dart';

@RestApi()
abstract class BoardApi {
  factory BoardApi(Dio dio, {String baseUrl}) = _BoardApi;

  @GET('/studies/{id}/boards')
  Future<List<BoardModel>> fetchBoards(@Path("id") int id,
      @Query("isNotice") bool isNotice);

}

class BoardService {
  final BoardApi _boardApi;
  BoardService(this._boardApi);

  Future<List<BoardModel>> fetchBoards(int studyId, bool isNotice) async {
    try {
      final List<BoardModel> notices =
      await _boardApi.fetchBoards(studyId, isNotice);
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
}