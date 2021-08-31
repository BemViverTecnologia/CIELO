import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poppy/app/data/datasources/endpoints/poppy_endpoints.dart';
import 'package:poppy/app/data/datasources/products_list_datasource.dart';
import 'package:poppy/app/data/datasources/products_list_datasource_interface.dart';
import 'package:poppy/app/domain/models/product_model.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/http_client/http_client_interface.dart';

import '../../../mocks/product_model_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

main() {
  late IProductsListDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = ProductsListDatasource(client);
  });

  final String tDeviceId = '123';
  final String tExpectedUrl = PoppyEndpoints.getProductsList(tDeviceId);

  test('must be call get method with correct url', () async {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: productListModelMock, statusCode: 200));
    await datasource.getProductsByDevice(tDeviceId);

    final captured = verify(() => client.get(captureAny())).captured;
    expect(captured.first, tExpectedUrl);
  });

  test('must return a list of products', () async {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: productListModelMock, statusCode: 200));
    final result = await datasource.getProductsByDevice(tDeviceId);

    expect(result, isA<List<Product>>());
    verify(() => client.get(captureAny())).called(1);
  });

  test('must throw a server exception', () async {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: 'nothing', statusCode: 400));
    final result = datasource.getProductsByDevice(tDeviceId);

    expect(() => result, throwsA(ServerException()));
    verify(() => client.get(captureAny())).called(1);
  });
}
