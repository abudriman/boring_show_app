import './keyboard_button.dart';
import 'package:flutter/material.dart';

class WordleKeyboard extends StatelessWidget {
  const WordleKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            KeyboardButton('Q'),
            KeyboardButton('W'),
            KeyboardButton('E'),
            KeyboardButton('R'),
            KeyboardButton('T'),
            KeyboardButton('Y'),
            KeyboardButton('U'),
            KeyboardButton('I'),
            KeyboardButton('O'),
            KeyboardButton('P'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            KeyboardButton('A'),
            KeyboardButton('S'),
            KeyboardButton('D'),
            KeyboardButton('F'),
            KeyboardButton('G'),
            KeyboardButton('H'),
            KeyboardButton('J'),
            KeyboardButton('K'),
            KeyboardButton('L'),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            KeyboardButton('ent'),
            KeyboardButton('Z'),
            KeyboardButton('X'),
            KeyboardButton('C'),
            KeyboardButton('V'),
            KeyboardButton('B'),
            KeyboardButton('N'),
            KeyboardButton('M'),
            KeyboardButton('del'),
          ],
        ),
      ],
    );
  }
}
