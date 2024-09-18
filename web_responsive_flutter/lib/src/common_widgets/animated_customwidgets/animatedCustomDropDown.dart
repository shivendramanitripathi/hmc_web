import 'package:flutter/material.dart'
    show
        Animation,
        AnimationController,
        Border,
        BorderRadius,
        BoxConstraints,
        BoxDecoration,
        BuildContext,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        CurvedAnimation,
        Curves,
        EdgeInsets,
        GestureDetector,
        Icon,
        Icons,
        LayoutBuilder,
        ListTile,
        MainAxisAlignment,
        Row,
        SingleTickerProviderStateMixin,
        SizeTransition,
        State,
        StatefulWidget,
        Text,
        ValueChanged,
        Widget;

class AnimatedCustomDropdown extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onChanged;

  const AnimatedCustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  AnimatedCustomDropdownState createState() => AnimatedCustomDropdownState();
}

class AnimatedCustomDropdownState extends State<AnimatedCustomDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth * 0.8,
          ),
          child: GestureDetector(
            onTap: _toggleDropdown,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.selectedItem),
                      Icon(_isExpanded
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down),
                    ],
                  ),
                  SizeTransition(
                    sizeFactor: _animation,
                    child: Column(
                      children: widget.items.map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            widget.onChanged(item);
                            _toggleDropdown();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
