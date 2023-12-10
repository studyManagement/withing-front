import 'package:http/http.dart' as http;
import 'package:withing/common/requester/api_response.dart';

import '../const/environment.dart';
import '../environment/environment.dart';

class Requester {
  static get(String url, Map<String, dynamic> queryParameter) async {
    final uri = Uri.http(Environment.getEnv(API_SERVER), url, queryParameter);
    final response = await http.get(uri);

    return ApiResponse.fromJson(response.body);
  }

  static post(String url, String bodyParameter) async {
    final uri = Uri.http(Environment.getEnv(API_SERVER), url);
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: bodyParameter);

    return ApiResponse.fromJson(response.body);
  }
}
