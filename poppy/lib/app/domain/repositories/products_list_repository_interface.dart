import 'package:dartz/dartz.dart';
import 'package:poppy/app/domain/models/product_model.dart';
import 'package:poppy/core/errors/failures.dart';

abstract class IProductsListRepository {
  Future<Either<Failure, List<Product>>> getProductsByDevice(String deviceId);
}
