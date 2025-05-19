import 'package:modi/common/requester/api_exception.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart' hide Headers;
import '../../common/requester/network_exception.dart';
import '../../model/device/device_model.dart';

part 'update_service.g.dart';

@RestApi()
abstract class UpdateApi {
  factory UpdateApi(Dio dio, {String baseUrl}) = _UpdateApi;

  @POST("/version")
  @Headers({
    "X-Exclude-Access-Token": "true", // 헤더 필요 없음
  })
  Future<dynamic> checkForUpdate(@Body() Map<String, dynamic> data);
}

class UpdateService {
  final UpdateApi _updateApi;
  UpdateService(this._updateApi);

  Future<bool> checkForUpdate(DeviceModel deviceInfo) async {
    try {
      final response = await _updateApi.checkForUpdate(deviceInfo.toJson());
      final requiredUpdate = response['data']?['isRequiredUpdate'] ?? false;
      return requiredUpdate;
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}