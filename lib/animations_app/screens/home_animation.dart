import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAnimation extends StatelessWidget {
  const HomeAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          customButton('/implicit', 'Implicit Animation'),
          customButton('/custom_implicit', 'Custom Implicit Animation'),
          customButton('/explicit', 'Explicit Animation'),
          customButton('/custom_explicit', 'Custom Explicit Animation'),
          customButton('/flip_animation', 'Animated Builder (Flip)'),
        ],
      ),
    );
  }
}

Widget customButton(String route, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () => Get.toNamed(route),
      child: Text(text),
    ),
  );
}
