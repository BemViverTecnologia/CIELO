import 'package:poppy/app/domain/models/product_model.dart';

abstract class IProductsListDatasource {
  Future<List<Product>> getProductsByDevice(String deviceId);
}
