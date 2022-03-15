import 'package:flutter/material.dart';

class Explicit extends StatefulWidget {
  const Explicit({Key? key}) : super(key: key);

  @override
  _ExplicitState createState() => _ExplicitState();
}

class _ExplicitState extends State<Explicit>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10000))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explicit Animation'),
      ),
      body: Center(
        child: RotationTransition(
          alignment: Alignment.center,
          turns: _animationController!,
          child: GestureDetector(
            onTap: () {
              if (_animationController!.isAnimating) {
                _animationController!.stop();
              } else {
                _animationController!.repeat();
              }
            },
            child: const Icon(
              Icons.ac_unit,
              color: Colors.white,
              size: 150,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
