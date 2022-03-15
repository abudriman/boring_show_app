import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({Key? key}) : super(key: key);

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flip Animation'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(_controller.value * pi),
                  child: _controller.value < 0.5 ? FrontWidget() : BackWidget(),
                );
              },
            ),
          ),
          Align(
              alignment: const Alignment(0, 0.5),
              child: ElevatedButton(
                  // ignore: avoid_print
                  onPressed: () {
                    _controller.addListener(() {
                      print(_controller.value);
                    });
                    if (_controller.value < 0.5) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  },
                  child: const Text('do the flip!'))),
        ],
      ),
    );
  }
}

class FrontWidget extends StatelessWidget {
  const FrontWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: 200,
      height: 300,
    );
  }
}

class BackWidget extends StatelessWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 200,
      height: 300,
    );
  }
}
