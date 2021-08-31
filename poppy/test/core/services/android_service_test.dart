import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/data/datasources/endpoints/channel_methods.dart';
import 'package:poppy/core/services/android_service.dart';
import 'package:poppy/core/services/android_service_interface.dart';

class MethodChannelMock extends Mock implements MethodChannel {}

main() {
  late IAndroidService androidService;
  late MethodChannel channel;

  setUp(() {
    channel = MethodChannelMock();
    androidService = AndroidService(channel);
  });

  final tMethodName = ChannelMethods.deviceIdChannel;

  test(
    'must return an android resposnse when invoke method channel',
    () async {
      when(() => channel.invokeMethod(any())).thenAnswer((_) async => '1234');

      final result = await androidService.getDeviceId(tMethodName);

      expect(result, isA<AndroidServiceResponse>());
      expect(result.data, equals('1234'));
      verify(() => channel.invokeMethod(any())).called(1);
    },
  );
  test(
    'must receive a method name as param when invoke method channel',
    () async {
      when(() => channel.invokeMethod(any())).thenAnswer((_) async => '1234');

      final result = await androidService.getDeviceId(tMethodName);

      final captured =
          verify(() => channel.invokeMethod(captureAny())).captured;
      expect(result, isA<AndroidServiceResponse>());
      expect(captured.last, equals(tMethodName));
    },
  );
}
