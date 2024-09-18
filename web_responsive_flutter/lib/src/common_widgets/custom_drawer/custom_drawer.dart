import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';

class SideMenuWidget extends StatefulWidget {
  final List<MenuItemData> menuItems;
  final Function(int) onItemSelected;
  final int selectedIndex;
  final double paddingVertical;
  final double paddingHorizontal;

  const SideMenuWidget({
    super.key,
    required this.menuItems,
    required this.onItemSelected,
    this.selectedIndex = 0,
    this.paddingVertical = 10,
    this.paddingHorizontal = 10,
  });

  @override
  _SideMenuWidgetState createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _handleItemSelection(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
      widget.onItemSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widget.paddingVertical,
        horizontal: widget.paddingHorizontal,
      ),
      color: const Color(0xFF171821),
      child: ListView.builder(
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          final menuItem = widget.menuItems[index];

          return MenuEntry(
            icon: menuItem.icon,
            title: menuItem.title,
            isSelected: isSelected,
            onTap: () => _handleItemSelection(index),
          );
        },
      ),
    );
  }
}

class MenuEntry extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuEntry({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: isSelected ? AppColors.selectionColor : Colors.transparent,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              child: Icon(
                icon,
                color: isSelected ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemData {
  final String title;
  final IconData icon;

  const MenuItemData({
    required this.title,
    required this.icon,
  });
}
