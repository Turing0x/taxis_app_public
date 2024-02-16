import 'package:flutter/material.dart';

class SlideDown extends StatefulWidget {
  final Widget child;

  const SlideDown({super.key, required this.child});

  @override
  _SlideDownState createState() => _SlideDownState();
}

class _SlideDownState extends State<SlideDown> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetFloat;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetFloat = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 1)).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetFloat,
      child: widget.child,
    );
  }
}
