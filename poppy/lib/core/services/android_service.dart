import 'package:flutter/services.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/services/android_service_interface.dart';

class AndroidService implements IAndroidService {
  final MethodChannel channel;

  AndroidService(this.channel);

  @override
  Future<AndroidServiceResponse> getDeviceId(String methodName) async {
    try {
      final response = await channel.invokeMethod(methodName);

      if (response == null) {
        throw DeviceException();
      }

      return AndroidServiceResponse(data: response);
    } on PlatformException {
      throw DeviceException();
    } on MissingPluginException {
      throw UnimplementedChannelException();
    } catch (e) {
      throw DeviceException();
    }
  }
}
