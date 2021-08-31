import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/app/modules/home/presenter/controllers/device_id_store.dart';
import 'package:poppy/app/modules/home/presenter/controllers/list_products_store.dart';
import 'package:poppy/app/modules/home/presenter/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DeviceIdStore _deviceIdStore = Modular.get<DeviceIdStore>();
  ListProductsStore _listProductsStore = Modular.get<ListProductsStore>();

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Poppy"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ScopedBuilder(
              store: _listProductsStore,
              onLoading: (_) => CircularProgressIndicator(),
              onError: (_, error) => Text('Error: $error'),
              onState: (_, List<Product> state) => ScopedBuilder(
                store: _listProductsStore,
                onLoading: (_) => CircularProgressIndicator(),
                onError: (_, error) => Text('Error: $error'),
                onState: (_, List<Product> state) => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (context, index) => ProductCard(
                    product: state[index],
                  ),
                  itemCount: state.length,
                  padding: EdgeInsets.all(12),
                ),
              ),
            ),
          ),
          Text(
            "Device id: ${_deviceIdStore.state}",
            style: TextStyle(fontSize: 12),
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