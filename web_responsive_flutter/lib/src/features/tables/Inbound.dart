import 'package:flutter/material.dart';
import 'InboundDesktop.dart';
import 'InboundMobile.dart';

class Inbound extends StatefulWidget {
  const Inbound({super.key});

  @override
  _InboundState createState() => _InboundState();
}

class _InboundState extends State<Inbound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              return InboundDesktop();
            } else {
              return InboundMobile();
            }
          },
        ),
      ),
    );
  }
}