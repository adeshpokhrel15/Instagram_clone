import 'package:flutter/material.dart';
import 'package:instagram_clone/views/status%20check/status_check.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatusCheck(),
    );
  }
}
