import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';

import '../../../../../mocks/product_model_mock.dart';

main() {
  final Product tProduct = Product(123456, "Produto 1", 123.45);
  final tProductMap = {
    "id": 123456,
    "description": "Produto 1",
    "price": 123.45
  };
  test('should return a valid model', () {
    final Map<String, dynamic> json = jsonDecode(productModelMock);
    final result = Product.fromJson(json);

    expect(result, isA<Product>());
    expect(result, tProduct);
  });
  test('should return a valid json', () {
    final Map<String, dynamic> result = tProduct.toJson();

    expect(result, isA<Map<String, dynamic>>());
    expect(result, tProductMap);
  });
}
