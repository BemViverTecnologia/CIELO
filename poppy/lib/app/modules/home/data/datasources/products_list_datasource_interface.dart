import 'package:poppy/app/modules/home/domain/models/product_model.dart';

abstract class IProductsListDatasource {
  Future<List<Product>> getProductsByDevice(String deviceId);
}
