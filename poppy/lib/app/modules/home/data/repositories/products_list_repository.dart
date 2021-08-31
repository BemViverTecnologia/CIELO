import 'package:dartz/dartz.dart';
import 'package:poppy/app/modules/home/data/datasources/products_list_datasource_interface.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/domain/repositories/products_list_repository_interface.dart';
import 'package:poppy/core/errors/exceptions.dart';
import 'package:poppy/core/errors/failures.dart';

class ProductsListRepository implements IProductsListRepository {
  final IProductsListDatasource datasource;

  ProductsListRepository(this.datasource);
  @override
  Future<Either<Failure, List<Product>>> getProductsByDevice(
      String deviceId) async {
    try {
      final result = await datasource.getProductsByDevice(deviceId);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
