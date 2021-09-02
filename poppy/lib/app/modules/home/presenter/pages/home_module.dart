// app_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datasource.dart';
import 'package:poppy/app/modules/home/data/datasources/device_id_datource_interface.dart';
import 'package:poppy/app/modules/home/data/datasources/products_list_datasource.dart';
import 'package:poppy/app/modules/home/data/datasources/products_list_datasource_interface.dart';
import 'package:poppy/app/modules/home/data/repositories/device_id_repository.dart';
import 'package:poppy/app/modules/home/data/repositories/products_list_repository.dart';
import 'package:poppy/app/modules/home/domain/repositories/device_id_repository_interface.dart';
import 'package:poppy/app/modules/home/domain/repositories/products_list_repository_interface.dart';
import 'package:poppy/app/modules/home/domain/usecases/get_device_id_usecase.dart';
import 'package:poppy/app/modules/home/domain/usecases/get_list_products_usecase.dart';
import 'package:poppy/app/modules/home/presenter/controllers/device_id_store.dart';
import 'package:poppy/app/modules/home/presenter/controllers/list_products_store.dart';
import 'package:poppy/core/services/android_service.dart';
import 'package:poppy/core/services/android_service_interface.dart';
import 'package:poppy/core/services/methodChannels/method_channels.dart';
import 'package:poppy/core/usecases/usecase.dart';
import 'package:poppy/core/usecases/usecase_without_input.dart';

import 'home_page.dart';

class HomeModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind<IProductsListDatasource>((i) => ProductsListDatasource(i())),
    Bind<IProductsListRepository>((i) => ProductsListRepository(i())),
    Bind<Usecase>((i) => GetListProductsUsecase(i())),
    Bind<ListProductsStore>((i) => ListProductsStore(i())),
    Bind<UsecaseWithoutInput>((i) => GetDeviceIdUsecase(i())),
    Bind<IDeviceIdRepository>((i) => DeviceIdRepository(i())),
    Bind<IDeviceIdDatasource>((i) => DeviceIdDatasource(i())),
    Bind<IAndroidService>((i) => AndroidService(MethodChannels.lioChannel)),
    Bind<GetDeviceIdUsecase>((i) => GetDeviceIdUsecase(i())),
    Bind<DeviceIdStore>((i) => DeviceIdStore(i())),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
  ];
}
