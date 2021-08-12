import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  var orderId = 'orderId';
  var paymentResponse = 'aguardando...';

  Future<void> _createOrder() async {
    try {
      final result =
          await platform.invokeMethod('createOrder', {'ref': 'Pedido teste'});
      print('Pedido Criado: $result');

      Future.delayed(Duration(milliseconds: 2000)).then((value) async {
        var orderResult = await platform.invokeMethod('getOrder');

        if (orderResult is String) {
          print('orderResult: $orderResult');
          setState(() {
            orderId = orderResult;
          });
        }
      });
    } on PlatformException catch (e) {
      print('erro ao criar pedido: $e');
    }
  }

  Future<void> _addItem() async {
    try {
      final result = await platform.invokeMethod('addItem');
      print('adicionado item ao pedido: $result');
    } on PlatformException catch (e) {
      print('erro ao ao tentar adicionar produtos: $e');
    }
  }

  Future<void> _closeOrder() async {
    try {
      final result = await platform.invokeMethod('closeOrder');
      print('pedido fechado: $result');
    } on PlatformException catch (e) {
      print('erro ao ao tentar fechar pedido: $e');
    }
  }

  Future<void> _checkPaymentResponse() async {
    try {
      final result = await platform.invokeMethod('checkPayment');

      if (result != 'aguardando...') {
        setState(() {
          paymentResponse = result;
        });
      }
      return;
    } on PlatformException catch (e) {
      print('erro ao ao tentar fechar pedido: $e');
    }
  }

  Future<void> _requestPayment() async {
    setState(() {
      paymentResponse = 'aguardando...';
    });
    try {
      final result = await platform.invokeMethod('requestPayment');
      print('pedido fechado: $result');

      while (paymentResponse == 'aguardando...') {
        await _checkPaymentResponse();
      }
    } on PlatformException catch (e) {
      print('erro ao ao tentar fechar pedido: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Create Order'),
              onPressed: _createOrder,
            ),
            Text(orderId),
            ElevatedButton(
              child: Text('Add Item'),
              onPressed: _addItem,
            ),
            ElevatedButton(
              child: Text('Close Order'),
              onPressed: _closeOrder,
            ),
            ElevatedButton(
              child: Text('Request Payment'),
              onPressed: _requestPayment,
            ),
            Text(paymentResponse),
          ],
        ),
      ),
    );
  }
}
