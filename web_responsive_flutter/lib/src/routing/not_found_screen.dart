import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/common_widgets/country/empty_placeholder_widget.dart';
import 'package:web_responsive_flutter/src/utils/string_hardcoded_ext.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmptyPlaceholderWidget(
        message: '404 - Page not found!'.hardcoded,
      ),
    );
  }
}
