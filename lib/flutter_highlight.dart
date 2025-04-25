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

  final Widget child;

  const FlutterHighlight({
    super.key,
    required this.duration,
    this.blinkNumber = 3,
    this.color,
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
      upperBound: 0.6,
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
