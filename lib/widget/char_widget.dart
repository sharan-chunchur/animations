import 'package:flutter/material.dart';

class CharWidget extends StatefulWidget {
  final String char;
  final bool isCharDone;

  const CharWidget({super.key, required this.char, required this.isCharDone});

  @override
  State<CharWidget> createState() => _CharWidgetState();
}

class _CharWidgetState extends State<CharWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;


  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _animation = Tween<double>(
      begin: 10,
      end: 0,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _colorAnimation = ColorTween(begin: Colors.red.shade50, end: Colors.red)
        .animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Transform.translate(
      offset: Offset(0, _animation.value),
      child: Text(
        widget.char,
        style: TextStyle(
            fontSize:  50,
            color: _colorAnimation.value,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
