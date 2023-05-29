import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/read_result/model/full_text_provider.dart';

class ReadResultScreen extends ConsumerWidget {
  const ReadResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullTextNotifier = ref.watch(fullTextProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('読み取り結果')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Text(fullTextNotifier.state ?? '読み込んだ文字がありません。'),
          ),
        ),
      ),
    );
  }
}
