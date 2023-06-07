import 'package:flutter/material.dart';
import 'package:for_ocr_practice/read_result/view/read_result_screen.dart';

class ReadResultPage extends Page {
  static const pageName = 'ReadResult';
  const ReadResultPage() : super(key: const ValueKey(pageName), name: pageName);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const ReadResultScreen(),
    );
  }
}
