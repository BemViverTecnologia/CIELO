import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:poppy/app/data/datasources/endpoints/poppy_endpoints.dart';
import 'package:poppy/app/data/datasources/products_list_datasource_interface.dart';
import 'package:poppy/app/domain/models/product_model.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/http_client/http_client_interface.dart';

class ProductsListDatasource implements IProductsListDatasource {
  final HttpClient client;

  ProductsListDatasource(this.client);

  @override
  Future<List<Product>> getProductsByDevice(String deviceId) async {
    final response = await client.get(PoppyEndpoints.getProductsList(deviceId));
    try {
      if (response.statusCode == 200) {
        List<Product> listProducts = [];

        for (var item in jsonDecode(response.data)) {
          listProducts.add(Product.fromJson(item));
        }
        return listProducts;
      }

      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
