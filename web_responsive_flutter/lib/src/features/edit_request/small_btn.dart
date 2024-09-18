import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final EdgeInsets padding;

  const CustomSmallButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color = Colors.blue,
    this.width = 187,
    this.height = 41,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(width, height),
        padding: padding,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
