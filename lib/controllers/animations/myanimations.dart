import 'package:flutter/material.dart';

import 'do_not_interfere/controlled_animation.dart';
import 'do_not_interfere/multi_track_tween.dart';

class SimpleFadeAnimation extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  const SimpleFadeAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 3500),
    this.curve = Curves.bounceIn,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      curve: curve,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (BuildContext context, double val, Widget? child) {
        return Opacity(
          opacity: val,
          child: child,
        );
      },
      child: child,
    );
  }
}

class SimpleTransformAnimation extends StatelessWidget {
  final double delayInMilliSeconds;
  final Widget child;
  final double xBegin;
  final double xEnd;
  final double yBegin;
  final Curve curveX;
  final double yEnd;
  final Duration xDuration;
  final Duration yDuration;
  final Curve curveY;

  const SimpleTransformAnimation({
    this.delayInMilliSeconds = 500.0,
    required this.child,
    this.xBegin = -10,
    this.xEnd = 0,
    this.yBegin = -10,
    this.yEnd = 0,
    this.xDuration = const Duration(milliseconds: 500),
    this.yDuration = const Duration(milliseconds: 500),
    this.curveX = Curves.linear,
    this.curveY = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final tween =
        MultiTrackTween([Track("translateY").add(yDuration, Tween(begin: yBegin, end: yEnd), curve: curveX), Track("translateX").add(xDuration, Tween(begin: xBegin, end: xEnd), curve: curveY)]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delayInMilliSeconds.round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, Map<String, dynamic> animation) => Transform.translate(
        offset: Offset(animation['translateX'], animation["translateY"]),
        child: child,
      ),
    );
  }
}

class ProFadeAndTransformAnimation extends StatelessWidget {
  final double delayInMilliSeconds;
  final Widget child;
  final double xBegin;
  final double xEnd;
  final double yBegin;
  final double yEnd;
  final Duration xDuration;
  final Duration yDuration;
  final Curve curveX;
  final Curve curveY;
  final double opacityBegin;
  final double opacityEnd;
  final Duration opacityDuration;
  final Curve curveOpacity;

  const ProFadeAndTransformAnimation({
    this.delayInMilliSeconds = 500.0,
    required this.child,
    this.xBegin = -10,
    this.xEnd = 0,
    this.yBegin = -10,
    this.yEnd = 0,
    this.xDuration = const Duration(milliseconds: 500),
    this.yDuration = const Duration(milliseconds: 500),
    this.opacityBegin = 0,
    this.opacityEnd = 1,
    this.opacityDuration = const Duration(milliseconds: 500),
    this.curveX = Curves.linear,
    this.curveY = Curves.linear,
    this.curveOpacity = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(opacityDuration, Tween(begin: opacityBegin, end: opacityEnd), curve: curveOpacity),
      Track("translateX").add(xDuration, Tween(begin: xBegin, end: xEnd), curve: curveX),
      Track("translateY").add(yDuration, Tween(begin: yBegin, end: yEnd), curve: curveY)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delayInMilliSeconds.round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, Map<String, dynamic> animation) => Opacity(
          opacity: animation["opacity"],
          child: Transform.translate(
            offset: Offset(animation['translateX'], animation["translateY"]),
            child: child,
          )),
    );
  }
}
