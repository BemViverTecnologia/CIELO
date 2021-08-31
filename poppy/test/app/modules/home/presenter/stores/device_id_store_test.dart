import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/modules/home/domain/usecases/get_device_id_usecase.dart';
import 'package:poppy/app/modules/home/presenter/controllers/device_id_store.dart';
import 'package:poppy/core/errors/failures.dart';
import 'package:poppy/core/usecases/usecase_without_input.dart';

class GetDeviceIdUsecaseMock extends Mock implements GetDeviceIdUsecase {}

main() {
  late DeviceIdStore store;
  late GetDeviceIdUsecase usecase;

  setUp(() {
    usecase = GetDeviceIdUsecaseMock();
    store = DeviceIdStore(usecase);
  });

  final String tDeviceId = '1234';

  test('should return a device id when call store', () async {
    when(() => usecase()).thenAnswer((_) async => Right(tDeviceId));

    store.getDeviceId();

    store.observer(onState: (state) {
      expect(state, tDeviceId);
      verify(() => usecase()).called(1);
    });
  });
  test('should return a empty string when call store', () async {
    when(() => usecase()).thenAnswer((_) async => Left(DeviceCallFailure()));

    store.getDeviceId();

    store.observer(onState: (state) {
      expect(state, 'Erro ao buscar id do device');
      verify(() => usecase()).called(1);
    });
  });
}
