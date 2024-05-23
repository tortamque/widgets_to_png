import 'package:flutter/material.dart';

/// A widget that wraps another widget and allows it to be captured as an image.
///
/// The [WidgetToPng] widget should be used to wrap any widget that you want
/// to convert to an image. It uses a [GlobalKey] to identify the widget for
/// capturing.
///
/// Example usage:
/// ```dart
/// GlobalKey _globalKey = GlobalKey();
///
/// WidgetToPng(
///   keyToCapture: _globalKey,
///   child: YourWidgetHere(),
/// );
/// ```
class WidgetToPng extends StatelessWidget {
  const WidgetToPng({
    super.key,
    required this.keyToCapture,
    required this.child,
  });

  /// The key used to identify the widget to capture.
  final GlobalKey keyToCapture;

  /// The widget to be wrapped and captured.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: keyToCapture,
      child: child,
    );
  }
}
