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
  State<FlutterHighlight> createState() => FlutterHighlightState();
}

@visibleForTesting
class FlutterHighlightState extends State<FlutterHighlight>
    with SingleTickerProviderStateMixin {
  @visibleForTesting
  late AnimationController animationController;
  int _repeatCount = 0;

  void statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _repeatCount++;
      if (_repeatCount < widget.blinkNumber) {
        animationController.forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: widget.minOpacity,
      upperBound: widget.maxOpacity,
    )..addStatusListener(statusListener);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return _FlutterHighlightRender(
          percent: animationController.value,
          color: widget.color ?? Theme.of(context).colorScheme.surface,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
