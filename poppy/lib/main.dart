import 'package:flutter/material.dart';
import 'package:poppy/shared/styles/custom_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poppy',
      theme: ThemeData(
        primarySwatch: CustomColors.PRIMARY_COLOR_SWATCH,
        primaryColor: CustomColors.PRIMARY_COLOR,
        primaryColorLight: CustomColors.PRIMARY_COLOR_LIGHT,
        primaryColorDark: CustomColors.PRIMARY_COLOR_DARK,
      ),
      home: MyHomePage(title: 'Poppy'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center());
  }
}
