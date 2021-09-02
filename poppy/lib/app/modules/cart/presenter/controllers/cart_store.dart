import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/core/errors/failures.dart';

class CartStore extends NotifierStore<Failure, List<Product>> {
  CartStore() : super([]);

  void addProduct(Product product) {
    if (!state.contains(product)) {
      update([...state, product]);
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      List<Product> newList = List.from(state);
      if (newList.remove(product)) update(newList);
    }
  }

  double get total {
    var total = 0.0;
    for (var item in state) {
      total += item.price;
    }
    return total;
  }
}
