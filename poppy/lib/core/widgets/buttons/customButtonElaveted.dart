import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function()? onTap;
  const CustomElevatedButton(
      {Key? key, this.color = Colors.black, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
