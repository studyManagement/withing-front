import 'package:dio/dio.dart';

const localhost = 'http://192.168.45.169:8080';

// 내 스터디 api
Future<List> getMyStudyList() async {
  final dio = Dio();

  final resp = await dio.get('$localhost/study/mystudy/5');

  return resp.data['data'];
}
