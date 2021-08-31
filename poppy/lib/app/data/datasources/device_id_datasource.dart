import 'package:flutter/services.dart';
import 'package:poppy/app/data/datasources/device_id_datource_interface.dart';
import 'package:poppy/app/data/datasources/endpoints/channel_methods.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/services/android_service_interface.dart';

class DeviceIdDatasource implements IDeviceIdDatasource {
  final IAndroidService _androidService;

  DeviceIdDatasource(this._androidService);

  @override
  Future<String> getDeviceIdFromNative() async {
    try {
      final response =
          await _androidService.getDeviceId(ChannelMethods.deviceIdChannel);

      return response.data;
    } on PlatformException {
      throw DeviceException();
    } on MissingPluginException {
      throw UnimplementedChannelException();
    }
  }
}
