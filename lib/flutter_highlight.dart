import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'src/flutter_highlight_filter.dart';
part 'src/flutter_highlight_render.dart';

class FlutterHighlight extends StatefulWidget {
  /// Duration of the animation.
  final Duration duration;

  /// Number of times the animation goes forward and reverse.
  final int blinkNumber;

  /// Color of the highlight.
  final Color? color;

  /// Minimum highlight opacity.
  final double minOpacity;

  /// Maximum highlight opacity.
  final double maxOpacity;

  final Widget child;

  const FlutterHighlight({
    super.key,
    required this.duration,
    this.blinkNumber = 3,
    this.minOpacity = 0.0,
    this.maxOpacity = 0.6,
    this.color,
    required this.child,
  }) : assert(blinkNumber >= 1),
       assert(minOpacity >= 0.0),
       assert(maxOpacity <= 1.0);

  @override
  State<FlutterHighlight> createState() => _FlutterHighlightState();
}

class _FlutterHighlightState extends State<FlutterHighlight>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Future<void> _runAnimation() async {
    int count = 0;
    while (count < widget.blinkNumber) {
      count++;
      await _animationController.forward();
      await _animationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.minOpacity,
      upperBound: widget.maxOpacity,
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
          color: widget.color ?? Theme.of(context).colorScheme.surface,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
