abstract class IAndroidService {
  Future<AndroidServiceResponse> getDeviceId(String methodName);
}

class AndroidServiceResponse {
  final dynamic data;

  AndroidServiceResponse({required this.data});
}
