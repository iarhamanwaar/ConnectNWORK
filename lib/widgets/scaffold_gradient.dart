import 'package:flutter/material.dart';

class ScaffoldGradient extends StatelessWidget {
  final Widget child;

  const ScaffoldGradient({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCFECF8),
            Color(0xFFFFFCF2),
          ],
          stops: [
            0.01,
            0.41,
          ],
        ),
      ),
      child: child,
    );
  }
}
