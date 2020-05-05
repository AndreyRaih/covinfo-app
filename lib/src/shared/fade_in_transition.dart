import 'package:flutter/widgets.dart';

class FadeInTransition extends StatefulWidget {
  Widget child;
  Duration duration;
  FadeInTransition({ @required this.child, this.duration });
  State<FadeInTransition> createState() => _FadeAnimation(child: child, duration: duration);
}

class _FadeAnimation extends State<FadeInTransition> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  Animation<double> _opacityAnimation;
  Widget child;
  Duration duration;
  
  _FadeAnimation({ @required this.child, this.duration });

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(begin: const Offset(0.05, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInExpo,
    ));
  }

  _playAnimation () {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _playAnimation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) { 
        return FadeTransition(opacity: _opacityAnimation, child: SlideTransition(
          position: _offsetAnimation,
          child: child
        ));
      })
    ;
  }
}