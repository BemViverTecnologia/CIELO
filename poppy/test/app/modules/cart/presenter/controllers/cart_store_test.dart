import 'package:flutter_test/flutter_test.dart';
import 'package:poppy/app/modules/cart/presenter/controllers/cart_store.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';

main() {
  late CartStore store;
  var total;

  setUp(() {
    store = CartStore();
    total = 0.00;
  });

  final product1 = Product(1234, 'Produto 1', 1234);
  final product2 = Product(1234, 'Produto 2', 1234);

  _calculateTotal(List<Product> products) {
    for (var item in store.state) {
      total += item.price;
    }
  }

  test('must return a cart without any products', () {
    expect(store.state.length, 0);
    expect(store.total, total);
  });
  test('must add a product in cart ', () {
    store.addProduct(product1);

    _calculateTotal(store.state);

    expect(store.state.length, 1);
    expect(store.total, total);
  });
  test('mustn\'t add a same product in cart', () {
    store.addProduct(product1);
    store.addProduct(product1);

    _calculateTotal(store.state);

    expect(store.state.length, 1);
    expect(store.total, total);
  });
  test('must add a second product in cart', () {
    store.addProduct(product1);
    store.addProduct(product2);

    _calculateTotal(store.state);

    expect(store.state.length, 2);
    expect(store.total, total);
  });
  test('must remove product in cart', () {
    store.addProduct(product1);
    store.addProduct(product2);

    store.removeProduct(product1);

    _calculateTotal(store.state);

    expect(store.state.length, 1);
    expect(store.total, total);
  });
  test('mustn\'t remove a product that isn\'t in the cart', () {
    store.removeProduct(product2);

    _calculateTotal(store.state);

    expect(store.state.length, 0);
    expect(store.total, total);
  });
}
