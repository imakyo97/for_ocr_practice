import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/camera_provider.dart';
import 'package:for_ocr_practice/overlay_indicator/overlay_indicator.dart';
import 'package:for_ocr_practice/router/pages/read_result_page.dart';
import 'package:for_ocr_practice/router/pages/receipt_loading_page.dart';
import 'package:for_ocr_practice/router/pages_management.dart';

class OcrRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final WidgetRef _ref;

  OcrRouterDelegate(this._ref) {
    _ref.listen(pagesManagementProvider, (previous, next) => notifyListeners());
    _ref.listen(shouldDisplayOverlayIndicatorProvider,
        (previous, next) => notifyListeners());
  }

  @override
  Widget build(BuildContext context) {
    final pagesManagement = _ref.watch(pagesManagementProvider);
    final shouldDisplayOverlayIndicator =
        _ref.watch(shouldDisplayOverlayIndicatorProvider);
    return Stack(
      children: [
        Navigator(
          key: navigatorKey,
          pages: [
            const ReceiptLoadingPage(),
            if (pagesManagement.shouldDisplayReadResult) const ReadResultPage(),
          ],
          onPopPage: (route, result) {
            final pagesManagementNotifier =
                _ref.read(pagesManagementProvider.notifier);
            if (!route.didPop(result)) return false;
            if (route.settings.name == ReadResultPage.pageName) {
              pagesManagementNotifier.closeReadResult();
              _ref.read(cameraControllerProvider)?.pausePreview();
            }
            return true;
          },
        ),
        if (shouldDisplayOverlayIndicator) const OverlayIndicator(),
      ],
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
