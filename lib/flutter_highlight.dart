import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

@immutable
class FlutterHighlight extends StatefulWidget {
  final Duration duration;
  final int blinkNumber;
  final Widget child;

  const FlutterHighlight({
    super.key,
    required this.duration,
    this.blinkNumber = 3,
    required this.child,
  });

  @override
  State<FlutterHighlight> createState() => _FlutterHighlightState();
}

class _FlutterHighlightState extends State<FlutterHighlight>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Future<void> _runAnimation() async {
    int count = 0;
    while (count < widget.blinkNumber) {
      await _animationController.forward();
      await _animationController.reverse();
      count++;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      upperBound: 0.8,
    );
    _runAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return _FlutterHighlightRender(
          percent: _animationController.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// ----------------------------------------------------------------------------

@immutable
class _FlutterHighlightRender extends SingleChildRenderObjectWidget {
  final double percent;

  const _FlutterHighlightRender({required this.percent, required super.child});

  @override
  _FlutterHighlightFilter createRenderObject(BuildContext context) {
    return _FlutterHighlightFilter(percent);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _FlutterHighlightFilter filter,
  ) {
    filter.percent = percent;
  }
}

/// ----------------------------------------------------------------------------

class _FlutterHighlightFilter extends RenderProxyBox {
  double _percent;

  _FlutterHighlightFilter(this._percent);

  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) return;
    _percent = newValue;
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
            Colors.yellow.withValues(alpha: _percent),
            Colors.yellow.withValues(alpha: _percent),
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
