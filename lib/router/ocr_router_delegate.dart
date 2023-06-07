import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:for_ocr_practice/camera/model/camera_provider.dart';
import 'package:for_ocr_practice/router/pages/read_result_page.dart';
import 'package:for_ocr_practice/router/pages/receipt_loading_page.dart';
import 'package:for_ocr_practice/router/pages_management.dart';

class OcrRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final WidgetRef _ref;
  late final PagesManagement _pagesManagement;

  OcrRouterDelegate(this._ref) : _navigatorKey = GlobalKey<NavigatorState>() {
    _pagesManagement = _ref.watch(pagesManagementProvider);
    _ref.listen(pagesManagementProvider, (previous, next) => notifyListeners());
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        const ReceiptLoadingPage(),
        if (_pagesManagement.shouldDisplayReadResult) const ReadResultPage(),
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
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
