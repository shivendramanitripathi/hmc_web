import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String imageUrl;
  final List<String> actionImages;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.actionImages,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isExpanded = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CompositedTransformTarget(
        link: _layerLink,
        child: IconButton(
          icon: Image.asset(AppImages.menuIconsDot, width: 20, height: 20),
          onPressed: () {
            setState(() {
              if (isExpanded) {
                _overlayEntry?.remove();
              } else {
                _showDropdown(context);
              }
              isExpanded = !isExpanded;
            });
          },
        ),
      ),
      title: Row(
        children: [
          Image.network(
            widget.imageUrl,
            width: 120,
            height: 25,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      actions: widget.actionImages
          .map((imagePath) => IconButton(
        icon: Image.network(
          imagePath,
          width: 20,
          height: 20,
        ),
        onPressed: () {},
      ))
          .toList(),
    );
  }

  void _showDropdown(BuildContext context) {
    final overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 335,
        top: kToolbarHeight + 8,
        left: 0,
        child: Material(
          elevation: 4,
          child: Container(
            height: 488,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Applications',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        _overlayEntry?.remove();
                        setState(() => isExpanded = false);
                      },
                      child: const Text(
                        'View All',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      final titles = [
                        'Inbound Logistics',
                        'Employee Compliance Application',
                        'HIRA system',
                        'Injury Identification System',
                        'Tag Redressal System',
                        'Kaizen System',
                        'One Point Lesson',
                        'Quality Alert System',
                        'SOP System(SS & SC Function)',
                        'SOP System(Project Engineering Department)',
                      ];

                      final imagePaths = [
                        'assets/images/inbound_logistics.png',
                        'assets/images/employee_compliance.png',
                        'assets/images/hira.png',
                        'assets/images/injury_identification.png',
                        'assets/images/tag_redressal.png',
                        'assets/images/kaizen.png',
                        'assets/images/opl.png',
                        'assets/images/quality_alert.png',
                        'assets/images/sop1.png',
                        'assets/images/sop2.png',
                      ];

                      return ListTile(
                        leading: Image.asset(imagePaths[index], width: 24, height: 24),
                        title: Text(titles[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);

    Future.delayed(Duration(seconds: 5), () {
      _overlayEntry?.remove();
      setState(() => isExpanded = false);
    });
  }
}
