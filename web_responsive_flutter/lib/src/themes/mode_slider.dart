import 'package:flutter/material.dart';

class ModeSlider extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ModeSlider(
      {super.key, required this.isDarkMode, required this.onChanged});

  @override
  ModeSliderState createState() => ModeSliderState();
}

class ModeSliderState extends State<ModeSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: widget.isDarkMode ? Colors.black : Colors.yellow,
        inactiveTrackColor: widget.isDarkMode ? Colors.grey : Colors.orange,
        thumbColor: widget.isDarkMode ? Colors.black : Colors.yellow,
        overlayColor: widget.isDarkMode ? Colors.black54 : Colors.yellowAccent,
      ),
      child: Slider(
        value: widget.isDarkMode ? 1 : 0,
        min: 0,
        max: 1,
        divisions: 1,
        label: widget.isDarkMode ? 'Dark Mode' : 'Light Mode',
        onChanged: (value) {
          widget.onChanged(value == 1);
        },
      ),
    );
  }
}
