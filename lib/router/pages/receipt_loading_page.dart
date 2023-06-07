import 'package:flutter/material.dart';
import 'package:for_ocr_practice/camera/view/receipt_loading_screen.dart';

class ReceiptLoadingPage extends Page {
  static const pageName = 'ReceiptLoading';
  const ReceiptLoadingPage()
      : super(key: const ValueKey(pageName), name: pageName);

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const ReceiptLoadingScreen(),
    );
  }
}
