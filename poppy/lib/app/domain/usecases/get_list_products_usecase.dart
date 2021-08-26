import 'package:poppy/app/domain/models/product.dart';
import 'package:poppy/app/domain/repositories/products_list_repository_interface.dart';
import 'package:poppy/core/erros/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:poppy/core/usecases/usecase.dart';

class GetListProductsUsecase implements Usecase<List<Product>, String> {
  final IProductsListRepository repository;

  GetListProductsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(String deviceId) async {
    final Either<Failure, List<Product>> res =
        await repository.getProductsByDevice(deviceId);

    return res.fold((l) => Left(l), (r) {
      if (r.length > 0) return Right(r);
      return Left(NoProductsFailure());
    });
  }
}
