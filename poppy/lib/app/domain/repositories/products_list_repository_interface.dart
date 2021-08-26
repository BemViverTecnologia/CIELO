import 'package:dartz/dartz.dart';
import 'package:poppy/app/domain/models/product.dart';
import 'package:poppy/core/erros/failures.dart';

abstract class IProductsListRepository {
  Future<Either<Failure, List<Product>>> getProductsByDevice(String deviceId);
}
