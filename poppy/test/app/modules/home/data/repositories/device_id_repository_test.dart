import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datource_interface.dart';
import 'package:poppy/app/modules/home/data/repositories/device_id_repository.dart';
import 'package:poppy/app/modules/home/domain/repositories/device_id_repository_interface.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/errors/failures.dart';

class DeviceIdDatasourceMock extends Mock implements IDeviceIdDatasource {}

main() {
  late IDeviceIdDatasource datasource;
  late IDeviceIdRepository repository;

  setUp(() {
    datasource = DeviceIdDatasourceMock();
    repository = DeviceIdRepository(datasource);
  });

  final tDeviceId = '1234';
  test('shoud return a device id when call datasource', () async {
    when(() => datasource.getDeviceIdFromNative())
        .thenAnswer((_) async => tDeviceId);

    final result = await repository.getDeviceId();

    expect(result, Right(tDeviceId));
    verify(() => datasource.getDeviceIdFromNative()).called(1);
  });
  test('shoud return a empty device id failure when call datasource', () async {
    when(() => datasource.getDeviceIdFromNative()).thenAnswer((_) async => '');

    final result = await repository.getDeviceId();

    expect(result, Left(EmptyDeviceIdFailure()));
    verify(() => datasource.getDeviceIdFromNative()).called(1);
  });
  test('shoud return a device call failure when call datasource', () async {
    when(() => datasource.getDeviceIdFromNative()).thenThrow(DeviceException());

    final result = await repository.getDeviceId();

    expect(result, Left(DeviceCallFailure()));
    verify(() => datasource.getDeviceIdFromNative()).called(1);
  });
  test(
      'shoud return a device call failure when datasource throw an UnimplementedChannelException',
      () async {
    when(() => datasource.getDeviceIdFromNative())
        .thenThrow(UnimplementedChannelException());

    final result = await repository.getDeviceId();

    expect(result, Left(DeviceCallFailure()));
    verify(() => datasource.getDeviceIdFromNative()).called(1);
  });
}
