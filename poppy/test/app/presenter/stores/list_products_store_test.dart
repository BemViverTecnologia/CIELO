import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/domain/models/product_model.dart';
import 'package:poppy/app/domain/usecases/get_device_id_usecase.dart';
import 'package:poppy/app/domain/usecases/get_list_products_usecase.dart';
import 'package:poppy/app/presenter/controllers/list_products_store.dart';
import 'package:poppy/core/errors/failures.dart';

class GetListProductsUsecaseMock with Mock implements GetListProductsUsecase {}

class GetDeviceIdMock extends Mock implements GetDeviceIdUsecase {}

main() {
  late ListProductsStore store;
  late GetListProductsUsecase usecase;

  setUp(() {
    usecase = GetListProductsUsecaseMock();
    store = ListProductsStore(usecase);
  });
  final List<Product> tProductsList = [
    Product(123456, 'Product 1', 100.00),
    Product(1234567, 'Product 2', 50.00),
  ];
  final String tDeviceId = '1234567890';

  test('should return a list of product from usecase', () async {
    when(() => usecase(any())).thenAnswer((_) async => Right(tProductsList));

    await store.getListProductsByDeviceId(tDeviceId);

    store.observer(onState: (state) {
      expect(state, tProductsList);
      verify(() => usecase(tDeviceId)).called(1);
    });
  });
  test('should return a failure from usecase', () async {
    when(() => usecase(any())).thenAnswer((_) async => Left(ServerFailure()));

    await store.getListProductsByDeviceId(tDeviceId);

    store.observer(onError: (error) {
      expect(error, ServerFailure());
      verify(() => usecase(tDeviceId)).called(1);
    });
  });
}
