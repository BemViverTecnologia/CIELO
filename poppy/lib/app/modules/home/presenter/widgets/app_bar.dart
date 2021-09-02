import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:poppy/app/modules/cart/presenter/controllers/cart_store.dart';
import 'package:poppy/app/modules/home/domain/models/product_model.dart';
import 'package:poppy/shared/constants/strings.dart';

class PoppyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PoppyAppBar({Key? key}) : super(key: key);

  @override
  _PoppyAppBarState createState() => _PoppyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _PoppyAppBarState extends State<PoppyAppBar> {
  CartStore store = Modular.get<CartStore>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(Strings.TITLE),
        centerTitle: true,
        leading: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              ScopedBuilder(
                store: store,
                onState: (_, List<Product> state) {
                  return state.length > 0
                      ? Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Text(
                              state.length.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )),
                          ),
                        )
                      : Container();
                },
              )
            ],
          ),
        ));
  }
}
