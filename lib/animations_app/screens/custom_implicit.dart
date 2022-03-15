import 'package:flutter/material.dart';

class CustomImplicit extends StatefulWidget {
  const CustomImplicit({Key? key}) : super(key: key);

  @override
  _CustomImplicitState createState() => _CustomImplicitState();
}

class _CustomImplicitState extends State<CustomImplicit> {
  double _begin = 0.5;
  double _end = 1.0;
  @override
  Widget build(BuildContext context) {
    //animating icon with Tween
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Implicit Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: _begin, end: _end),
          duration: const Duration(seconds: 1),
          builder: (context, double value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: const Icon(
            Icons.accessible_forward_sharp,
            size: 150,
          ),
          onEnd: () {
            changeSize();
          },
        ),
      ),
    );
  }

  void changeSize() {
    //swap the begin and end values
    setState(() {
      _begin = _end;
      _end = _begin == 0.5 ? 1.0 : 0.5;
    });
  }
}
