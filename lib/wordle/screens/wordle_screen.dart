import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/wordle_controller.dart';
import '../widgets/widgets.dart';
import '../word_input_state.dart';

class WordleScreen extends StatelessWidget {
  const WordleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) => Scaffold(
            appBar: AppBar(
              title: const Text('Wordle'),
              centerTitle: true,
            ),
            body: GetBuilder<WordleController>(
                init: Get.put<WordleController>(WordleController(),
                    tag: 'wordle'),
                builder: (_) => Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ..._.guessHistory.value
                                .map(
                                  (element) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      WordInput(element[0]['char'],
                                          element[0]['state']),
                                      WordInput(element[1]['char'],
                                          element[1]['state']),
                                      WordInput(element[2]['char'],
                                          element[2]['state']),
                                      WordInput(element[3]['char'],
                                          element[3]['state']),
                                      WordInput(element[4]['char'],
                                          element[4]['state']),
                                    ],
                                  ),
                                )
                                .toList(),
                            _.isFinish.value
                                ? ElevatedButton(
                                    onPressed: () => _.reset(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Text('Play again'),
                                        Icon(Icons.refresh)
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: WordleKeyboard())
                      ],
                    )),
          )),
    );
  }
}

class WordInput extends StatelessWidget {
  final WordInputState state;
  final String char;
  const WordInput(this.char, this.state, [Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? _color;
    switch (state) {
      case WordInputState.correct:
        _color = const Color(0xff538D4E);
        break;
      case WordInputState.incorrect:
        _color = Colors.grey[800];
        break;
      case WordInputState.misplace:
        _color = const Color(0xffB59F3B);
        break;
      default:
        _color = Colors.black;
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 15.w,
        height: 15.w,
        color: _color,
        child: Center(
            child: Text(char,
                style: const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
