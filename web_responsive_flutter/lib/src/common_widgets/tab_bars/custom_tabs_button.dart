import 'package:flutter/material.dart';

import 'custom_bottom_tab_bars.dart';

class CustomBarsButton extends StatefulWidget {
  const CustomBarsButton({super.key});

  @override
  State<CustomBarsButton> createState() => _CustomButtomBarsButtonState();
}

class _CustomButtomBarsButtonState extends State<CustomBarsButton> {
  void _onHomePressed() {}

  void _onWorkOrdersPressed() {}

  void _onProductsPressed() {}

  void _onAccountPressed() {}

  void _onHelpPressed() {}

  @override
  Widget build(BuildContext context) {
    return CustomBottomBar(
      onHomePressed: () {
        setState(() {
          _onHomePressed();
        });
      },
      onWorkOrdersPressed: () {
        setState(() {
          _onWorkOrdersPressed();
        });
      },
      onProductsPressed: () {
        setState(() {
          _onProductsPressed();
        });
      },
      onAccountPressed: () {
        setState(() {
          _onAccountPressed();
        });
      },
      onHelpPressed: () {
        setState(() {
          _onHelpPressed();
        });
      },
    );
  }
}
