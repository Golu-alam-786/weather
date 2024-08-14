import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(8),
      color: Colors.blue,
      child: const Center(
        child: Text(
          "© 2024 NewTok Technology Pvt Ltd",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
