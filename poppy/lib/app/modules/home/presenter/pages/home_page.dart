import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/modules/cart/presenter/controllers/cart_store.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/presenter/controllers/device_id_store.dart';
import 'package:poppy/app/modules/home/presenter/controllers/list_products_store.dart';
import 'package:poppy/app/modules/home/presenter/widgets/app_bar.dart';
import 'package:poppy/app/modules/home/presenter/widgets/product_card.dart';
import 'package:poppy/core/widgets/buttons/customButtonElaveted.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DeviceIdStore _deviceIdStore = Modular.get<DeviceIdStore>();
  ListProductsStore _listProductsStore = Modular.get<ListProductsStore>();
  CartStore store = Modular.get<CartStore>();

  @override
  void initState() {
    super.initState();
    _deviceIdStore.getDeviceId();
    _deviceIdStore.observer(onState: (state) {
      _listProductsStore.getListProductsByDeviceId(state);
    });
    // store.getListProductsByDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle _buttonStyleYes = ElevatedButton.styleFrom(
      primary: Colors.black,
    );

    return Scaffold(
      appBar: const PoppyAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ScopedBuilder(
              store: _listProductsStore,
              onLoading: (_) => CircularProgressIndicator(),
              onError: (_, error) => Text('Error: $error'),
              onState: (_, List<Product> state) => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => showModalBottomSheet<void>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20)),
                    ),
                    enableDrag: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: 170,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: const Text(
                                  'Deseja adicionar o produto ao carrinho?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  state[index].description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomElevatedButton(
                                    title: 'Cancelar',
                                    color: Colors.red,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                  CustomElevatedButton(
                                    title: 'Continuar',
                                    onTap: () {
                                      store.addProduct(state[index]);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  child: ProductCard(
                    product: state[index],
                  ),
                ),
                itemCount: state.length,
                padding: EdgeInsets.all(12),
              ),
            ),
          ),
          RxBuilder(
            builder: (_) => Text(
              "Device id: ${_deviceIdStore.state}",
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}


// Column(
//         children: [
//           Container(
//             child: Center(
//               child: ScopedBuilder(
//                 store: _listProductsStore,
//                 onLoading: (_) => CircularProgressIndicator(),
//                 onError: (_, error) => Text('Error: $error'),
//                 onState: (_, List<Product> state) => Text(state[0].description),
//               ),
//             ),
//           ),
//           Container(
//               child: RxBuilder(
//             builder: (_) => Text("Device id: ${_deviceIdStore.state}"),
//           ))
//         ],
//       ),