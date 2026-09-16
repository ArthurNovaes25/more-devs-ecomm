import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

void showAppBottomSheet(BuildContext context) {
  showModalSheet(
    context: context,
    builder: (context) {
      return const Text('Teste');
    },
  );
}
