import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

@immutable
class FlutterHighlight extends StatefulWidget {
  final Widget child;
  const FlutterHighlight({super.key, required this.child});

  @override
  State<FlutterHighlight> createState() => _FlutterHighlightState();
}

class _FlutterHighlightState extends State<FlutterHighlight> {
  @override
  Widget build(BuildContext context) {
    return _FlutterHighlightRender(child: widget.child);
  }
}

/// ----------------------------------------------------------------------------

@immutable
class _FlutterHighlightRender extends SingleChildRenderObjectWidget {
  const _FlutterHighlightRender({super.child});

  @override
  _FlutterHighlightFilter createRenderObject(BuildContext context) {
    return _FlutterHighlightFilter();
  }
}

/// ----------------------------------------------------------------------------

class _FlutterHighlightFilter extends RenderProxyBox {
  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

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
          colors: [Colors.yellow, Colors.yellow],
        ).createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }
}
