import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datasource.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datource_interface.dart';
import 'package:poppy/app/modules/home/data/datasources/endpoints/channel_methods.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/services/android_service_interface.dart';

class AndroidServiceMock extends Mock implements IAndroidService {}

main() {
  late IDeviceIdDatasource datasource;
  late IAndroidService androidService;

  setUp(() {
    androidService = AndroidServiceMock();
    datasource = DeviceIdDatasource(androidService);
  });

  final AndroidServiceResponse response = AndroidServiceResponse(data: '1234');

  test('must return a device id when call android service', () async {
    when(() => androidService.getDeviceId(any()))
        .thenAnswer((_) async => response);

    final result = await datasource.getDeviceIdFromNative();

    expect(result, isA<String>());
    verify(() => androidService.getDeviceId(any())).called(1);
  });
  test('must receive a correct channel name when call android service',
      () async {
    when(() => androidService.getDeviceId(ChannelMethods.deviceIdChannel))
        .thenAnswer((_) async => response);

    await datasource.getDeviceIdFromNative();

    final captured =
        verify(() => androidService.getDeviceId(captureAny())).captured;
    expect(captured.length, 1);
    expect(captured.last, equals(ChannelMethods.deviceIdChannel));
  });
  test('must throw a deviceException when call android service', () async {
    when(() => androidService.getDeviceId(ChannelMethods.deviceIdChannel))
        .thenThrow(PlatformException(code: '12345'));

    final result = datasource.getDeviceIdFromNative();

    expect(() => result, throwsA(DeviceException()));
    verify(() => androidService.getDeviceId(any())).called(1);
  });
  test('must throw a unimplementedException when call android service',
      () async {
    when(() => androidService.getDeviceId(ChannelMethods.deviceIdChannel))
        .thenThrow(MissingPluginException());

    final result = datasource.getDeviceIdFromNative();

    expect(() => result, throwsA(UnimplementedChannelException()));
    verify(() => androidService.getDeviceId(any())).called(1);
  });
}
