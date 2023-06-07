import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class PagesManagement {
  final bool shouldDisplayReadResult;

  const PagesManagement({this.shouldDisplayReadResult = false});

  PagesManagement copyWith({bool? shouldDisplayReadResult}) {
    return PagesManagement(
      shouldDisplayReadResult:
          shouldDisplayReadResult ?? this.shouldDisplayReadResult,
    );
  }
}

class PagesManagementNotifier extends StateNotifier<PagesManagement> {
  PagesManagementNotifier(super.state);

  void openReadResult() {
    state = state.copyWith(shouldDisplayReadResult: true);
  }

  void closeReadResult() {
    state = state.copyWith(shouldDisplayReadResult: false);
  }
}

final pagesManagementProvider =
    StateNotifierProvider<PagesManagementNotifier, PagesManagement>((ref) {
  return PagesManagementNotifier(const PagesManagement());
});
