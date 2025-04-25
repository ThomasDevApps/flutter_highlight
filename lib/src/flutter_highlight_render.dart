part of '../flutter_highlight.dart';

class _FlutterHighlightRender extends SingleChildRenderObjectWidget {
  final double percent;
  final Color color;

  const _FlutterHighlightRender({
    required this.percent,
    required this.color,
    required super.child,
  });

  @override
  _FlutterHighlightFilter createRenderObject(BuildContext context) {
    return _FlutterHighlightFilter(percent, color);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _FlutterHighlightFilter filter,
  ) {
    filter.percent = percent;
    filter.color = color;
  }
}
