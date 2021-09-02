import 'dart:math';

import 'package:flutter/material.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/shared/utils/formatters/formatMoney.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  static List<Color> colors = [
    Colors.black,
    Colors.amber,
    Colors.red,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          padding: EdgeInsets.all(12),
          constraints: BoxConstraints(maxHeight: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                    color: colors[Random().nextInt(colors.length)],
                    borderRadius: BorderRadius.circular(20)),
              ),
              Expanded(child: Center(child: Text(product.description))),
              Text(
                FormatMoney.formatToMoney(product.price),
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
