// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../wordle_dictionary/wordle_dictionary.dart';
import '../word_input_state.dart';

class WordleController extends GetxController {
  final keyboard = {}.obs;
  final charCount = 0.obs;
  final guessCount = 0.obs;
  final currentWord = ''.obs;
  final isFinish = false.obs;
  final isWinning = false.obs;
  final guessHistory = Rx<List<List>>([]);
  final wordHistory = [].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadWordHistory();
    reset();
  }

  void inputChar(String char) {
    if (charCount < 5 && !isFinish.value) {
      guessHistory.value[guessCount.value].removeLast();
      guessHistory.value[guessCount.value].insert(
          charCount.value, {'char': char, 'state': WordInputState.notDecided});
      charCount.value++;
      update();
    }
  }

  void deleteChar() {
    if (charCount > 0 && !isFinish.value) {
      guessHistory.value[guessCount.value]
          .add({'char': '', 'state': WordInputState.notDecided});
      guessHistory.value[guessCount.value].removeAt(charCount.value - 1);
      charCount.value--;
      update();
    }
  }

  void _generateWord() {
    String current = wordlePossibleAnswers.keys
        .elementAt(math.Random().nextInt(wordlePossibleAnswers.length));
    if (wordHistory.length == wordlePossibleAnswers.length) {
      wordHistory.value.clear();
    }
    while (wordHistory.value.contains(current)) {
      current = wordlePossibleAnswers.keys
          .elementAt(math.Random().nextInt(wordlePossibleAnswers.length));
    }
    currentWord.value = current;
    log(currentWord.value);
    wordHistory.value.add(current);
    box.write('wordHistory', wordHistory.value);
  }

  bool evaluate() {
    if (guessCount.value > 6 || isFinish.value || charCount.value != 5) {
      return false;
    }
    String submit = '';
    for (int i = 0; i < 5; i++) {
      submit += guessHistory.value[guessCount.value][i]['char'];
    }
    submit = submit;
    if (wordlePossibleGuesses[submit.toLowerCase()] == 1 ||
        wordlePossibleAnswers[submit.toLowerCase()] == 1) {
      List answer = currentWord.value.toUpperCase().split('');

      for (int i = 0; i < 5; i++) {
        int index = answer.indexOf(submit[i]);
        if (index == -1) {
          keyboard.value[submit[i]] = WordInputState.incorrect;
          guessHistory.value[guessCount.value][i]['state'] =
              WordInputState.incorrect;
        } else {
          if (index == i) {
            keyboard.value[submit[i]] = WordInputState.correct;
            guessHistory.value[guessCount.value][i]['state'] =
                WordInputState.correct;
            answer.insert(index, '@');
            answer.removeAt(index + 1);
          } else {
            keyboard.value[submit[i]] = WordInputState.misplace;
            guessHistory.value[guessCount.value][i]['state'] =
                WordInputState.misplace;
            answer.insert(index, '@');
            answer.removeAt(index + 1);
          }
        }
      }
      guessCount.value++;
      charCount.value = 0;
      if (submit == currentWord.value.toUpperCase()) {
        isWinning.value = true;
        isFinish.value = true;
      }
      if (guessCount.value == 6) {
        isFinish.value = true;
      }
      update();
      return false;
    }
    return true;
  }

  void reset() {
    guessHistory.value.clear();
    for (int i = 0; i <= 5; i++) {
      guessHistory.value.add(List.generate(
          5, (index) => {'char': '', 'state': WordInputState.notDecided}));
    }
    charCount.value = 0;
    guessCount.value = 0;
    isFinish.value = false;
    isWinning.value = false;
    keyboard.value = {
      'Q': WordInputState.notDecided,
      'W': WordInputState.notDecided,
      'E': WordInputState.notDecided,
      'R': WordInputState.notDecided,
      'T': WordInputState.notDecided,
      'Y': WordInputState.notDecided,
      'U': WordInputState.notDecided,
      'I': WordInputState.notDecided,
      'O': WordInputState.notDecided,
      'P': WordInputState.notDecided,
      'A': WordInputState.notDecided,
      'S': WordInputState.notDecided,
      'D': WordInputState.notDecided,
      'F': WordInputState.notDecided,
      'G': WordInputState.notDecided,
      'H': WordInputState.notDecided,
      'J': WordInputState.notDecided,
      'K': WordInputState.notDecided,
      'L': WordInputState.notDecided,
      'Z': WordInputState.notDecided,
      'X': WordInputState.notDecided,
      'C': WordInputState.notDecided,
      'V': WordInputState.notDecided,
      'B': WordInputState.notDecided,
      'N': WordInputState.notDecided,
      'M': WordInputState.notDecided
    };
    _generateWord();
    update();
  }

  void _loadWordHistory() {
    wordHistory.value = box.read('wordHistory') ?? [];
  }
}
