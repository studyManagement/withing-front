import 'package:http/http.dart' as http;
import 'package:withing/common/requester/api_response.dart';

import '../const/environment.dart';
import '../environment/environment.dart';

class Requester {
  static get(String url, Map<String, dynamic> queryParameter) async {
    final uri = Uri.http(
        Environment.getEnv(API_SERVER), '/users/check', queryParameter);
    final response = await http.get(uri);

    return ApiResponse.fromJson(response.body);
  }
}
