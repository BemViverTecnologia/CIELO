//  app_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poppy/shared/styles/custom_colors.dart';

class AppWidget extends StatelessWidget {
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
      initialRoute: '/',
    ).modular();
  }
}
