part of '../flutter_highlight.dart';

class _FlutterHighlightFilter extends RenderProxyBox {
  double _percent;
  Color _color;

  _FlutterHighlightFilter(this._percent, this._color);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) return;
    _percent = newValue;
    markNeedsPaint();
  }

  set color(Color newValue) {
    if (newValue == _color) return;
    _color = newValue;
    markNeedsPaint();
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      final double width = child!.size.width;
      final double height = child!.size.height;

      Rect rect;
      double dx, dy;

      dx = _offset(-width, width, 1);
      dy = 0.0;
      rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);

      layer ??= ShaderMaskLayer();
      layer!
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            _color.withValues(alpha: _percent),
            _color.withValues(alpha: _percent),
          ],
        ).createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcATop;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }
}
