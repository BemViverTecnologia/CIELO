import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/domain/repositories/device_id_repository_interface.dart';
import 'package:poppy/app/domain/usecases/get_device_id_usecase.dart';
import 'package:poppy/core/errors/failures.dart';
import 'package:poppy/core/usecases/usecase_without_input.dart';

class DeviceIdRepositoryMock extends Mock implements IDeviceIdRepository {}

main() {
  late UsecaseWithoutInput usecase;
  late IDeviceIdRepository repository;

  setUp(() {
    repository = DeviceIdRepositoryMock();
    usecase = GetDeviceIdUsecase(repository);
  });

  final String tDeviceId = '123';

  test('shoud return a device id string when called', () async {
    when(() => repository.getDeviceId())
        .thenAnswer((invocation) async => Right(tDeviceId));

    final result = await usecase();

    expect(result, Right(tDeviceId));
    verify(() => repository.getDeviceId()).called(1);
  });

  test('shoud return a failure when called', () async {
    when(() => repository.getDeviceId())
        .thenAnswer((invocation) async => Left(GetDeviceIdFailure()));

    final result = await usecase();

    expect(result, Left(GetDeviceIdFailure()));
    verify(() => repository.getDeviceId()).called(1);
  });
}
