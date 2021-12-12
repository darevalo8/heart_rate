import 'package:flutter/material.dart';

class ButtomWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Color color;
  final Color? textColor;
  final bool colorPurple;
  final bool shadow;
  final String text;

  const ButtomWidget({
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.textColor,
    this.colorPurple = false,
    this.shadow = false,
  });
  @override
  Widget build(BuildContext context) {
    final elevatedButtonStyle = ElevatedButton.styleFrom(
        
        primary: this.color,
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
        shadowColor: this.color,
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    return ElevatedButton(
      onPressed: this.onPressed,
      child: Text(
        this.text,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
      style: elevatedButtonStyle,
    );
  }
}
