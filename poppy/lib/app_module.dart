// app_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poppy/app/modules/cart/presenter/controllers/cart_store.dart';
import 'package:poppy/app/modules/home/presenter/pages/home_module.dart';
import 'package:poppy/core/http_client/aws_api.dart';
import 'package:poppy/core/http_client/http_client_interface.dart';
import 'package:poppy/core/services/android_service.dart';
import 'package:poppy/core/services/android_service_interface.dart';
import 'package:poppy/core/services/methodChannels/method_channels.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind<HttpClient>((i) => AwsApi()),
    Bind<IAndroidService>((i) => AndroidService(MethodChannels.lioChannel)),
    Bind<CartStore>((i) => CartStore(), isSingleton: true),
  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
  ];
}
