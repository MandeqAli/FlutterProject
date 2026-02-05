import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
  final Widget child;

  const CardBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
