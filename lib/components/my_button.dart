import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.text, required this.onTap});
  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8.0)),
          padding: EdgeInsets.all(width * 0.05),
          margin: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Center(
            child: Text(text),
          )),
    );
  }
}
