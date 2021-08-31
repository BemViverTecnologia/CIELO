import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/domain/usecases/get_list_products_usecase.dart';
import 'package:poppy/core/errors/failures.dart';

class ListProductsStore extends NotifierStore<Failure, List<Product>> {
  final GetListProductsUsecase _getListProductsUsecase;
  ListProductsStore(this._getListProductsUsecase) : super(<Product>[]);

  getListProductsByDeviceId(String deviceId) async {
    setLoading(true);

    final result = await _getListProductsUsecase(deviceId);

    result.fold((l) => setError(l), (r) => update(r));

    setLoading(false);
  }
}
