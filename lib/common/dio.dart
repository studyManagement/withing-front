import 'package:dio/dio.dart';

const api = 'http://3.34.178.101:8080';

// 내 스터디 api
Future<List> getMyStudyList() async {
  final dio = Dio();

  final resp = await dio.get('$api/study/mystudy/5');

  return resp.data['data'];
}
