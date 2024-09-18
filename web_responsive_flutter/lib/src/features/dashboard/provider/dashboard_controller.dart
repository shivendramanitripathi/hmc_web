import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';

class DashBoardController with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;

  int get selectedIndex => _selectedIndex;
  bool get isDrawerOpen => _isDrawerOpen;

  final List<MenuItemData> menuItems = [
    const MenuItemData(title: "Dashboard", icon: Icons.dashboard),
    const MenuItemData(title: "Reports", icon: Icons.insert_chart),
    const MenuItemData(title: "Location", icon: Icons.location_on_rounded),
    const MenuItemData(title: "Edit Request", icon: Icons.table_view_outlined),
  ];

  void handleMenuItemSelected(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        GoRouter.of(context).go('/mainScreen');
        break;
      case 1:
        GoRouter.of(context).go('/requests');
        break;
      case 2:
        GoRouter.of(context).go('/locations');
        break;
      case 3:
        GoRouter.of(context).go('/editrequest');
      default:
        break;
    }
  }

  void toggleDrawer() {
    _isDrawerOpen = !_isDrawerOpen;
    notifyListeners();
  }
}
