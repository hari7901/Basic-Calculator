import'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget{
  const AnimatedLogo({super.key, required Animation<double> animation})
      : super(listenable: animation);

  static final _OpacityTween = Tween<double>(begin: 01, end: 1);
  static final _sizeTween = Tween<double>(begin: 50, end: 250);
  @override
  Widget build(BuildContext context){
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        opacity: _OpacityTween.evaluate(animation),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: const FlutterLogo(),
        ),
      ),

    );
  }
}

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyLogo();
}

class _MyLogo extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);
}
