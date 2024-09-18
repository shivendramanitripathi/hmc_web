import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';

class DynamicButtonBar extends StatelessWidget {
  final List<ButtonConfig> buttons;
  final ValueChanged<int> onButtonPressed;
  final int selectedIndex;

  const DynamicButtonBar({
    super.key,
    required this.buttons,
    required this.onButtonPressed,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: _buildButtonRows(context),
      ),
    );
  }

  List<Widget> _buildButtonRows(BuildContext context) {
    List<Widget> rows = [];
    int buttonCount = buttons.length;

    for (int i = 0; i < buttonCount; i += 3) {
      List<Widget> rowChildren = buttons
          .sublist(i, i + 3 > buttonCount ? buttonCount : i + 3)
          .asMap()
          .entries
          .map((entry) {
        final index = i + entry.key;
        final config = entry.value;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: _buildButton(context, index, config),
          ),
        );
      }).toList();

      if (rowChildren.length == 2) {
        rowChildren = [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildButton(context, i, buttons[i]))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _buildButton(context, i + 1, buttons[i + 1]))),
        ];
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowChildren,
        ),
      );
    }

    return rows;
  }

  Widget _buildButton(BuildContext context, int index, ButtonConfig config) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onButtonPressed(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.highlightBorderColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              config.text,
              style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.primaryTextColor,
                  fontSize: 14),
            ),
            if (config.unit.isNotEmpty)
              Text(
                "(${config.unit})",
                style: TextStyle(
                    color:
                        isSelected ? Colors.white : AppColors.primaryTextColor,
                    fontSize: 12),
              ),
          ],
        ),
      ),
    );
  }
}

class ButtonConfig {
  final String text;
  final String unit;
  final IconData icon;

  ButtonConfig({
    required this.text,
    required this.unit,
    required this.icon,
  });
}
