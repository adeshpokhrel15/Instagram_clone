import 'package:flutter/material.dart';
import 'package:instagram_clone/constant/dimension/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minHeight > Dimension.webScreenSize) {
        return const Text("Web Screen");
      } else {
        return const Text("Mobile Screen");
      }
    });
  }
}
