import 'package:flutter/material.dart';
import 'package:taxis_app_public/Core/widgets/menu_drawer.dart';

class MySlideTransition extends StatefulWidget {
  @override
  _MySlideTransitionState createState() => _MySlideTransitionState();
}

class _MySlideTransitionState extends State<MySlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: MDrawer()
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}