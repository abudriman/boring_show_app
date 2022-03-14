import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../word_input_state.dart';
import 'package:boring_show_app/wordle/controllers/wordle_controller.dart';

class KeyboardButton extends StatelessWidget {
  final String char;

  const KeyboardButton(
    this.char, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordleController>(
        init: Get.find<WordleController>(tag: 'wordle'),
        builder: (controller) {
          if (char == 'del') {
            return GestureDetector(
              onTap: () => controller.deleteChar(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 2.0),
                  child: Container(
                    width: 10.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Icon(Icons.backspace),
                    ),
                  )),
            );
          } else if (char == 'ent') {
            return GestureDetector(
              onTap: () {
                showDialog(controller.evaluate());
                showAnswer(
                    !controller.isWinning.value && controller.isFinish.value,
                    controller.currentWord.value);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
                child: Container(
                  width: 10.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(child: Text('Enter')),
                ),
              ),
            );
          }
          return GestureDetector(
            onTap: () => controller.inputChar(char),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
              child: Container(
                width: 7.w,
                height: 8.h,
                decoration: BoxDecoration(
                  // ignore: invalid_use_of_protected_member
                  color: keyboardColor(controller.keyboard.value[char]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text(char)),
              ),
            ),
          );
        });
  }

  Color keyboardColor(state) {
    switch (state) {
      case WordInputState.correct:
        return const Color(0xff538D4E);

      case WordInputState.incorrect:
        return Colors.grey.shade800;

      case WordInputState.misplace:
        return const Color(0xffB59F3B);

      default:
        return Colors.grey;
    }
  }

  void showDialog(bool show) {
    if (show) {
      Get.defaultDialog(
        title: 'Oops!',
        content: const Text('The word is not in the dictionary.'),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    }
  }

  void showAnswer(bool isFinish, String answer) {
    if (isFinish) {
      Get.defaultDialog(
        title: 'Try again next time!',
        content: Text('The answer is $answer'),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      );
    }
  }
}
