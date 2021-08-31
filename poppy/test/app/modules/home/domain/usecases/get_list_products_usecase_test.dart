import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/domain/repositories/products_list_repository_interface.dart';
import 'package:poppy/app/modules/home/domain/usecases/get_list_products_usecase.dart';
import 'package:poppy/core/errors/failures.dart';
import 'package:poppy/core/usecases/usecase.dart';

class ProductsRepositoryMock extends Mock implements IProductsListRepository {}

main() {
  late GetListProductsUsecase usecase;
  late IProductsListRepository repository;

  final List<Product> tProductsList = [
    Product(123456, 'Product 1', 100.00),
    Product(1234567, 'Product 2', 50.00),
  ];
  final List<Product> tProductsListEmpty = [];
  final String tDeviceId = '1234567890';

  setUp(() {
    repository = ProductsRepositoryMock();
    usecase = GetListProductsUsecase(repository);
  });

  test('must get a list of products from repository', () async {
    when(() => repository.getProductsByDevice(tDeviceId))
        .thenAnswer((_) async => Right<Failure, List<Product>>(tProductsList));

    final result = await usecase(tDeviceId);
    expect(result, Right(tProductsList));
    verify(() => repository.getProductsByDevice(tDeviceId)).called(1);
  });
  test('must get a server failure from repository', () async {
    when(() => repository.getProductsByDevice(tDeviceId))
        .thenAnswer((_) async => Left<Failure, List<Product>>(ServerFailure()));

    final result = await usecase(tDeviceId);
    expect(result, Left(ServerFailure()));
    verify(() => repository.getProductsByDevice(tDeviceId)).called(1);
  });
  test('repository must receive a deviceId parameter when called', () async {
    when(() => repository.getProductsByDevice(tDeviceId))
        .thenAnswer((_) async => Left<Failure, List<Product>>(ServerFailure()));

    final result = await usecase(tDeviceId);
    expect(result, Left(ServerFailure()));
    var captured =
        verify(() => repository.getProductsByDevice(captureAny())).captured;
    expect(captured, isA<List<dynamic>>());
    expect(captured.length, 1);
    expect(captured.last, equals(tDeviceId));
  });
  test('repository must return a device id failure when called', () async {
    when(() => repository.getProductsByDevice('')).thenAnswer(
        (_) async => Left<Failure, List<Product>>(NoDeviceIdFailure()));

    final result = await usecase('');
    expect(result, Left(NoDeviceIdFailure()));

    verifyNever(() => repository.getProductsByDevice(captureAny()));
  });
  test('must get a list of without any products', () async {
    when(() => repository.getProductsByDevice(tDeviceId)).thenAnswer(
        (_) async => Right<Failure, List<Product>>(tProductsListEmpty));

    final result = await usecase(tDeviceId);
    expect(result, Left(NoProductsFailure()));

    verify(() => repository.getProductsByDevice(tDeviceId)).called(1);
  });
}
