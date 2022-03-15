import 'dart:async';

import 'package:flutter/material.dart';

class Implicit extends StatefulWidget {
  const Implicit({Key? key}) : super(key: key);

  @override
  _ImplicitState createState() => _ImplicitState();
}

class _ImplicitState extends State<Implicit> {
  double _width = 50;
  Color _color = Colors.blue;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      //first time build is called, we delay the size change
      //so the code is executed after the build is done
      //and we can see the changes (animation triggered )
      firstTime = false;
      Future.delayed(Duration.zero, changeSize);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animation'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('width: $_width'),
              AnimatedContainer(
                width: _width,
                height: 50,
                color: _color,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeInOut,
                onEnd: () {
                  changeSize(); //change size again after animation is done
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeSize() {
    setState(() {
      _width = _width == 50 ? 200 : 50;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  //List
  //AnimatedOpacity
  //AnimatedContainer
  //AnimatedPadding
  //AnimatedPositioned
  //AnimatedSwitcher
  //AnimatedDefaultTextStyle
}
