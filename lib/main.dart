import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_ocr_practice/firebase_options.dart';
import 'package:for_ocr_practice/ui/receipt_loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ReceiptLoadingScreen(),
    );
  }
}
