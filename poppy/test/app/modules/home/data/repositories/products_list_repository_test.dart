import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/modules/home/data/datasources/products_list_datasource_interface.dart';
import 'package:poppy/app/modules/home/data/repositories/products_list_repository.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/domain/repositories/products_list_repository_interface.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/errors/failures.dart';

class ProductsListDatasourceMock extends Mock
    implements IProductsListDatasource {}

main() {
  late IProductsListRepository repository;
  late IProductsListDatasource datasource;

  final List<Product> tProductsList = [
    Product(123456, 'Product 1', 100.00),
    Product(1234567, 'Product 2', 50.00),
  ];
  final String tDeviceId = '1234567890';

  setUp(() {
    datasource = ProductsListDatasourceMock();
    repository = ProductsListRepository(datasource);
  });

  test('return list of products when calls the datasource', () async {
    // ARRANGE
    when(() => datasource.getProductsByDevice(tDeviceId))
        .thenAnswer((_) async => tProductsList);
    // ACT
    final result = await repository.getProductsByDevice(tDeviceId);
    // ASSERT

    expect(result, Right(tProductsList));
    verify(() => datasource.getProductsByDevice(tDeviceId)).called(1);
  });
  test('return a server exception when calls the datasource', () async {
    // ARRANGE
    when(() => datasource.getProductsByDevice(tDeviceId))
        .thenThrow(ServerException());
    // ACT
    final result = await repository.getProductsByDevice(tDeviceId);
    // ASSERT

    expect(result, Left(ServerFailure()));
    verify(() => datasource.getProductsByDevice(tDeviceId)).called(1);
  });

  test('datasource receive a deviceId as param when called', () async {
    // ARRANGE
    when(() => datasource.getProductsByDevice(tDeviceId))
        .thenAnswer((_) async => tProductsList);
    // ACT
    final result = await repository.getProductsByDevice(tDeviceId);
    // ASSERT

    expect(result, Right(tProductsList));
    var captured =
        verify(() => datasource.getProductsByDevice(captureAny())).captured;
    expect(captured, isA<List<dynamic>>());
    expect(captured.length, 1);
    expect(captured.last, equals(tDeviceId));
  });
}
