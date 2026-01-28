import 'package:flutter/material.dart';

void showDraggableSheet(
  BuildContext context, {
  required Widget child,
  double initialSize = 0.35,
  double minSize = 0.25,
  double maxSize = 0.6,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: initialSize,
        minChildSize: minSize,
        maxChildSize: maxSize,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              controller: controller,
              child: child, // 👈 ANY UI
            ),
          );
        },
      );
    },
  );
}
