import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/firebase_options.dart';
import 'package:for_ocr_practice/router/ocr_router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: OcrApp(),
    ),
  );
}

class OcrApp extends ConsumerWidget {
  const OcrApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(routerDelegate: OcrRouterDelegate(ref)),
    );
  }
}
